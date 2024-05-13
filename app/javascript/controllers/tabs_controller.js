import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets = ["tab", "panel", "image"]

  connect() {
    console.log('Hi from Tab Controller')
  }


  activate(event) {
    event.preventDefault()
    const tab = event.target
    // console.log(tab.dataset.tabName)
    this.tabTargets.forEach((tabTarget) => {
      if (tabTarget.dataset.tabName == tab.dataset.tabName) {
        // console.log(tabTarget.dataset.tabName)
        tabTarget.classList.toggle("active")
        tabTarget.checked = true
      } else {
        tabTarget.classList.remove("active")
        tabTarget.checked = false
      }
    })

    this.panelTargets.forEach((panel) => {
      if (panel.dataset.tabName == tab.dataset.tabName) {
        // console.log(panel.dataset.tabName)
        panel.classList.toggle("active")
      } else {
        panel.classList.remove("active")
      }
    })

    this.imageTargets.forEach((image) => {
      if (image.dataset.tabName == tab.dataset.tabName) {
        // console.log(image.dataset.tabName)
        image.classList.toggle("active")
      } else {
        image.classList.remove("active")
      }
    })
  }
}
