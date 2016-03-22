class LessonsController < ApplicationController

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
    @lesson = Lesson.find(params[:id])
    @sessions = @lesson.sessions
    @session = Session.new
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
    @lesson = Lesson.find(params[:id])
    if @lesson.update(lesson_params)
      redirect_to lesson_path(@lesson)
    else render :new
    end
  end

  def edit
    @lesson = Lesson.find(params[:id])
  end

  def delete
    @lesson = Lesson.find(params[:id])
    @lesson.destroy
    redirect_to user_lessons_path(@lesson)
  end

  private

  def lesson_params
  params.require(:lesson).permit(:name, :address, :price, :description, :yoga_category, photos: [])
  end

end
