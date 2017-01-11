class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_story, only: [:create, :index, :destroy]
  before_action :find_comment, only: [:destroy]


def index

end

  def create
   @comment = @story.comments.create(comment_params)
   @comment.user_id = current_user.id

   respond_to do |format|
     if @comment.save
       format.html { redirect_to @story, notice: 'Comment was successfully created.' }
       format.json { render :show, status: :created, template: 'stories/show' }
     else
       format.html { redirect_to @story, error: 'Comment has some error.' }
       format.json { render json: @comment.errors, status: :unprocessable_entity }
     end
   end
  end

def new

end

def show

end

def update

end

def destroy

  @comment.destroy
  redirect_to story_path(@story)
end

def edit

end




  private

  def set_story
    @story = Story.find(params[:story_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:body)
  end
  def find_comment
    @comment = @story.comments.find(params[:id])
  end
end
