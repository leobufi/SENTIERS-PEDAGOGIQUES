import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets = ["tab", "panel", "image", "check", "coordinates"]

  connect() {
 this.mask();
  }


  activate(event) {
    event.preventDefault()
    const tab = event.target

    this.tabTargets.forEach((tabTarget) => {
      if (tabTarget.dataset.tabName == tab.dataset.tabName) {
        // console.log(tabTarget.dataset.tabName)
        tabTarget.classList.add("active")
      } else if (tabTarget.dataset.tabName != tab.dataset.tabName) {
        tabTarget.classList.remove("active")
      }
    })

    this.panelTargets.forEach((panel) => {
      if (panel.dataset.tabName == tab.dataset.tabName) {
        // console.log(panel.dataset.tabName)
        panel.classList.add("active")
      } else if (panel.dataset.tabName != tab.dataset.tabName) {
        panel.classList.remove("active")
      }
    })

    this.imageTargets.forEach((image) => {
      if (image.dataset.tabName == tab.dataset.tabName) {
        // console.log(image.dataset.tabName)
        image.classList.add("active")
      } else if (image.dataset.tabName != tab.dataset.tabName) {
        image.classList.remove("active")
      }
    })

  }

  mask() {
    this.checkTargets.forEach((check) => {
      if (check.value === "true" && check.checked) {
        this.coordinatesTarget.classList.add("masked")
     } else if (check.value === "false" && check.checked) {
        this.coordinatesTarget.classList.remove("masked")
     }
    })
  }
}
