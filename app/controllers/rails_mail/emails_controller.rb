module RailsMail
  class EmailsController < BaseController
    # GET /emails
    def index
      @emails = Email.order(created_at: :desc)
      @emails = @emails.search(params[:q]) if params[:q].present?
      paginated = paginate_with_next_page(@emails, page: params[:page].to_i)
      @emails, @next_page = paginated.items, paginated.next_page
      @email = params[:id] ? Email.find(params[:id]) : @emails.last
      # we're not paginating, so it means we're either the initial index page
      # load or we're searching. In which case run an "update" turbo stream
      # to replace all the results.
      @turbo_stream_action = paginating? ? "append" : "update"

      respond_to do |format|
        format.html
        format.turbo_stream if params[:q].present? || params[:page].present?
      end
    end

    # GET /emails/1
    def show
      @emails = Email.order(created_at: :desc)
      paginated = paginate_with_next_page(@emails, page: params[:page].to_i)
      @emails, @next_page = paginated.items, paginated.next_page
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

    private

    def paginating?
      params.key?(:page) && params[:page].to_i >= 1
    end

    def paginate_with_next_page(relation, page: nil)
      per_page = RailsMail.configuration.per_page || 20
      current_page = (page || params[:page] || 0).to_i
      total_count = relation.count
      items = relation.offset(current_page * per_page).limit(per_page)
      next_page = total_count > per_page * (current_page + 1) ? current_page + 1 : nil
      Struct.new(:items, :next_page).new(items, next_page)
    end
  end
end
