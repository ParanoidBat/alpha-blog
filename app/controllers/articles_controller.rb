class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:home, :show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def home
        redirect_to articles_path if logged_in?
    end

    def show
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def edit
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        
        if @article.save
            flash[:notice] = "New article created!"
            redirect_to article_path(@article)
        else
            render_to_string 'new'
        end
    end

    def update
        if @article.update(article_params)
            flash[:notice] = "Article updated"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        if @article.destroy
            flash[:notice] = "Destroyed Succesfully"
            redirect_to articles_path
        else
            flash[:alert] = "Error destroying article"
            redirect_to @article
        end
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description)
    end

    def require_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "You are not authorized for this action"
            redirect_to @article
        end
    end

end