import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]
  open() {
    this.itemTarget.classList.remove("translate-x-full")
  }

  close() {
    this.itemTarget.classList.add("translate-x-full")
  }
}
