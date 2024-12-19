class Api::UsersController < ApplicationController
    def index    
      @user = User.all
      render json: @user
    end

    def show
      @user = User.find(params[:id])
      render json: @user
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        render json: @user
      else
        render json: { error: "НЕТ ЗАПИСЕЙ"}
      end
    end

    def destroy
      if params[:id].present?
        @user = User.find(params[:id])
        @user.destroy
        render json: { message: "Пользователь удалён" }, status: :ok
      else
        render json: { error: "Не указан идентификатор пользователя" }, status: :bad_request
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Пользователь не найден" }, status: :not_found
    end

    def user_follow
      @user = User.find(params[:id])
        if current_user.follow(@user)
          render json: { message: "Вы подписались на пользователя" }, status: :ok
        else
          render json: { error: "Ошибка подписки" }, status: :bad_request
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Пользователь не найден" }, status: :not_found
      end
      def user_unfollow
        @user = User.find(params[:id])
        if current_user.unfollow(@user)
          render json: { message: "Вы отписались от пользователя" }, status: :ok
        else
          render json: { error: "Ошибка отписки" }, status: :bad_request
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Пользователь не найден" }, status: :not_found
      end

    private
    def user_params
      params.require(:user).permit(:name, :email, :photo, :nickname)
    end

end
