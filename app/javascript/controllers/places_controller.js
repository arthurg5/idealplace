import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["list", "map", "marker"]

  connect() {
  }

  selectCard(event) {
    event.preventDefault();
    const url = event.currentTarget.href;
    const id = Number.parseInt(event.currentTarget.id);
    fetch(url, {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.getElementsByName('csrf-token')[0].content,
        accept: "text/plain"
      }
    }).then(response => response.text())
    .then((data) => {
      this.listTarget.outerHTML = data;
      const placeMarker = Array.from(this.markerTargets).find((marker) => marker.dataset.id == id);
      placeMarker.classList.add("active");
      placeMarker.click();
    })
  }
}
