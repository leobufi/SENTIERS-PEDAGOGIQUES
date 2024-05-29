import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["link", "dropright", "title"]

  connect() {
    this.activeUrl();
  }

  dropright(event) {
    event.preventDefault()
    const link = event.target
    // console.log(link)
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
    // console.log(link)
    this.linkTargets.forEach((linkTarget) => {
      linkTarget.classList.remove("active")
    })
    this.droprightTargets.forEach((dropright) => {
      dropright.classList.remove("active")
    })
  }

  activeUrl() {
    const url = window.location.href;

    if (url.includes('localhost:3000')) {
      const id = url.split('3000/')[1];
      this.titleTargets.forEach((title) => {
        if (id.includes(title.id)) {
          title.classList.add("active-black");
        }
      });
    } else if (url.includes('pedagogiques')) {
      const id = url.split('pedagogiques')[1];
      this.titleTargets.forEach((title) => {
        if (id.includes(title.id)) {
          title.classList.add("active-black");
        }
      });
    }

  }
}
