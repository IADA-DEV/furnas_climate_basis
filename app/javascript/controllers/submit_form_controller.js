import { Controller } from "@hotwired/stimulus";


export default class extends Controller {
    static targets = ["cdgStation", "dataInicioField", "dataFimField", "amostragem"];
    connect() {
        $("#subscriber-tags-select").on('select2:select', function () {
            let event = new Event('change', { bubbles: true }) // fire a native event
            this.dispatchEvent(event);
        });

        $("#amostragem-select").on('select2:select', function () {
            let event = new Event('change', { bubbles: true }) // fire a native event
            this.dispatchEvent(event);
        });

        this.cdgStationTarget.addEventListener("change", this.handleInputChange.bind(this));
        this.dataInicioFieldTarget.addEventListener("change", this.handleInputChange.bind(this));
        this.dataFimFieldTarget.addEventListener("change", this.handleInputChange.bind(this));
        this.amostragemTarget.addEventListener("change", this.handleInputChange.bind(this));

    }

    handleInputChange(event) {
        const form = this.cdgStationTarget.closest('form');
        form.requestSubmit();
    }
}