class SessionsController < ApplicationController
  before_action :find_lesson, only: [ :new, :create ]

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
  end

  def edit
  end

  def update
    if @session.update(lesson_params)
      redirect_to session_path(@session)
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





    user_lesson_sessions GET    /users/:user_id/lessons/:lesson_id/sessions(.:format)          sessions#index
                         POST   /users/:user_id/lessons/:lesson_id/sessions(.:format)          sessions#create
 new_user_lesson_session GET    /users/:user_id/lessons/:lesson_id/sessions/new(.:format)      sessions#new
edit_user_lesson_session GET    /users/:user_id/lessons/:lesson_id/sessions/:id/edit(.:format) sessions#edit
     user_lesson_session GET    /users/:user_id/lessons/:lesson_id/sessions/:id(.:format)      sessions#show
                         PATCH  /users/:user_id/lessons/:lesson_id/sessions/:id(.:format)      sessions#update
                         PUT    /users/:user_id/lessons/:lesson_id/sessions/:id(.:format)      sessions#update
                         DELETE /users/:user_id/lessons/:lesson_id/sessions/:id(.:format)      sessions#destroy
