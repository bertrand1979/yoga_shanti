class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def home
    @sessions = Session.all
    @lessons = []
    @sessions.each do |session|
      @lessons << session.lesson
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
