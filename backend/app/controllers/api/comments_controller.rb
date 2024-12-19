class Api::CommentsController < ApplicationController

    def index
        @article = Article.find(params[:id])
        @comments = @article.comments
        render json: @comments
    end

    def show
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
        render json: @comment
      end

    def create
        @article = Article.find(params[:id])
        @comment = @article.comments.create(comment_params)
        render json: @comment
    end

    def destroy
        @article = Article.find(params[:id])
        @comment = @article.comments.find(params[:id])
        @comment.destroy
        render json: @comment
    end
    
    private
    def comment_params
        params.require(:comment).permit(:commenter, :body)
    end
end
