class LessonsController < ApplicationController
  before_action :find_lesson, only: [:edit, :update, :delete, :show]
  def index
    @lessons = Lesson.all
    @markers = Gmaps4rails.build_markers(@lessons) do |lesson, marker|
      @lesson = lesson
      marker.lat lesson.latitude
      marker.lng lesson.longitude
      marker.infowindow render_to_string(:partial => "lessons/infowindow", :locals => { :lesson => @lesson})
      # marker.title "#{lesson.name}"
      # marker.json({ :address => lesson.address})
      marker.picture({:picture => "/assets/images/yoga.png",
                     :width => 32,
                     :height => 32})
    end
  end

  def show
    if current_user.category == "teacher" && @lesson.user.id == current_user.id
      @sessions = @lesson.sessions
      @session = Session.new
    else
      raise
      flash[:alert] = "Only the creator of this lesson can access to it"
      redirect_to :back
    end
  end

  def showdetails
    @lesson = Lesson.find(params[:lesson_id])
    @sessions = @lesson.sessions
  end

  def new
    if current_user.category == "teacher"
      @lesson = Lesson.new
    else
      flash[:alert] = "Only teachers can create a new lesson. Please log in with a teacher account"
      redirect_to root_path
    end
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.user = current_user
    if @lesson.save
    redirect_to lesson_path(@lesson)
    else render :new
    end
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to lesson_path(@lesson)
    else render :new
    end
  end

  def edit
  end

  def delete
    @lesson.destroy
    redirect_to user_lessons_path(@lesson)
  end

  private

  def lesson_params
  params.require(:lesson).permit(:name, :address, :price, :description, :yoga_category, photos: [])
  end
  def find_lesson
    @lesson = Lesson.find(params[:id])
  end
end
