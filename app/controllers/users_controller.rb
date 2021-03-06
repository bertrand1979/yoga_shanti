class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @sessions = Session.all.select{|session| session.starts_at >= Date.today}.sort_by{|session| session.starts_at}
    @bookings = Booking.all.select{|booking| booking.session.starts_at >= Date.today}.sort_by{|booking| booking.session.starts_at}
  end


  def edit
    if current_user.id != @user.id
      redirect_to user_path(@user)
    end

  end

  def update
    @user.update(params_user)
    @user.save
    redirect_to user_path(@user)
  end



private

  def set_user
    @user = User.find(params[:id])
  end

  def params_user
    params.require(:user).permit(:first_name, :last_name, :email, :birth_date, :description, :start_date, :category)

  end



end
