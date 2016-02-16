class SessionsController < ApplicationController
  before_action :find_lesson, :find_user, only: [ :new, :create, :show, :update, :destroy, :edit, :update ]

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
    redirect_to user_lesson_session_path(@user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @session.update(session_params)
      redirect_to user_lesson_session_path(@user)
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
    params.require(:session).permit(:starts_at)
  end

  def find_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
  def find_user
    @user = User.find(params[:user_id])
  end

end
