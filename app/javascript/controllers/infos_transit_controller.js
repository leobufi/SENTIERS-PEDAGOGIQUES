import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="infos-transit"
export default class extends Controller {
  static targets = ["data", "duration", "lenght"]

  connect() {
    setTimeout(() => {
      this.dataTargets.forEach((data) => {
        const distanceValue = data.getAttribute("data-distance");
        const durationValue = data.getAttribute("data-duration");

        const durationElement = document.createElement("span");
        const duration = this.secondsInHours(durationValue);
        durationElement.textContent = `${duration}`;
        this.durationTargets.forEach((duration) => {
          if (duration.dataset.name === data.dataset.tabName) {
            duration.appendChild(durationElement);
          }
        })

        const distanceElement = document.createElement("span");
        const distanceInKm = distanceValue / 1000;
        const distance = distanceInKm.toFixed(2);
        distanceElement.textContent = `${distance} km`;
        this.lenghtTargets.forEach((distance) => {
          if (distance.dataset.name === data.dataset.tabName) {
            distance.appendChild(distanceElement);
          }
        });
      })
    }, 750);
  }

  secondsInHours(element) {
    const hours = Math.floor(element / 3600);
    const minutes = Math.floor((element % 3600) / 60);
    return `${hours}h ${minutes}min`;
  }
}
