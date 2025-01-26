module RailsMail
  class EmailsController < BaseController
    # GET /emails
    def index
      @emails = Email.order(created_at: :desc)
      @email = params[:id] ? Email.find(params[:id]) : Email.last
    end

    # GET /emails/1
    def show
      @emails = Email.order(created_at: :desc)
      @email = Email.find(params[:id])
      if request.headers["Turbo-Frame"]
        render partial: "rails_mail/emails/show", locals: { email: @email }
      else
        render :index
      end
    end

    def destroy_all
      # Email.destroy_all
      respond_to do |format|
        format.html { redirect_to emails_path }
        format.turbo_stream {
          render turbo_stream: [
            turbo_stream.update("email-sidebar", ""),
            turbo_stream.update("email_content", partial: "empty_state")
          ]
        }
      end
    end
  end
end
