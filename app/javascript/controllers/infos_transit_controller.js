import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="infos-transit"
export default class extends Controller {
  static targets = ["data", "duration", "lenght"]

  connect() {
    // Observer pour détecter quand les attributs data-distance et data-duration sont définis
    this.dataTargets.forEach((data) => {
      // Observer les changements d'attributs sur chaque élément data
      const observer = new MutationObserver((mutations) => {
        mutations.forEach((mutation) => {
          if (mutation.type === 'attributes' && 
              (mutation.attributeName === 'data-distance' || mutation.attributeName === 'data-duration')) {
            this.processInfos(data);
          }
        });
      });

      // Observer les changements d'attributs data-distance et data-duration
      observer.observe(data, {
        attributes: true,
        attributeFilter: ['data-distance', 'data-duration']
      });

      // Traiter immédiatement si les données sont déjà présentes
      if (data.dataset.distance && data.dataset.duration) {
        this.processInfos(data);
      }
    });
  }

  processInfos(data) {
    const distanceValue = data.getAttribute("data-distance");
    const durationValue = data.getAttribute("data-duration");

    // Ne traiter que si les deux valeurs sont disponibles
    if (!distanceValue || !durationValue) return;

    // Vérifier si les éléments ont déjà été créés pour éviter les doublons
    const durationTarget = this.durationTargets.find(
      (duration) => duration.dataset.name === data.dataset.tabName
    );
    const lenghtTarget = this.lenghtTargets.find(
      (distance) => distance.dataset.name === data.dataset.tabName
    );

    if (!durationTarget || !lenghtTarget) return;

    // Vérifier si les spans existent déjà
    if (durationTarget.querySelector("span")) return;
    if (lenghtTarget.querySelector("span")) return;

    // Créer et ajouter l'élément durée
    const durationElement = document.createElement("span");
    const duration = this.secondsInHours(durationValue);
    durationElement.textContent = `${duration}`;
    durationTarget.appendChild(durationElement);

    // Créer et ajouter l'élément distance
    const distanceElement = document.createElement("span");
    const distanceInKm = distanceValue / 1000;
    const distance = distanceInKm.toFixed(2);
    distanceElement.textContent = `${distance} km`;
    lenghtTarget.appendChild(distanceElement);
  }

  secondsInHours(element) {
    const hours = Math.floor(element / 3600);
    const minutes = Math.floor((element % 3600) / 60);
    return `${hours}h ${minutes}min`;
  }
}
