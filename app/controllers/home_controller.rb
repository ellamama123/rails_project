class HomeController < ApplicationController
  def index
    if user_signed_in?
      @users = User.paginate(page: params[:page])
    end
  end
end
