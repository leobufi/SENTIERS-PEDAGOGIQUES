# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "bootstrap" # @5.3.3
pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "swiper.js" # @1.0.0
pin "swiper" # @11.1.3
pin "mapbox-gl" # @3.1.2
pin "process" # @2.0.1
pin "cocoon", preload: true # @0.1.1
pin "jquery", to: "https://code.jquery.com/jquery-3.6.0.min.js", preload: true # @3.7.1
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
