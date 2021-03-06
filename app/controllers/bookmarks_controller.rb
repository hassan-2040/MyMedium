class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_story

  def create
    @story.bookmarks.where(user_id: current_user.id).first_or_create

    respond_to do |format|
      format.html {redirect_to @story}
      format.js
    end
  end

  def destroy
    @story.bookmarks.where(user_id: current_user.id).destroy_all
    respond_to do |format|
      format.html {redirect_to @story}
      format.js
    end
  end

  private

  def set_story
    @story = Story.find(params[:story_id])
  end
end
