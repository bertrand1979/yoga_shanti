class LessonsController < ApplicationController

  def index
    @lessons = Lesson.all
  end

  def show
    @lesson = Lesson.find(params[:id])
    @sessions = @lesson.sessions
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

end
