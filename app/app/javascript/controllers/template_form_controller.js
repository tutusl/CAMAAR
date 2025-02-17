import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  addQuestion(event) {
    event.preventDefault();

    // Clona o último campo de questão
    const questaoFields = document.querySelectorAll(".questao-fields");
    const lastQuestao = questaoFields[questaoFields.length - 1];
    const newQuestao = lastQuestao.cloneNode(true);

    // Limpa os valores dos campos clonados
    newQuestao.querySelectorAll("input, textarea, select").forEach((field) => {
      field.value = "";
    });

    // Insere a nova questão antes do botão "Adicionar Questão"
    const addButton = this.element.querySelector(".add-questao");
    this.element.insertBefore(newQuestao, addButton);
  }

  removeQuestion(event) {
    event.preventDefault();
    event.target.closest(".questao-fields").remove();
  }
}
