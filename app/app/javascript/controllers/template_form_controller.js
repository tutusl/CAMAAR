import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  addQuestion(event) {
    event.preventDefault();
    const questaoFields = document.querySelectorAll(".questao-fields");
    const lastQuestao = questaoFields[questaoFields.length - 1];
    const template = lastQuestao.cloneNode(true);
    template.querySelectorAll("input, textarea, select").forEach((field) => {
      field.value = "";
    });
    document.querySelector(".questions-container").appendChild(template);
  }

  removeQuestion(event) {
    event.preventDefault();
    event.target.closest(".questao-fields").remove();
  }
}
