class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
      @current_user = current_user 
    end

    def resend_confirmation
        user = User.find_by(id: params[:user_id])
        user.send_confirmation_instructions 
    end

    def update
        current_user.image.attach(params[:user][:avatar])
        if current_user.update(user_params)
          # Handle successful update
          redirect_to current_user, notice: 'User was successfully updated.'
        else
          # Handle validation errors
          render :edit
        end
      end
    
    private
        def user_params
            params.require(:user).permit(:email, :name, :address, :phone, :avatar)
        end
        
end
