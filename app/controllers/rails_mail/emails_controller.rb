module RailsMail
  class EmailsController < ApplicationController
    # GET /emails
    def index
      @emails = Email.order(created_at: :desc)
      @email = params[:id] ? Email.find(params[:id]) : Email.first
    end

    # GET /emails/1
    def show
      @emails = Email.order(created_at: :desc)
      @email = Email.find(params[:id])
    end
  end
end
