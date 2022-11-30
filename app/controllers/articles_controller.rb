class ArticlesController < ApplicationController
before_action :get_user
before_action :article_params, only: [:create, :update]

def index
#@articles=Article.all
@articles=@user.articles
render json: @articles
end

def show
    @article=@user.articles.find(params[:id])
    render json: @article
end

def new
    @article = @user.articles.build
end


def create 
    @article = @user.articles.build(article_params)
    if @article.save
        Auditlog.create(user_id: params[:user_id], article_id: @article.article_id, message_log:" Article#{@article.title} has been created")

        respond_to do |format|

            format.json do
              render json: @article
            end
      
          end
    end
end

def update
    #@article = Article.find(params[:id])
    @article=@user.articles.find(params[:id])
    if @article.update(article_params)
        Auditlog.create(user_id: params[:user_id], article_id: @article.article_id, message_log:" Article#{@article.title} has been updated")
        render json: @article
    end
   
end

def destroy
    #@article = Article.find(params[:id])
    @article=@user.articles.find(params[:id])
    if !@article
        render json: "Error"
    else
        Auditlog.create(user_id: params[:user_id], article_id: @article.article_id, message_log:" Article#{@article.title} has been deleted")
        @article.destroy
        render json: {"status":"deleted"}
    end
end

def destroy_all

    @articles=@user.articles
    @articles.destroy_all
    # @articles=Article.where(user_id: params[:users_id])
    # render json: params[:user_id]
    # @articles.destroy_all

end


private

def get_user
    @user = User.find(params[:user_id])
end

def article_params
 params.require(:article).permit(:title, :description)
end

end
