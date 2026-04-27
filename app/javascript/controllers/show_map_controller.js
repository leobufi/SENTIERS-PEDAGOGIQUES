import { Controller } from "@hotwired/stimulus"
// import 'maplibre-gl/dist/maplibre-gl.css';
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="show-map"
export default class extends Controller {
  static targets = ["canva", "infos", "pointInfos", "image", "checkbox"]

  static values = {
    apiKey: String,
    sentierCoordinates: Array,
    pointsCoordinates: Array,
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    this.pointMarkersByTitle = {};
    this.activePointPopup = null;

    this.map = new mapboxgl.Map({
      container: this.canvaTarget,
      style: 'mapbox://styles/leobufi/clwg4fwi600h101ny4wooeivf',
    });

    this.map.on('load', () => {
      this.addMarkersToMap();
      this.bindListToMapMarkers();
      this.fitMapToMarkers();
      this.addRoutesToMap();
      this.addGeolocate();
    });

  }

  addMarkersToMap() {
    this.sentierCoordinatesValue.forEach((coord) => {
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

    this.pointsCoordinatesValue.forEach((point) => {
      const popup = new mapboxgl.Popup().setHTML(point.info_window_html);
      const marker = new mapboxgl.Marker({ color: '#94B9D9' })
        .setLngLat([point.lng, point.lat])
        .setPopup(popup)
        .addTo(this.map);

      const title = marker._popup._content.firstChild.innerHTML;
      this.pointMarkersByTitle[title] = marker;

      this.activateInfos(popup, title);
    })
  }

  bindListToMapMarkers() {
    this.checkboxTargets.forEach((checkbox) => {
      if (checkbox.dataset.mapBound === "true") return;
      checkbox.dataset.mapBound = "true";

      checkbox.addEventListener("click", () => {
        const title = checkbox.dataset.tabName;
        const marker = this.pointMarkersByTitle[title];
        if (!marker) return;
        const popup = marker.getPopup();

        const lngLat = marker.getLngLat();
        this.map.flyTo({
          center: [lngLat.lng, lngLat.lat],
          essential: true,
        });

        this.closeOtherPointPopups(popup);

        if (!popup.isOpen()) {
          popup.addTo(this.map);
        }

        this.activePointPopup = popup;
      });
    });
  }

  fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.sentierCoordinatesValue.forEach((marker) => {
      bounds.extend([marker.lng, marker.lat]);
      if (window.innerWidth > 460) {
        this.map.fitBounds(bounds, { padding: { top: 70, bottom: 70, left: 70, right: 70 }, maxZoom: 13, duration: 0 })
      } else {
        this.map.fitBounds(bounds, { padding: { top: 160, bottom: 70, left: 70, right: 70 }, maxZoom: 13, duration: 0 })
      }
    });
  }

  addRoutesToMap() {
    const sentier = this.sentierCoordinatesValue;
    let query = "";
    this.sentierCoordinatesValue.forEach(point => {
      query += `${point.lng},${point.lat};`;
    })
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
          id: routeLayerId,
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

        this.transferInfos(title, distance, duration);
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

  activateInfos(popup, title) {
    popup.on('open', (e) => {
      this.closeOtherPointPopups(popup);
      this.activePointPopup = popup;

      this.checkboxTargets.forEach(checkbox => {
        if (checkbox.dataset.tabName === title) {
          checkbox.classList.add("active");
        } else if (checkbox.dataset.tabName != title) {
          checkbox.classList.remove("active");
        }
      })
      this.pointInfosTargets.forEach(infos => {
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

      // Sur mobile : placer le bloc d'infos du point juste sous le point cliqué
      this.repositionMobilePointInfos(title);
    });
  }

  closeOtherPointPopups(currentPopup) {
    Object.values(this.pointMarkersByTitle).forEach((marker) => {
      const markerPopup = marker.getPopup();
      if (!markerPopup || markerPopup === currentPopup) return;
      if (markerPopup.isOpen()) markerPopup.remove();
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

  repositionMobilePointInfos(title) {
    // Comportement uniquement sur mobile
    if (window.innerWidth > 460) return

    // Conteneur d'origine des blocs .point-infos (colonne centrale)
    const firstPointInfos = document.querySelector(".infos_wrapper .point-infos")
    if (!firstPointInfos) return
    const contentBloc = firstPointInfos.parentElement

    // Remettre tous les panneaux dans le bloc de contenu (état neutre)
    this.pointInfosTargets.forEach((panel) => {
      if (!contentBloc.contains(panel)) {
        contentBloc.appendChild(panel)
      }
    })

    // Trouver le span de la liste correspondant au point
    const activeCheckbox = this.checkboxTargets.find(
      (checkbox) => checkbox.dataset.tabName === title
    )
    if (!activeCheckbox) return

    // Trouver le panneau d'infos correspondant
    const activePanel = this.pointInfosTargets.find(
      (panel) => panel.dataset.tabName === title
    )

    // Le placer juste après le span dans la colonne de gauche
    if (activePanel) {
      activeCheckbox.insertAdjacentElement("afterend", activePanel)
    }
  }
}
