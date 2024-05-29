import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mobile-nav"
export default class extends Controller {
  static targets = ["menu", "cross", "burger"]

  connect() {
  }

  activate() {
    this.menuTargets.forEach((menu) => {
      menu.classList.toggle("active");
    })
    this.crossTarget.classList.toggle("active");
    this.burgerTarget.classList.toggle("rotated-down");
  }


}
