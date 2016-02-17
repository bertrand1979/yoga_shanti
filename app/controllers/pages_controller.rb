class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def home
    @sessions = Session.all
    @lessons = Lesson.all
    @markers = Gmaps4rails.build_markers(@lessons) do |lesson, marker|
      marker.lat lesson.latitude
      marker.lng lesson.longitude
    end
  end
end
