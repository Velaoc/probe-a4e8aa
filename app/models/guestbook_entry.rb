# A single line on the wall. Anonymous by design: a message carries only
# an optional name and the text itself. Everything else (timestamps) is
# the framework's.
class GuestbookEntry < ApplicationRecord
  validates :body, presence: true, length: { maximum: 280 }
  validates :name, length: { maximum: 60 }, allow_blank: true

  # Display name with a graceful fallback for anonymous messages.
  def display_name
    name.presence || "Anonymous"
  end
end
