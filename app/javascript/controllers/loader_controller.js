import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["defaultContent", "loadingContent"];

  connect() {
    console.log("connected")
  }

  start() {
    this.defaultContentTarget.classList.add("d-none");
    this.loadingContentTarget.classList.remove("d-none");
  }
}
