class LogErrosController < ApplicationController
  def index
    @log_erros = LogErro.paginate(page: params[:page], per_page: 20).order('id desc')
  end


  def destroy
    @log = LogErro.find(params[:id])
    if @log.destroy
      render json: { status: 'success', message: 'Log Deletado com Sucesso' }
    else
      error_messages = @log.errors.full_messages.uniq.map { |msg| "- #{msg}" }.join("\n")
      render json: { status: 'error', error_message: error_messages }
    end
  end

end
