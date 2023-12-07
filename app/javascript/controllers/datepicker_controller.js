import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    const dateInput = this.element.querySelector('#event_date');

    flatpickr(dateInput, {
      dateFormat: 'Y-m-d H:i',
      minDate: 'today',
      theme: 'light',
      inline: true,
      enableTime: true,
      time_24hr: true,
      defaultHour: 18,
      minuteIncrement: 15,
      onClose: function(selectedDates) {
        // Additional logic if needed
      }
    });
  }
}
