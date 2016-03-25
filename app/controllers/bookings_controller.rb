class BookingsController < ApplicationController
  before_action :find_session, only: [:create, :destroy]

  def create
    if @session.bookings.where(user_id: current_user.id) != []
      flash[:alert] = "You are already registered for this session"
    else
      @booking = @session.bookings.create(user_id: current_user.id)
      @session.save
      @session.maxnumber -= 1
      @session.save
      @session.conf_status = true if @session.maxnumber == 0
      @session.save
      flash[:notice] = "Your reservation is well booked, congrats !"
    end
    redirect_to :back
  end

  def destroy
    if Date.today + 1 < @session.starts_at
      @session.bookings.where(user_id: current_user.id).destroy_all
      @session.maxnumber +=1
      @session.conf_status = false
      @session.save
      flash[:alert]="You successfully canceled your booking to this event"
    else
      flash[:alert]= "You cannot cancell a booking later than 24hours before the class"
    end
    redirect_to :back
  end


private
  def find_session
    @session = Session.find(params[:session_id])
  end

end
