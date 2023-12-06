import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["list", "card"]


  connect() {
    this.ids_array = this.cardTargets.map((card)=> {
      return card.dataset.id
    })
  }

  selectCard(event) {
    event.preventDefault();
    const url = event.currentTarget.href;
    const body = {
      ids_array: this.ids_array,
      category: new URLSearchParams(window.location.search).get("category") || "none"
    }
    console.log(body)
    fetch(url, {
      method: "POST",
      body: JSON.stringify(body),
      headers: {
        "X-CSRF-Token": document.getElementsByName('csrf-token')[0].content,
        "Content-Type": "application/json",
        accept: "text/plain"
      }
    }).then(response => response.text())
    .then((data) => {
      this.listTarget.outerHTML = data;
    })
  }
}
