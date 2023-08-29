import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ['dataInicioField'];

    connect() {
        this.dataInicioFieldTarget.addEventListener('change', this.submitForm);
    }

    disconnect() {
        this.dataInicioFieldTarget.removeEventListener('change', this.submitForm);
    }

    submitForm = () => {
        const form = this.dataInicioFieldTarget.closest('form');
        form.requestSubmit();
    };
}
