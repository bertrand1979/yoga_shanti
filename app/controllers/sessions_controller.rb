class SessionsController < ApplicationController
  before_action :find_lesson, only: [ :new, :create, :destroy ]

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
    @session = @lesson.sessions.build(session_params)
    if @session.save
    redirect_to lesson_path(@session.lesson)
    else
      render :new
    end
  end

  def edit
    @session = Session.find(params[:id])
  end

  def update
    @session = Session.find(params[:id])
    if @session.update(session_params)
      redirect_to session_path(@session), notice: "Session booked!"
    else
      render :new
    end
  end

  def destroy
    @session.destroy
    redirect_to user_lesson_session_path(@user)
  end


  private

  def session_params
    params.require(:session).permit(:starts_at, :conf_status, :user_id)
  end

  def find_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

end
