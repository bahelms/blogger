class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @user = current_user
      render 'users/show'
    else
      render 'sessions/new'
    end
  end
end
