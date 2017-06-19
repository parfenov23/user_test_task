module Api
  class UsersController < ::ApplicationController
    # Создание User обязательно поле name
    # если его нет то отдается ошибка
    def create
      user = User.create(user_params)
      render json: (user.errors.present? ? user.errors.messages : user.transfer_to_json)
    end

    def update
      render json: {success: find_user.update(user_params)}
    end

    def show
      render json: find_user.transfer_to_json
    end

    # Вывод всех Users
    def index
      render json: User.all.map(&:transfer_to_json)
    end

    # Вывод всех Session у выбранного User
    def sessions
      render json: find_user.sessions.map(&:transfer_to_json)
    end

    private

    def find_user
      User.find(params[:id])
    end

    def user_params
      params.permit(:name)
    end

  end
end