class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def home

    @lessons = future_lesson(Lesson.all)
    @sessions = Session.all.select{|session| session.starts_at >= Date.today}.sort_by{|session| session.starts_at}

    if (params[:when] == "" || params[:when].nil?) && (params[:where] == "" || params[:where].nil?)
    elsif params[:when] == "" || params[:when].nil?
      @lessons = future_lesson(Lesson.near(params[:where],5))
      @sessions = @lessons.map(&:sessions).flatten.select{|session| session.starts_at >= Date.today}.sort_by{|session| session.starts_at}
    elsif params[:where] == "" || params[:where].nil?
      @lessons = Lesson.all.joins(:sessions).where(sessions: { starts_at: params[:when] })
      @sessions = @lessons.map(&:sessions).flatten.select{|session| session.starts_at >= Date.today}.sort_by{|session| session.starts_at}
    else
      @lessons = Lesson.near(params[:where],5).
                 joins(:sessions).where(sessions: { starts_at: params[:when] })
      @sessions = @lessons.map(&:sessions).flatten.select{|session| session.starts_at >= Date.today}.sort_by{|session| session.starts_at}
    end


    @markers = Gmaps4rails.build_markers(@lessons) do |lesson, marker|
      marker.lat lesson.latitude
      marker.lng lesson.longitude
      marker.infowindow render_to_string(:partial => "lessons/infowindow", :locals => { :lesson => lesson})
      marker.picture({:picture => "/assets/images/yoga.png",
                      :width => 32,
                      :height => 32})
    end
  end

  private

  def future_lesson(lessons)
    lessons.select do |lesson|
      lesson.sessions.find{|session| session.starts_at >= Date.today}
    end
  end

end
