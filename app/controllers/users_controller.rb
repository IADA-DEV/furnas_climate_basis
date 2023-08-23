class UsersController < ApplicationController
  respond_to :html, :json, :js
  def index
    @users = User
               .order(:name)
               .paginate(page: params[:page], per_page: 20)
  end

  def create
    @user = User.new(user_params)
    @user.password = 'chuvabrasil2023'

    if @user.save
      render json: { status: 'success', message: 'Usuário criado com sucesso!' }
    else
      error_messages = @user.errors.full_messages.uniq.map { |msg| "- #{msg}" }.join("\n")
      render json: { status: 'error', error_message: error_messages }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.json { render json: @user }
    end
  end
  def update
    @user = User.find(user_params[:id])
    if @user.update(user_params)
      render json: { status: 'success', message: 'Usuário Atualizado com Sucesso' }
    else
      error_messages = @user.errors.full_messages.uniq.map { |msg| "- #{msg}" }.join("\n")
      render json: { status: 'error', error_message: error_messages }
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      render json: { status: 'success', message: 'Usuário Deletado com Sucesso' }
    else
      error_messages = @user.errors.full_messages.uniq.map { |msg| "- #{msg}" }.join("\n")
      render json: { status: 'error', error_message: error_messages }
    end
  end

  def update_admin
    user = User.find(params[:user_id])
    if false
      render json: { status: 'success', message: 'Usuário atualizado com sucesso!' }
    else
      render json: { status: 'error', error_message: user.errors.full_messages.join(', ') }
    end
  end



  def user_params
    params.require(:user).permit(:id, :name, :email)
  end

end
