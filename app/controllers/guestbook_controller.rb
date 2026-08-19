class GuestbookController < ApplicationController
  # The whole product is one page: write a short message, read the wall.
  # No accounts, no admin, no commerce — the foundation shell stays for
  # legal pages and Material chrome, but signing in is never required.
  before_action :set_message, only: %i[destroy]
  before_action :require_operator, only: %i[destroy]

  def index
    @message = GuestbookEntry.new
    @messages = GuestbookEntry.order(created_at: :desc).limit(200)
  end

  def create
    @message = GuestbookEntry.new(guestbook_entry_params)
    @messages = GuestbookEntry.order(created_at: :desc).limit(200)

    if @message.save
      redirect_to root_path, notice: "Thanks — your message is on the wall."
    else
      render :index, status: :unprocessable_entity
    end
  end

  # Modest deletion for the operator: a signed-in admin can take down a
  # message without touching the database console.
  def destroy
    @message.destroy!
    redirect_to root_path, notice: "Message removed."
  end

  private

  def set_message
    @message = GuestbookEntry.find(params[:id])
  end

  def require_operator
    head :not_found unless current_user&.admin?
  end

  def guestbook_entry_params
    params.require(:guestbook_entry).permit(:name, :body)
  end
end
