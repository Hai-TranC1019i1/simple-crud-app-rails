class ArticlesController < ApplicationController
  http_basic_authenticate_with name: 'haibnk',
    password: 'secret', only: :destroy
  
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def show
    @article = get_by(:id)
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:success] = 'Create success!'
      redirect_to articles_path
    else
      flash[:warning] = 'Something went wrong!'
      render :new
    end
  end

  def edit
    @article = get_by(:id)
  end

  def update
    @article = get_by(:id)

    if @article.update(article_params)
      flash[:success] = 'Update success!'
      redirect_to articles_path
    else
      flash[:warning] = 'Update failed!'
      render :edit
    end
  end

  def destroy
    @article = get_by(:id)
    if @article.destroy
      flash[:success] = 'Delete success!'
      redirect_to articles_path
    else
      flash[:warning] = 'Delete failed!'
      render :new
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def get_by(id)
    Article.find(params[id])
  end
end
