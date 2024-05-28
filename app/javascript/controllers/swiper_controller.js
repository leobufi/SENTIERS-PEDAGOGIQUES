import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="swiper"
export default class extends Controller {
  connect() {

    this.swiper = new Swiper('.swiper', {
      // Optional parameters

      direction: 'horizontal',
      slidesPerView: 1,
      centeredSlides: true,
      allowSlideNext: true,
      allowSlidePrev: true,

      keyboard: {
        enabled: true,
      },

      effect: 'fade',
      fadeEffect: {
        crossFade: true
      },

      // If we need pagination
      pagination: {
        el: '.swiper-pagination',
      },

      // Navigation arrows
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });

    this.swiper.attachEvents();

  }
}
