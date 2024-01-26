class HomeController < ApplicationController
  require 'csv'
  load_and_authorize_resource :class => false
  
  def index
    @q = User.ransack(params[:q])

    @users = @q.result(distinct: true).paginate(page: params[:page], per_page: 10).includes([:profile])

    if params[:q] && params[:q][:confirmed_at_eq].present?
      confirmed_status = params[:q][:confirmed_at_eq] == 'true'
      @users = @users.where(confirmed_status ? 'confirmed_at IS NOT NULL' : 'confirmed_at IS NULL')
    end

    respond_to do |format|
      format.html
      format.csv { send_data users_to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  private

    def users_to_csv
      CSV.generate(headers: true) do |csv|
        csv << ['Email', 'Name', 'Address', 'Confirmed At']

        @users.each do |user|
          csv << [user.email, user&.profile&.name, user&.profile&.address, user.confirmed_at]
        end
      end
    end
end
