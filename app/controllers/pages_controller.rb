class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def home

    if (params[:when] == "" || params[:when].nil?) && (params[:where] == "" || params[:where].nil?)
      @sessions = Session.all
      @lessons  = Lesson.all
    elsif params[:when] == "" || params[:when].nil?
      @lessons = Lesson.near(params[:where],5).
                 joins(:sessions)
      @sessions = @lessons.map(&:sessions).flatten
    elsif params[:where] == "" || params[:where].nil?
      @lessons = Lesson.all.
                 joins(:sessions).where(sessions: { starts_at: params[:when] })
      @sessions = @lessons.map(&:sessions).flatten
    else
      @lessons = Lesson.near(params[:where],5).
                 joins(:sessions).where(sessions: { starts_at: params[:when] })
      @sessions = @lessons.map(&:sessions).flatten
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
end
