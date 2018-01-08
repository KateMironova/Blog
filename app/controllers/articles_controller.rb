class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "username", password: "secret", except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    # render plain: params[:article].inspect

    # каждая модель может быть инициализирована с помощью соответствующих атрибутов,
    # которые будут автоматически привязаны к соответствующим столбцам базы данных
    @article = Article.new(article_params)

    # сохранение модели в базу данных
    if @article.save # возвращает булево значение, показывающее, была ли сохранена модель, или нет
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
  def article_params
      params.require(:article).permit(:title, :text)
  end
end
