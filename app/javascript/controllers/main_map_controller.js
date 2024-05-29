import { Controller } from "@hotwired/stimulus"
// import 'maplibre-gl/dist/maplibre-gl.css';
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="main-map"
export default class extends Controller {
  static targets = ["canva", "infos", "image", "tab"]

  static values = {
    apiKey: String,
    sentierCoordinates: Array,
    pointsCoordinates: Array,
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.canvaTarget,
      style: 'mapbox://styles/leobufi/clwg4fwi600h101ny4wooeivf',
      zoom: 11.5,
    });

    this.addMarkersToMap();
    this.fitMapToMarkers();
    this.addRoutesToMap();
    this.addGeolocate();

  }

  addMarkersToMap() {
    this.sentierCoordinatesValue.forEach((sentier) => {
      sentier.forEach((coord) => {
        if (coord.type === 'departure') {
          const popup = new mapboxgl.Popup()
            .setHTML(`
            <h6>Départ du sentier ${coord.title} :</h6>
            <h6>${coord.address}</h6>
            `);
          new mapboxgl.Marker({ color: '#B9D994' })
          .setLngLat([coord.lng, coord.lat])
          .setPopup(popup)
          .addTo(this.map);
        }
        if (coord.type === 'arrival') {
          const popup = new mapboxgl.Popup()
            .setHTML(`
            <h6>Arrivée du sentier ${coord.title} :</h6>
            <h6>${coord.address}</h6>
            `);
          new mapboxgl.Marker({ color: '#D994B9' })
            .setLngLat([coord.lng, coord.lat])
            .setPopup(popup)
            .addTo(this.map);
        }
        if (coord.type === 'arrival' && coord.boucle === true) {
          const popup = new mapboxgl.Popup()
            .setHTML(`
            <h6>Départ/Arrivée du sentier ${coord.title} :</h6>
            <h6>${coord.address}</h6>
            `);
          new mapboxgl.Marker({ color: '#B9D994' })
            .setLngLat([coord.lng, coord.lat])
            .setPopup(popup)
            .addTo(this.map);
        }
      });
    })

    this.pointsCoordinatesValue.forEach((point) => {
      const popup = new mapboxgl.Popup().setHTML(point.info_window_html);
      new mapboxgl.Marker({ color: '#94B9D9' })
        .setLngLat([point.lng, point.lat])
        .setPopup(popup)
        .addTo(this.map);
    })
  }

  fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.sentierCoordinatesValue.forEach((sentier) => {
      sentier.forEach(marker => bounds.extend([marker.lng, marker.lat]))
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 13.5, duration: 0 })
    })
  }

  addRoutesToMap() {
    this.sentierCoordinatesValue.forEach(sentier => {
      let query = "";
      sentier.forEach(point => {
        query += `${point.lng},${point.lat};`;
      });
      query = query.slice(0, -1);
      fetch(`https://api.mapbox.com/directions/v5/mapbox/walking/${query}?annotations=distance%2Cduration&geometries=geojson&overview=full&steps=true&access_token=${this.apiKeyValue}`)
        .then(response => response.json())
        .then(data => {
          const route = data.routes[0];
          const distance = route.distance;
          const duration = route.duration;
          const title = sentier[0].title;
          const routeLayerId = `${sentier[0].id}`;
          const coordinates = route.geometry.coordinates;

          const line = {
            type: 'Feature',
            properties: { id: sentier[0].id },
            geometry: {
              type: 'LineString',
              coordinates: coordinates
            }
          };

          this.map.addSource(routeLayerId, {
            type: 'geojson',
            data: {
              type: 'FeatureCollection',
              features: [line]
            }
          });

          this.map.addLayer({
            id: routeLayerId ,
            type: 'line',
            source: routeLayerId,
            layout: {
              'line-join': 'round',
              'line-cap': 'round'
            },
            paint: {
              'line-color': `${sentier[0].color}`,
              'line-width': 5
            }
          });

          this.activateRoute(routeLayerId);
          this.transferInfos(title, distance, duration);
          this.activateInfos(routeLayerId, title);
        });
    });
  }

  addGeolocate() {
    this.map.addControl(
      new mapboxgl.GeolocateControl({
        positionOptions: {
          enableHighAccuracy: true,
        },
        trackUserLocation: true,
        showUserHeading: true
      })
    );
  }

  activateRoute(routeLayerId) {
    this.map.on('mousemove', routeLayerId, (e) => {
      this.map.getCanvas().style.cursor = 'pointer';
      this.map.setPaintProperty(routeLayerId, 'line-width', 8);
      this.map.moveLayer(routeLayerId);
    });

    this.map.on('mouseleave', routeLayerId, () => {
      this.map.getCanvas().style.cursor = '';
      this.map.setPaintProperty(routeLayerId, 'line-width', 5);
      this.map.moveLayer(routeLayerId);
    });
  }

  activateInfos(routeLayerId, title) {
    this.map.on('mousemove', routeLayerId, (e) => {
      this.tabTargets.forEach(tab => {
        if (tab.dataset.tabName === title) {
          tab.classList.add('active');
        } else if (tab.dataset.tabName != title) {
          tab.classList.remove('active');
        }
      })
      this.infosTargets.forEach(infos => {
        if (infos.dataset.tabName === title) {
          infos.classList.add('active');
        } else if (infos.dataset.tabName != title) {
          infos.classList.remove('active');
        }
      });
      this.imageTargets.forEach(image => {
        if (image.dataset.tabName === title) {
          image.classList.add('active');
        } else if (image.dataset.tabName != title) {
          image.classList.remove('active');
        }
      });
    });

    this.tabTargets.forEach(tab => {
      tab.addEventListener('mousemove', (e) => {
        if (tab.dataset.tabName === title) {
          this.map.setPaintProperty(routeLayerId, 'line-width', 8);
          this.map.moveLayer(routeLayerId);
        }
      })
      tab.addEventListener('mouseleave', (e) => {
        if (tab.dataset.tabName === title) {
          this.map.setPaintProperty(routeLayerId, 'line-width', 5);
          this.map.moveLayer(routeLayerId);
        }
      })

    });
  }

  transferInfos(title, distance, duration) {
    this.infosTargets.forEach(infos => {
      if (infos.dataset.tabName === title) {
        infos.dataset.distance = distance;
        infos.dataset.duration = duration;
      }
    });
  }
}
