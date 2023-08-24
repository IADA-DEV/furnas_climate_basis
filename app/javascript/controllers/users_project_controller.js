// users_project_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  submit(event) {
    event.preventDefault();

    let form = event.target;
    let formData = new FormData(form);

    fetch(form.action, {
      method: 'POST',
      body: formData,
      headers: {
        'Accept': 'application/json',
        'X-CSRF-Token': formData.get("authenticity_token")
      },
      credentials: 'same-origin'
    })
      .then(response => {
        if (!response.ok) {
          throw new Error('Erro na rede ou no servidor');
        }
        return response.json();
        })
        .then(data => {
            if (data.status === 'error') {
              Swal.fire({
                          icon: 'error',
                          title: data.error_message
                        });
            } else {
              Swal.fire({
                          icon: 'success',
                          title: data.message,
                          allowOutsideClick: false
                        }).then(result => {
                if (result.isConfirmed) {
                  location.reload();
                }
                });
                }
                })
                .catch(error => {
                    Swal.fire({
                                icon: 'error',
                                title: 'Um erro ocorreu ao processar sua solicitação. Tente novamente mais tarde.'
                              });
                });
                }
                }
