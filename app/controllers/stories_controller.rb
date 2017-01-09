class StoriesController < ApplicationController
  before_action :authenticate_user! #, except: [:index, :show]
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  # GET /stories
  # GET /stories.json
  def index
    @stories = Story.all.order('id DESC')
  end

  def my_stories
    @my_stories = current_user.stories.all

    respond_to do |format|
      format.html { render template: "stories/my_stories"}
      format.json { render template: "stories/index", status: :ok  }
    end
  end
  def bookmarked_stories
    #has many through relationship krni he lazmi!!!!!!
    @stories = []
    current_user.bookmarks.each do |bookmark|
      @stories.push(bookmark.story)
    end
    respond_to do |format|
      format.html { render template: "stories/bookmarked_stories"}
      format.json { render template: "stories/index", status: :ok  }
    end
  end

  def liked_stories
    #has many through relationship krni he lazmi!!!!!!
    @stories = []
    current_user.likes.each do |like|
      @stories.push(like.story)
    end
    respond_to do |format|
      format.html { render template: "stories/liked_stories"}
      format.json { render template: "stories/index", status: :ok  }
    end
  end
  # GET /stories/1
  # GET /stories/1.json
  def show

  end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
    authorize! :manage, @story
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(story_params)
    @story.user = current_user

    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, notice: 'Story was successfully created.' }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    authorize! :manage, @story
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story, notice: 'Story was successfully updated.' }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    authorize! :manage, @story
    @story.destroy
    respond_to do |format|
      format.html { redirect_to stories_url, notice: 'Story was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:title, :body)
    end
end
