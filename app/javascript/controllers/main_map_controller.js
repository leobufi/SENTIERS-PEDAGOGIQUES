import { Controller } from "@hotwired/stimulus"
// import 'maplibre-gl/dist/maplibre-gl.css';
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="main-map"
export default class extends Controller {

  static values = {
    apiKey: String,
    sentierCoordinates: Array,
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/leobufi/clwg4fwi600h101ny4wooeivf',
      center: [5.3704612093566615, 43.30256969726123],
      zoom: 11,
    });

    this.addMarkersToMap();
    this.addRoutesToMap();
  }

  addMarkersToMap() {
    this.sentierCoordinatesValue.forEach((sentier) => {
      // Créer des marqueurs pour les points intermédiaires
      sentier.forEach((coord) => {
        if (coord.type === 'departure') {
          new mapboxgl.Marker({ color: 'green' })
            .setLngLat([coord.lng, coord.lat])
            .addTo(this.map);
        }
        if (coord.type === 'arrival') {
          new mapboxgl.Marker({ color: 'red' })
            .setLngLat([coord.lng, coord.lat])
            .addTo(this.map);
        }
        if (coord.type === 'point') {
          new mapboxgl.Marker({ color: 'blue' })
            .setLngLat([coord.lng, coord.lat])
            .addTo(this.map);
        }
      });
    })
  }

  addRoutesToMap() {
    this.sentierCoordinatesValue.forEach(sentier => {
      let query = "";
      sentier.forEach(point => {
        query += `${point.lng},${point.lat};`;
      });
      query = query.slice(0, -1);
      fetch(`https://api.mapbox.com/directions/v5/mapbox/walking/${query}?annotations=distance&geometries=geojson&overview=full&steps=false&access_token=${this.apiKeyValue}`)
        .then(response => response.json())
        .then(data => {
          const route = data.routes[0];
          const coordinates = route.geometry.coordinates;
          const line = {
            type: 'Feature',
            properties: {},
            geometry: {
              type: 'LineString',
              coordinates: coordinates
            }
          };
          this.map.addSource('route', {
            type: 'geojson',
            data: {
              type: 'FeatureCollection',
              features: [line]
            }
          });
          this.map.addLayer({
            id: 'route',
            type: 'line',
            source: 'route',
            layout: {
              'line-join': 'round',
              'line-cap': 'round'
            },
            paint: {
              'line-color': '#94B9D9',
              'line-width': 5
            }
          });
        });

    });
  }
}
