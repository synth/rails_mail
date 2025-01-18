module RailsMail
  class EmailsController < ApplicationController
    before_action :set_email, only: %i[ show edit update destroy ]

    # GET /emails
    def index
      @emails = Email.all
    end

    # GET /emails/1
    def show
    end

    # GET /emails/new
    def new
      @email = Email.new
    end

    # GET /emails/1/edit
    def edit
    end

    # POST /emails
    def create
      @email = Email.new(email_params)

      if @email.save
        redirect_to @email, notice: "Email was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /emails/1
    def update
      if @email.update(email_params)
        redirect_to @email, notice: "Email was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /emails/1
    def destroy
      @email.destroy!
      redirect_to emails_url, notice: "Email was successfully destroyed.", status: :see_other
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_email
        @email = Email.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def email_params
        params.require(:email).permit(data: [ :from, :to, :cc, :bcc, :subject, :body, :content_type, :attachments, { to: [], cc: [], bcc: [] } ])
      end
  end
end
