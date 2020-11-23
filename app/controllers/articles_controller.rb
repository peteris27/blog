class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "Peteris", password: "secret", except: [:index, :show]

  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.order(:title).page params[:page]
    # if params[:article] && params[:article][:author_id]
    #   @articles = Article.search(params[:article][:author_id])
    # else
    #   @articles = Article.all
    # end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    # @article = Article.new
    @article = current_user.articles.build
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    #@article = Article.new(article_params)
    @article = current_user.articles.build(article_params)

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

def correct_user
  @article = current_user.articles.find_by(id: params[:id])
  redirect_to articles_path, notice: "Not Autherized To Edit This Article" if @article.nil?
end

  private
    def article_params
      params.require(:article).permit(:title, :text, :author_id, :user_id)
    end
end
