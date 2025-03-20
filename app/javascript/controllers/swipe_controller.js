import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="swipe"
export default class extends Controller {
  static targets = ["form", "averageSpeed", "trainingDuration", "musicGenre", "button1", "button2"]

  swipe1() {
    setTimeout(() => {
      console.log("Retardée d'une seconde.");
      this.averageSpeedTarget.classList.add("d-none");
      this.trainingDurationTarget.classList.remove("d-none");
      this.button1Target.classList.remove("d-none");
    }, 1000);
  }

  swipe2() {
    setTimeout(() => {
      console.log("Retardée d'une seconde.");
      this.trainingDurationTarget.classList.add("d-none");
      this.button1Target.classList.add("d-none");
      this.button2Target.classList.remove("d-none");
      this.musicGenreTarget.classList.remove("d-none");
    }, 1000);
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

  sendForm(event) {
    event.preventDefault(); // Empêche toute action par défaut du formulaire

    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
    .then(response => {
      if (!response.ok) throw new Error("Erreur lors de l'envoi du formulaire");
      return response.json();
    })
    .then(data => {
      if (data.id) {
        window.location.href = `/trainings/${data.id}/preview`; // ✅ Redirection vers training/:id/preview
      } else {
        console.error("L'ID du training est manquant dans la réponse.");
      }
    })
    .catch(error => {
      console.error(error);
    });
  }

  connect() {
    console.log("Stimulus controller connected");
  }
}
