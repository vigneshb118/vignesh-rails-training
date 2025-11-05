import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "iconOpen", "iconClosed"]
  static values = { open: Boolean }

  connect() {
    this.refresh()
  }

  toggle() {
    this.openValue = !this.openValue
    this.refresh()
  }

  refresh() {
    if (this.openValue) {
      this.contentTarget.style.maxHeight = this.contentTarget.scrollHeight + "px"
      this.iconOpenTarget.classList.remove("hidden")
      this.iconClosedTarget.classList.add("hidden")
    } else {
      this.contentTarget.style.maxHeight = "0px"
      this.iconOpenTarget.classList.add("hidden")
      this.iconClosedTarget.classList.remove("hidden")
    }
  }
}
