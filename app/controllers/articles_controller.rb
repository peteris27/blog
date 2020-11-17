class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "Peteris", password: "secret", except: [:index, :show]

  def index
    if params[:article] && params[:article][:author_id]
      @articles = Article.search(params[:article][:author_id])
    else
    @articles = Article.all
    end
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
    @article = Article.new(article_params)

    @article.valid?
    puts @article.errors.full_messages

    if @article.save
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
      params.require(:article).permit(:title, :text, :author_id)
    end
end
