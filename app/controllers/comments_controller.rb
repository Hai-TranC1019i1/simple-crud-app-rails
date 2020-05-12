class CommentsController < ApplicationController
  def index; end

  def show; end

  def create
    @article = get_by_article(:article_id)
    @comment = @article.comments.create(comments_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article = get_by_article(:article_id)
    @comment = @article.comments.find(params[:id])

    if @comment.destroy
      flash[:success] = 'Delete comment successful!'
    else
      flash[:warning] = 'Delete comment failed!'
    end

    redirect_to article_path(@article)
  end

  private

  def comments_params
    params.require(:comment).permit(:user_id, :body)
  end

  def get_by_article(id)
    Article.find(params[id])
  end
end
