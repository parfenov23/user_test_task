module Api
  class SessionsController < ::ApplicationController
    # Создание Session обязательно поля time, user_id
    # если его нет то отдается ошибка
    def create
      session = Session.create(session_params)
      render json: (session.errors.present? ? session.errors.messages : session.transfer_to_json)
    end

    def update
      render json: {success: find_session.update(session_params)}
    end

    def show
      render json: find_session.transfer_to_json
    end

    # Вывод всех Sessions
    def index
      render json: Session.all.map(&:transfer_to_json)
    end

    private

    def find_session
      Session.find(params[:id])
    end

    def session_params
      params.permit(:time, :user_id)
    end

  end
end