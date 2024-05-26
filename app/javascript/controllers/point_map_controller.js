import { Controller } from "@hotwired/stimulus"
// import 'maplibre-gl/dist/maplibre-gl.css';
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="show-map"
export default class extends Controller {

  static values = {
    apiKey: String,
    pointCoordinates: Array,
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/leobufi/clwg4fwi600h101ny4wooeivf',
    });

    const point = this.pointCoordinatesValue;
    this.addMarkersToMap(point);
    this.fitMapToMarkers(point);
  }

  addMarkersToMap(point) {
    new mapboxgl.Marker({ color: '#94B9D9' })
      .setLngLat([point[1], point[0]])
      .addTo(this.map);
  }

  fitMapToMarkers(point) {
    const bounds = new mapboxgl.LngLatBounds()
    bounds.extend([point[1], point[0]]);
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 13, duration: 0 });
  }
}
