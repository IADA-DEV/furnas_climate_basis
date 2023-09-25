import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

    confirmDelete(event) {
        const logId = event.currentTarget.dataset.logId;

        Swal.fire({
            title: 'Você tem certeza?',
            text: "Essa ação não pode ser desfeita!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sim, delete!',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                this.deleteLog(logId);
            }
        });
    }

    deleteLog(logId) {
        const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");

        fetch(`/log_erros/${logId}`, {
            method: 'DELETE',
            headers: {
                'X-CSRF-Token': csrfToken
            }
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Erro ao deletar Log');
                }
                return response.json();
            })
            .then(data => {
                Swal.fire({
                    icon: 'success',
                    title: data.message,
                    allowOutsideClick: false,
                    allowEscapeKey: false
                }).then(result => {
                    if (result.isConfirmed) {
                        location.reload();
                    }
                });
            })
            .catch(error => {
                Swal.fire({
                    icon: 'error',
                    title: 'Erro ao deletar Log',
                    text: error.message
                });
            });
    }
}
