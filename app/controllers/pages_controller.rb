class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def home
    @sessions = Session.all
    @lessons = Lesson.all
  end
end
