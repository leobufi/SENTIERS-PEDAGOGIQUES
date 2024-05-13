import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["link", "dropright", "title"]

  connect() {
    this.titleTargets.forEach((title) => {
      if (window.location.href.includes(title.id)) {
        // console.log(title)
        title.classList.add("active-black");
      }
    });
  }

  dropright(event) {
    event.preventDefault()
    const link = event.target
    console.log(link)
    this.linkTargets.forEach((linkTarget) => {
      linkTarget.classList.add("active")
    })
    this.droprightTargets.forEach((dropright) => {
      dropright.classList.add("active")
    })
  }

  removeDropright(event) {
    event.preventDefault()
    const link = event.target
    console.log(link)
    this.linkTargets.forEach((linkTarget) => {
      linkTarget.classList.remove("active")
    })
    this.droprightTargets.forEach((dropright) => {
      dropright.classList.remove("active")
    })
  }
}