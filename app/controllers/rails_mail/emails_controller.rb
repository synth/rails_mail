module RailsMail
  class EmailsController < BaseController
    # GET /emails
    def index
      @emails = Email.order(created_at: :desc)
      @emails = @emails.search(params[:q]) if params[:q].present?
      @emails, @next_page = offset_and_paginate(@emails)
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
      @emails, @next_page = offset_and_paginate(@emails)
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

    def offset_and_paginate(relation, page_limit = 20)
      current_page = params[:page].to_i
      total_count = relation.count # count BEFORE offset/limit if relation is ActiveRecord::Relation
      paginated_relation = relation.offset(page_limit * current_page).limit(page_limit)
      next_page = nil
      if total_count > page_limit * (current_page + 1)
        next_page = current_page + 1
      end

      [ paginated_relation, next_page ]
    end
  end
end
