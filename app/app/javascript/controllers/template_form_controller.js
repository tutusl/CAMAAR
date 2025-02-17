import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  addQuestion(event) {
    event.preventDefault();
    const template = document.querySelector(".questao-fields").cloneNode(true);
    template.querySelector("input, textarea, select").value = "";
    document.querySelector(".questions-container").appendChild(template);
  }

  removeQuestion(event) {
    event.preventDefault();
    event.target.closest(".questao-fields").remove();
  }
}
