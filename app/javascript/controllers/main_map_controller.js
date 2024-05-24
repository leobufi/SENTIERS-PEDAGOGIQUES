import { Controller } from "@hotwired/stimulus"
// import 'maplibre-gl/dist/maplibre-gl.css';
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="main-map"
export default class extends Controller {
  static targets = ["canva", "infos"]

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
    this.activateInfos();
  }

  addMarkersToMap() {
    this.sentierCoordinatesValue.forEach((sentier) => {
      sentier.forEach((coord) => {
        if (coord.type === 'departure') {
          new mapboxgl.Marker({ color: '#B9D994' })
            .setLngLat([coord.lng, coord.lat])
            .addTo(this.map);
        }
        if (coord.type === 'arrival') {
          new mapboxgl.Marker({ color: '#D994B9' })
            .setLngLat([coord.lng, coord.lat])
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
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
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
          this.infosTargets.forEach(infos => {
            if (infos.dataset.tabName ===  sentier[0].title) {
              infos.dataset.distance = distance;
              infos.dataset.duration = duration;
            }
          });

          const coordinates = route.geometry.coordinates;
          const line = {
            type: 'Feature',
            properties: {},
            geometry: {
              type: 'LineString',
              coordinates: coordinates
            }
          };
          this.map.addSource(`${sentier[0].id}`, {
            type: 'geojson',
            data: {
              type: 'FeatureCollection',
              features: [line]
            }
          });
          this.map.addLayer({
            id: `${sentier[0].id}` ,
            type: 'line',
            source: `${sentier[0].id}`,
            layout: {
              'line-join': 'round',
              'line-cap': 'round'
            },
            paint: {
              'line-color': `${sentier[0].color}`,
              'line-width': 5
            }
          });
        });
    });
  }

  activateInfos() {
    // console.log(this.map)
  }
}
