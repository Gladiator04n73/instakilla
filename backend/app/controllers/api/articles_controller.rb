
    class Api::ArticlesController < ApplicationController

        def index
            article = Article.all
            render json: { article: article.as_json }
        end

        
        def show
            article = Article.find(params[:id])
            render json: { article: article.as_json }
          rescue ActiveRecord::RecordNotFound
            render json: { error: 'Статья не найдена' }, status: :not_found
        end

      def create
        
        user = User.find(params[:user_id])
        article = user.articles.new(article_params) 

        article.status = 'Default_status'
        article.body = "Default_body"
        if article.save!
          render json: { article: article.as_json }, status: :created
        else
          render json: { error: "НЕТ ЗАПИСЕЙ"}
        end
      end
      

      def update
        article = Article.find(params[:id])
        if article.update(article_params)
          render json: { article: article.as_json }, status: :ok
        else
          render json: { error: "НЕТ ЗАПИСЕЙ"}
        end
      end

      def destroy
        if params[:id].present?
          article = Article.find(params[:id])
          article.destroy
          render json: { message: "Статья удалена" }, status: :ok
        else
          render json: { error: "Не указан идентификатор статьи" }, status: :bad_request
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Статья не найдена" }, status: :not_found
      end

      def delete
        article = Article.find(params[:id])
        article.delete
        render json: { message: "Статья удалена" }, status: :ok
      end
      

            private
            

            def article_params
              params.require(:article).permit(:title, :body, :status, :photo)
            end

    end
