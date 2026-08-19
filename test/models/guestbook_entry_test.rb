require "test_helper"

class GuestbookEntryTest < ActiveSupport::TestCase
  test "body is required and capped at 280 characters" do
    entry = GuestbookEntry.new(name: "Ada")
    assert_not entry.valid?
    assert_includes entry.errors[:body], "can't be blank"

    entry.body = "x" * 281
    assert_not entry.valid?
    assert_includes entry.errors[:body], "is too long (maximum is 280 characters)"
  end

  test "name is capped and optional" do
    entry = GuestbookEntry.new(name: "x" * 61, body: "hi")
    assert_not entry.valid?
    assert_includes entry.errors[:name], "is too long (maximum is 60 characters)"

    entry.name = ""
    assert entry.valid?
    assert_equal "Anonymous", entry.display_name
  end
end
