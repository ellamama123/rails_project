class HomeController < ApplicationController
  require 'csv'
  include Prawn::View
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
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="exported_data.xlsx"'
      }
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text 'Users PDF Report', size: 18, style: :bold, align: :center
        pdf.move_down 20

        pdf.table(user_table_data, header: true, width: 500) do
          row(0).font_style = :bold
          cells.align = :center
        end

        send_data pdf.render, filename: 'users_report.pdf', type: 'application/pdf', disposition: 'inline'
      end
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

    def users_to_xlsx
      p = Axlsx::Package.new
      wb = p.workbook
  
      wb.add_worksheet do |sheet|
        sheet.add_row ['Email', 'Name', 'Address', 'Confirmed At']
        product.each do |product|
          sheet.add_row [user.email, user&.profile&.name, user&.profile&.address, user.confirmed_at]
        end
      end
      p
    end

    def user_table_data
      [['Avatar', 'Email', 'Name', 'Address', 'Confirmed At']] + @users.map { |user| [ user.email,  user.profile && user.profile.name ? user.profile.name : 'X', user.profile && user.profile.address ? user.profile.address : 'X' , user.confirmed_at ? user.confirmed_at.to_s : 'X'] }
    end


end
