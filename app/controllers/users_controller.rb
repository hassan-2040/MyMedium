class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :follow, :unfollow, :user_stories]


  def index
    @users = User.where.not(id: current_user.id).all
  end




  def show
      respond_to do |format|
        format.html { render template: "users/user"}
        format.json { render template: "users/user", status: :ok }
      end
  end
  # def show
  #   @stories = @user.stories.all
  # end

  def follow
    if current_user != @user
      current_user.following_followships.first_or_create(following: @user)
      respond_to do |format|
        format.html { redirect_to :back, notice: "Followship created." }
        format.json { render json: {errors: ["User cannot follow himself"]}, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { render json: {errors: ["User cannot follow himself"]}, status: :unprocessable_entity }
      end
    end
  end

  def unfollow
    if current_user != @user
      Followship.find_by(follower: current_user, following: @user).destroy
      respond_to do |format|
        format.html { redirect_to :back, notice: "Followship removed." }
        format.json { render json: {errors: ["User cannot follow himself"]}, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { render json: {errors: ["User cannot follow himself"]}, status: :unprocessable_entity }
      end
    end
  end

  private


  def set_user
    @user = User.find(params[:id])
  end
end
