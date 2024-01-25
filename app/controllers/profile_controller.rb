class ProfileController < ApplicationController
    before_action :authenticate_user!

    def index
      if user_signed_in?
        @user_info = current_user.profile || current_user.build_profile
      end
    end
  

    def edit

    end

    def update
      @user_info = current_user.profile || current_user.build_profile
      
      if params[:user] && params[:user][:avatar].present?
        @user_info.avatar.attach(params[:user][:avatar])
      end
  
      if @user_info.update(user_params)
        redirect_to profile_index_path, notice: 'User was successfully updated.'
      else
        flash[:alert] = 'Error updating user. Please check the form for errors.'
        flash[:error_details] = @user_info.errors.full_messages
        redirect_to profile_index_path  
      end
    end
    
    private
        def user_params
            params.require(:user).permit(:name, :address, :phone, :avatar, :gender)
        end
    
end
