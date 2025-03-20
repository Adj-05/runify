import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="swipe"
export default class extends Controller {
static targets = ["input1", "form", "averageSpeed", "trainingDuration", "musicGenre", "button1", "button2"]


swipe1() {
  setTimeout(() => {
    console.log("Retardée d'une seconde.");
    this.averageSpeedTarget.classList.add("d-none");
    this.trainingDurationTarget.classList.remove("d-none");
    this.button1Target.classList.remove("d-none");
  }, "1000");

}

swipe2() {
  setTimeout(() => {
  console.log("Retardée d'une seconde.");
  this.trainingDurationTarget.classList.add("d-none");
  this.button1Target.classList.add("d-none");
  this.button2Target.classList.remove("d-none");
  this.musicGenreTarget.classList.remove("d-none");
}, "1000");

}

back1() {
    this.averageSpeedTarget.classList.remove("d-none");
    this.trainingDurationTarget.classList.add("d-none");
    this.button1Target.classList.add("d-none");
}

back2() {
    this.trainingDurationTarget.classList.remove("d-none");
    this.musicGenreTarget.classList.add("d-none");
    this.button2Target.classList.add("d-none");
    this.button1Target.classList.remove("d-none");
}

sendForm() {
  fetch(this.formTarget.action, {
    method: "POST", // Could be dynamic with Stimulus values
    headers: { "Accept": "application/json" },
    body: new FormData(this.formTarget)
  })
  //   .then(response => response.json())
  //   .then((data) => {
  //     console.log(data)
  //   })
}

  connect() {
    console.log(this.input1Targets)
    console.log(this.formTarget)
  }
}
