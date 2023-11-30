import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="create-event-name"
export default class extends Controller {
  static targets = ["input"]

  connect() {
    console.log("hi");
  }
  setCookie() {
    localStorage.setItem('eventName', this.inputTarget.value);
  }
}
