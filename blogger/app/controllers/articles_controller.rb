class ArticlesController < ApplicationController
  before_filter :require_login, :except =>  [:index, :show, :top_articles]


    def index
      @articles = Article.all
    end

    def show
      @article = Article.find(params[:id])
      @comment = Comment.new
      @comment.article_id = @article.id
      @article.count_up
    end

    def new
      if logged_in?
        @article = Article.new
      else
        flash[:message] = "Must be logged in to create a new article"
      end
    end

    def create
      @article = Article.new(
          :title => params[:article][:title],
          :body  => params[:article][:body],
          :article_author => current_user.username)

      @article.save
      flash[:message] = "Article #{@article.title} Created!"
      redirect_to article_path(@article)
    end

    def destroy
        @article = Article.find(params[:id]).destroy
        flash[:message] = "Article #{@article.title} Deleted!"
        redirect_to articles_path
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        @article.update_attributes(params[:article])

        flash[:message] = "Article #{@article.title} Updated!"
        redirect_to article_path(@article)
    end

    def top_articles
          @articles = Article.order('view_count desc').limit 3
    end

end
