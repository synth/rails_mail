module RailsMail
  class EmailsController < ApplicationController
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
        render action: "show", layout: false
      else
        render action: "index", layout: true
      end
    end
  end
end
