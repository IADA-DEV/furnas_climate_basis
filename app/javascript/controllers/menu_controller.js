import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["link", "submenu", "toggle", "sidebar"];

    toggleSubmenu(event) {
        const clickedLink = event.currentTarget;
        const containingLi = clickedLink.closest('li');
        const relatedSubmenu = containingLi.nextElementSibling;

        if (relatedSubmenu && relatedSubmenu.classList.contains('desable')) {
            relatedSubmenu.classList.remove('desable');
        } else if (relatedSubmenu) {
            relatedSubmenu.classList.add('desable');
        }
    }

    toggleSidebar() {
        this.element.classList.toggle('close');
    }

}