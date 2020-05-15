# frozen_string_literal: true

class CommentsController < ApplicationController
  def index; end

  def show; end

  def create
    @article = get_by_article(:article_id)
    @comment = @article.comments.create(comments_params)

    respond_to do |format|
      if @comment.errors.any?
        format.html { render 'articles/show' }
        format.json do
          render json: @comment.errors,
                 status: :unprocessable_entity
        end
      else
        format.html { redirect_to article_path(@article) }
        format.js
        format.json do
          render json: @comment,
                 status: :created,
                 location: @comment
        end
      end
    end
  end

  def destroy
    @article = get_by_article(:article_id)
    @comment = @article.comments.find(params[:id])

    @comment.destroy

    respond_to do |format|
      format.html { redirect_to article_path(@article) }
      format.json { head :no_content }
      format.js   { render layout: false }
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:user_id, :body)
  end

  def get_by_article(id)
    Article.find(params[id])
  end
end
