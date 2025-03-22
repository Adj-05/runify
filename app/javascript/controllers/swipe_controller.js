import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="swipe"
export default class extends Controller {
  static targets = ["input1", "averageSpeed", "trainingDuration", "musicGenre", "button1", "button2", "progressBar", "form"];

  connect() {
    this.screens = [this.averageSpeedTarget, this.trainingDurationTarget, this.musicGenreTarget];
    this.currentScreenIndex = 0;
    this.userId = this.element.dataset.userId;
    this.updateScreens();
    console.log("Stimulus controller connected");
  }

  // swipe1() {
  //   setTimeout(() => {
  //     console.log("Retardée d'une seconde.");
  //     this.averageSpeedTarget.classList.add("d-none");
  //     this.trainingDurationTarget.classList.remove("d-none");
  //     this.button1Target.classList.remove("d-none");
  //   }, "1000");

  // }

  // swipe2() {
  //   setTimeout(() => {
  //     console.log("Retardée d'une seconde.");
  //     this.trainingDurationTarget.classList.add("d-none");
  //     this.button1Target.classList.add("d-none");
  //     this.button2Target.classList.remove("d-none");
  //     this.musicGenreTarget.classList.remove("d-none");
  //   }, "1000");

  // }

  // back1() {
  //   this.averageSpeedTarget.classList.remove("d-none");
  //   this.trainingDurationTarget.classList.add("d-none");
  //   this.button1Target.classList.add("d-none");
  // }

  // back2() {
  //   this.trainingDurationTarget.classList.remove("d-none");
  //   this.musicGenreTarget.classList.add("d-none");
  //   this.button2Target.classList.add("d-none");
  //   this.button1Target.classList.remove("d-none");
  // }

  // sendForm(event) {
  //   event.preventDefault();
  //   this.updateSelection(event);
  //   setTimeout(() => this.redirectToPreview(), 200);
  // }

  swipe1(event) {
    this.updateSelection(event);
    setTimeout(() => this.nextScreen(), 200);
  }

  swipe2(event) {
    this.updateSelection(event);
    setTimeout(() => this.nextScreen(), 200);
  }


  back1() {
    this.previousScreen();
  }

  back2() {
    this.previousScreen();
  }

  nextScreen() {
    if (this.currentScreenIndex < this.screens.length - 1) {
      this.currentScreenIndex++;
      this.updateScreens();
    }
  }

  previousScreen() {
    if (this.currentScreenIndex > 0) {
      this.currentScreenIndex--;
      this.updateScreens();
    }
  }

  updateScreens() {
    this.screens.forEach((screen, index) => {
      screen.style.display = index === this.currentScreenIndex ? "flex" : "none";
    });

    this.progressBarTarget.innerText = `${this.currentScreenIndex + 1} / ${this.screens.length}`;

    this.button1Target.style.display = this.currentScreenIndex > 0 ? "block" : "none";
    this.button2Target.style.display = this.currentScreenIndex > 1 ? "block" : "none";
  }

  updateSelection(event) {
    const selectedInput = event.target;
    const allInputs = selectedInput.closest(".options").querySelectorAll("input");

    allInputs.forEach(input => {
      const label = input.nextElementSibling;
      if (label) {
        label.style.background = "#1E1E1E";
        label.style.color = "white";
      }
    });

    const selectedLabel = selectedInput.nextElementSibling;
    if (selectedLabel) {
      selectedLabel.style.background = "#64dd17";
      selectedLabel.style.color = "white";
    }
  }

  sendForm(event) {
    event.preventDefault();

    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => {
        return response.text();
      })
      .then((data) => {
        document.querySelector('html').innerHTML = data
   } )
      .catch(error => {
        console.error(error);
      });
  }
}
