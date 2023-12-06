import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    const timeInput = this.element.querySelector('#event_start_time');

    flatpickr(timeInput, {
      enableTime: true,
      noCalendar: true,
      dateFormat: "H:i",
      time_24hr: true
      // Other configuration options if needed
    });
  }
}
