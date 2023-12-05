import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["list"]

  connect() {
  }

  selectCard(event) {
    event.preventDefault();
    const url = event.currentTarget.href;
    fetch(url, {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.getElementsByName('csrf-token')[0].content,
        accept: "text/plain"
      }
    }).then(response => response.text())
    .then((data) => {
      this.listTarget.outerHTML = data;
    })
  }
}
