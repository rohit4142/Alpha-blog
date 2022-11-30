class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
  
    def show
        @user = User.find(params[:id])
        render json: @user
    end
    def home

    end
    def index
      @users = User.all
      #render json: @users
    end

    def articles
    @user_id=params[:user_id]
    end

    def login

    end
  
    def new
      @user = User.new
    end
  
  
    def update
      if @user.update(user_params)
         render json: @user
      else
        render json: "not updated"
    end
  end
  
    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user
      else
        render json: @user.error.full_messages
    end
  end
  
    def destroy
      @user.destroy
       render json: @user
    end
  
    private
    def user_params
      params.require(:user).permit(:username, :email)
    end
  
    def set_user
      @user = User.find(params[:id])
    end
  end
    