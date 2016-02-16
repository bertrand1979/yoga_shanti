class SessionsController < ApplicationController
  before_action :find_lesson, only: [ :new, :create, :show, :update, :destroy ]

  def index
    @sessions = Session.all
  end

  def show
    @session = Session.find(params[:id])
  end

  def new
    @session = Session.new
  end

  def create
    @session = @lesson.sessions.build(review_params)
    @session.save
    redirect_to user_lesson_session_path(@session)
  end

  def edit
  end

  def update
    if @session.update(lesson_params)
      redirect_to user_lesson_session_path(@session)
    else
      render :new
    end
  end

  def destroy
  end


  private

  def session_params
    params.require(:session).permit(:starts_at)
  end

  def find_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

end
