import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="handle-form"
export default class extends Controller {
  // hideForm() {
  //   this.element.parentElement.removeAttribute("src")
  //   this.element.remove()
  // }

  // hide modal on successful form submission
  // action: "turbo:submit-end->handle-form#submitEnd"
  submitEnd(e) {
    if (e.detail.success) {
      this.element.reset();
    }
  }
}
