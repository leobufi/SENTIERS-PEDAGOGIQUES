// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"
import "jquery";
// import "cocoon";
import "@nathanvda/cocoon"
import "@hotwired/turbo-rails"

import "trix"
import "@rails/actiontext"

document.addEventListener("turbo:load", () => {
  const el = document.querySelector(".cf-turnstile");
  if (el) {
    el.innerHTML = "";

    turnstile.render(el, {
      sitekey: "0x4AAAAAABwylfQ9a4Haclv7",
    });
  }
});
