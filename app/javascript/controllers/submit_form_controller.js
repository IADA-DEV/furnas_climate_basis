import { Controller } from "@hotwired/stimulus";


export default class extends Controller {
    static targets = ["cdgStation"];
    connect() {
        $("#subscriber-tags-select").on('select2:select', function () {
            console.log("list item selected");
            let event = new Event('change', { bubbles: true }) // fire a native event
            this.dispatchEvent(event);
        });

        this.cdgStationTarget.addEventListener("change", this.handleInputChange.bind(this));

    }

    handleInputChange(event) {
        console.log('entrei');
        const form = this.cdgStationTarget.closest('form');
        form.requestSubmit();
    }
}