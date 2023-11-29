import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checkbox-votes"
export default class extends Controller {
  // static targets = ["inputVote", "formVote"]

  connect() {
    // console.log(this.inputVoteTarget)
    // console.log(this.formVoteTarget)
    console.log("hello");
  }

  check() {
    console.log("hi");
    // const isChecked = this.inputVoteTarget.checked;

    // this.inputVoteTargets.forEach((checkbox) => {
    //   checkbox.checked = isChecked;
    //   if (isChecked) {
    //     checkbox.classList.add("checked");
    //   } else {
    //     checkbox.classList.remove("checked");
    //   }
    // });
  }
}
