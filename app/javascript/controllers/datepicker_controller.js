import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    const dateInput = this.element.querySelector('#event_date');

    flatpickr(dateInput, {
      dateFormat: 'd-m-Y',
      minDate: 'today',
      theme: 'light',
      onClose: function(selectedDates) {
        // Additional logic if needed
      }
    });
  }
}
