import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["inicioField", "fimField"];

    connect() {
        this.inicioFieldTarget.addEventListener("change", this.handleInputChange.bind(this));
        this.fimFieldTarget.addEventListener("change", this.handleInputChange.bind(this));
    }

    handleInputChange(event) {
        const inicioValue = this.inicioFieldTarget.value;
        const fimValue = this.fimFieldTarget.value;

        if (inicioValue && fimValue) {
            const form = this.inicioFieldTarget.closest('form');
            console.log(form)
            form.requestSubmit();
        }
    }
}
