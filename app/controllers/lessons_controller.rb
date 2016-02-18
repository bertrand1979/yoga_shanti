class LessonsController < ApplicationController

  def index
    @lessons = Lesson.all
    @markers = Gmaps4rails.build_markers(@lessons) do |lesson, marker|
      marker.lat lesson.latitude
      marker.lng lesson.longitude
    end
  end

  def show
    @lesson = Lesson.find(params[:id])
    @sessions = @lesson.sessions
  end

 def new
    @lesson = Lesson.new
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
      redirect_to lessons_path
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
