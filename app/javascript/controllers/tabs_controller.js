import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets = ["tab", "toggledPanel", "panel", "image", "check", "coordinates"]

  connect() {
    this.mask();
  }

  activate(event) {
    event.preventDefault()
    const tab = event.target
    const tabName = tab.dataset.tabName

    if (!tabName) return

    const isSentierPublicPage = window.location.pathname.startsWith("/sentiers")

    const clickedTabTarget = this.tabTargets.find(
      (tabTarget) => tabTarget.dataset.tabName == tabName
    )

    // Si on reclique sur un onglet déjà actif : on ferme tout (toggle off)
    // 👉 Ce comportement est limité aux pages sentiers (index, thèmes, show)
    if (
      isSentierPublicPage &&
      clickedTabTarget &&
      clickedTabTarget.classList.contains("active")
    ) {
      this.tabTargets.forEach((tabTarget) => {
        tabTarget.classList.remove("active")
      })

      this.panelTargets.forEach((panel) => {
        panel.classList.remove("active")
      })

      this.imageTargets.forEach((image) => {
        image.classList.remove("active")
      })

      this.toggledPanelTargets.forEach((tabTarget) => {
        tabTarget.classList.remove("active")
      })

      // Sur mobile : remettre tous les panneaux dans le bloc de contenu
      this.resetMobileSentierInfos()
      return
    }

    // Sinon, comportement normal : activer l'onglet cliqué et son contenu
    this.tabTargets.forEach((tabTarget) => {
      if (tabTarget.dataset.tabName == tabName) {
        tabTarget.classList.add("active")
      } else {
        tabTarget.classList.remove("active")
      }
    })

    this.panelTargets.forEach((panel) => {
      if (panel.dataset.tabName == tabName) {
        panel.classList.add("active")
      } else {
        panel.classList.remove("active")
      }
    })

    this.imageTargets.forEach((image) => {
      if (image.dataset.tabName == tabName) {
        image.classList.add("active")
      } else {
        image.classList.remove("active")
      }
    })

    this.toggledPanelTargets.forEach((tabTarget) => {
      if (tabTarget.dataset.tabName == tabName) {
        tabTarget.classList.toggle("active")
      } else {
        tabTarget.classList.remove("active")
      }
    })

    // Sur mobile : placer le bloc d'infos juste sous le titre de sentier actif
    this.repositionMobileSentierInfos(tab)
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

  repositionMobileSentierInfos(tab) {
    // On ne touche à rien au‑delà du breakpoint mobile
    if (window.innerWidth > 460) return

    // On ne souhaite appliquer ce comportement que sur la page sentiers index
    const contentBloc = this.element.querySelector(".info_bloc.content-bloc")
    if (!contentBloc) {
      // Si on n'est pas sur l'index (ex: sentier show), on tente la logique pour les points
      this.repositionMobilePointInfosFromTabs(tab)
      return
    }

    const tabName = tab.dataset.tabName
    if (!tabName) return

    // Remettre tous les panneaux dans le bloc de contenu (état neutre)
    this.panelTargets.forEach((panel) => {
      if (!contentBloc.contains(panel)) {
        contentBloc.appendChild(panel)
      }
    })

    // Placer le panneau actif juste sous le titre actif (en tant qu'élément frère)
    const activeTitleBloc = tab.closest(".sentier-title_bloc")
    if (!activeTitleBloc) return

    const activePanel = this.panelTargets.find(
      (panel) => panel.dataset.tabName === tabName
    )

    if (activePanel) {
      activeTitleBloc.insertAdjacentElement("afterend", activePanel)
    }
  }

  repositionMobilePointInfosFromTabs(tab) {
    // Comportement uniquement sur mobile
    if (window.innerWidth > 460) return

    // Vérifier qu'on est bien sur une page avec liste de points (sentier show)
    const pointsList = document.querySelector(".points-list")
    if (!pointsList) return

    // Conteneur d'origine des blocs .point-infos (colonne centrale)
    const firstPointInfos = document.querySelector(".infos_wrapper .point-infos")
    if (!firstPointInfos) return
    const contentBloc = firstPointInfos.parentElement

    // Remettre tous les panneaux de points dans le bloc de contenu (état neutre)
    this.panelTargets.forEach((panel) => {
      if (panel.classList.contains("point-infos") && !contentBloc.contains(panel)) {
        contentBloc.appendChild(panel)
      }
    })

    const activeSpan = tab.closest("span")
    if (!activeSpan) return

    const tabName = activeSpan.dataset.tabName
    if (!tabName) return

    const activePanel = this.panelTargets.find(
      (panel) =>
        panel.classList.contains("point-infos") &&
        panel.dataset.tabName === tabName
    )

    // Placer le panneau d'infos du point juste après le span dans la colonne de gauche
    if (activePanel) {
      activeSpan.insertAdjacentElement("afterend", activePanel)
    }
  }

  resetMobileSentierInfos() {
    // Réinitialisation uniquement sur mobile
    if (window.innerWidth > 460) return

    const contentBloc = this.element.querySelector(".info_bloc.content-bloc")
    if (!contentBloc) return

    this.panelTargets.forEach((panel) => {
      if (!contentBloc.contains(panel)) {
        contentBloc.appendChild(panel)
      }
    })
  }
}