class SessionsController < ApplicationController
  before_action :find_lesson, only: [ :new, :create]

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
    @session = @lesson.sessions.new(session_params)
    if @session.save
      respond_to do |format|
        format.html { redirect_to lesson_path(@session.lesson) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'lessons/show' }
        format.js  # <-- idem
      end
    end
  end

  def edit
    @session = Session.find(params[:id])
  end

  def update
    @session = Session.find(params[:id])
    if @session.update(session_params)
      if @session.conf_status == true
      redirect_to session_path(@session), notice: "Congratulations, session booked, happy Yoga!"
      else
      redirect_to session_path(@session), alert: "Session unbooked, we hope to see you soon!"
      end
    else
      render :new
    end
  end

  def destroy
    @session = Session.find(params[:id])
    @session.destroy
    redirect_to :back
  end


  private

  def session_params
    params.require(:session).permit(:starts_at, :conf_status, :maxnumber, :lesson_id)
  end

  def find_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

end
