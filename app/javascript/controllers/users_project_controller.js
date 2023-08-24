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
  };

    confirmDelete(event) {
        const userId = event.currentTarget.dataset.userId;

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
                this.deleteUser(userId);
            }
        });
    }

    deleteUser(userId) {
        const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");

        fetch(`/users_project/${userId}`, {
            method: 'DELETE',
            headers: {
                'X-CSRF-Token': csrfToken
            }
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Erro ao deletar usuário');
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
                    title: 'Erro ao deletar usuário',
                    text: error.message
                });
            });
    }

    showUpdate(event){
        const userId = event.currentTarget.dataset.userId;

        var csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
        $.ajax({
            url: "/users_project/" + userId,
            method: "GET",
            dataType: "json",
            success: function(user) {
                // Preencha o modal com os dados do usuário
                $('#user_form_update #id_user_update').val(user.id);
                $('#user_form_update #update_name_user').val(user.name);
                $('#user_form_update #update_email_user').val(user.email);

                // Mostra o modal
                $('#update_user').modal('show');
            },
            error: function() {
                Swal.fire({
                    icon: 'error',
                    title: 'Erro ao buscar os dados do usuário.'
                });
            }
        });
    }

    updateUser(event) {
        event.preventDefault();
        const form = this.element.querySelector('#user_form_update');
        let formData = new FormData(form);

        fetch(form.action, {
            method: 'PATCH',
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

    closeUpdateModal() {
        const modal = this.element.querySelector('#update_user');
        $(modal).modal('hide');
    }


}
