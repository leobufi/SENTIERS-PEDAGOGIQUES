import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="infos-transit"
export default class extends Controller {
  static targets = ["data", "duration", "lenght"]

  connect() {
    setTimeout(() => {
      const distanceValue = this.dataTarget.getAttribute("data-distance");
      const durationValue = this.dataTarget.getAttribute("data-duration");

      const durationElement = document.createElement("span");
      const duration = this.secondsInHours(durationValue);
      durationElement.textContent = `${duration}`;
      this.durationTarget.appendChild(durationElement);

      const distanceElement = document.createElement("span");
      const distanceInKm = distanceValue / 1000;
      const distance = distanceInKm.toFixed(2);
      distanceElement.textContent = `${distance} km`;
      this.lenghtTarget.appendChild(distanceElement);
    }, 500);
  }

  secondsInHours(element) {
    const hours = Math.floor(element / 3600);
    const minutes = Math.floor((element % 3600) / 60);
    return `${hours}h ${minutes}min`;
  }
}
