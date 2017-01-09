class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]


  def show
      respond_to do |format|
        format.html { render template: "users/user"}
        format.json { render template: "users/user", status: :ok }
      end
  end
  # def show
  #   @stories = @user.stories.all
  # end

  private


  def set_user
    @user = User.find(params[:id])
  end
end
