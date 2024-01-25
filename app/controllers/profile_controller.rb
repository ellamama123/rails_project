class ProfileController < ApplicationController
    before_action :authenticate_user!

    def index
        @current_user = current_user 
    end
  

    def edit

    end

    def update
        current_user.avatar.attach(params[:user][:avatar])
        if current_user.update(user_params)
          redirect_to profile_index_path, notice: 'User was successfully updated.'
        else
          render :index
        end
    end
    
    private
        def user_params
            params.require(:user).permit(:email, :name, :address, :phone, :avatar)
        end
    
end
