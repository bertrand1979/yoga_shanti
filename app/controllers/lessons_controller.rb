class LessonsController < ApplicationController
before_action :find_user, only: [:new, :edit, :update, :create]

  def index
    @lessons = Lesson.where(user_id: params[:user_id])
    @markers = Gmaps4rails.build_markers(@lessons) do |lesson, marker|
      marker.lat lesson.latitude
      marker.lng lesson.longitude
    end
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

 def new
    @lesson = Lesson.new
  end

  def create
    @lesson = @user.lessons.build(lesson_params)
    if @lesson.save
    redirect_to user_lessons_path(@user)
    else render :new
    end
  end

  def update
    @lesson = Lesson.find(params[:id])
    if @lesson.update(lesson_params)
      redirect_to user_lessons_path(@user)
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
  params.require(:lesson).permit(:name, :address, :price, photos: [])
  end

  def find_user
    @user = User.find(params[:user_id])
  end

end
