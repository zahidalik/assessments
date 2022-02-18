import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mobile-view"
export default class extends Controller {
  toggle() {
    document.getElementById("mobile-menu").classList.toggle("hidden");
    // console.log("it works")
    // this.changeableTarget.classList.toggle('hidden')
  }
}
