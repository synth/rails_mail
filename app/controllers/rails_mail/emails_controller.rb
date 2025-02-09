module RailsMail
  class EmailsController < BaseController
    # GET /emails
    def index
      @emails = Email.all
      @emails = @emails.search(params[:q]) if params[:q].present?
      @emails = @emails.order(created_at: :desc)
      @email = params[:id] ? Email.find(params[:id]) : Email.last

      respond_to do |format|
        format.html
        format.turbo_stream if params.key?(:q)
      end
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
      Email.destroy_all
      respond_to do |format|
        format.html { redirect_to emails_path }
        format.turbo_stream
      end
    end
  end
end
