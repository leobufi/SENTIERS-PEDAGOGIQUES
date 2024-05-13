import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets = ["tab", "panel"]

  connect() {
    console.log('Hi from Tab Controller')
  }


  activate(event) {
    event.preventDefault()
    const tab = event.target
    this.tabTargets.forEach((tabTarget) => {
      console.log(tabTarget.dataset.tabName)
      // tabTarget.classList.toggle("active", tabTarget == tab)
      if (tabTarget.dataset.tabName == tab.dataset.tabName) {
        tabTarget.classList.toggle("active")
      } else {
        tabTarget.classList.remove("active")
      }
    })

    this.panelTargets.forEach((panel) => {
      // console.log(panel.dataset.tabName)
      if (panel.dataset.tabName == tab.dataset.tabName) {
        panel.classList.toggle("active")
      } else {
        panel.classList.remove("active")
      }
    })
  }
}
