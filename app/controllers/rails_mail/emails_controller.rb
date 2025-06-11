module RailsMail
  class EmailsController < BaseController
    include Pagy::Backend

    # GET /emails
    def index
      @emails = Email.all
      @emails = @emails.search(params[:q]) if params[:q].present?
      @emails = @emails.order(created_at: :desc)
      @pagy, @emails = pagy(@emails, items: 10)
      @email = params[:id] ? Email.find(params[:id]) : @emails.last
      # update for search, append for pagination
      @turbo_stream_action = if params.key?(:page) && params[:page].to_i > 1
                              'append'
                             else
                              'update'
                             end

      respond_to do |format|
        format.html
        format.turbo_stream if params.key?(:q) || params.key?(:page)
      end
    end

    # GET /emails/1
    def show
      @emails = Email.order(created_at: :desc)
      @pagy, @emails = pagy(@emails, items: 10)
      @email = Email.find(params[:id])
      session[:current_email_id] = @email.id

      render :show
    end

    def destroy
      @email = Email.find(params[:id])
      @current_email_id = session[:current_email_id]
      @email.destroy

      respond_to do |format|
        format.html { redirect_to emails_path }
        format.turbo_stream
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
