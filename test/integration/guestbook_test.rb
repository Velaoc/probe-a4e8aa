require "test_helper"

# The whole product is the root page: post a short message, see the wall
# newest first, no account required anywhere along the way.
class GuestbookTest < ActionDispatch::IntegrationTest
  test "root renders the wall newest first" do
    get root_path
    assert_response :success

    assert_select "h1", text: "Sign the guestbook"
    # Fixtures: second (1 day ago) above first (2 days ago).
    assert_select "ol li:first-child article p", text: "Anonymous greetings."
    assert_select "ol li article p", text: "Hello from the first visitor."
  end

  test "a guest can post a message without an account" do
    assert_difference -> { GuestbookEntry.count }, 1 do
      post guestbook_entries_path, params: {
        guestbook_entry: { name: "Vela", body: "Signed from a tiny board." }
      }
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_select "ol li:first-child article p", text: "Signed from a tiny board."
    assert_select "ol li:first-child article strong", text: "Vela"
  end

  test "anonymous messages fall back to Anonymous" do
    post guestbook_entries_path, params: {
      guestbook_entry: { name: "", body: "No name here." }
    }
    follow_redirect!
    assert_select "ol li:first-child article strong", text: "Anonymous"
  end

  test "blank messages are rejected" do
    assert_no_difference -> { GuestbookEntry.count } do
      post guestbook_entries_path, params: {
        guestbook_entry: { name: "", body: "" }
      }
    end

    assert_response :unprocessable_entity
    assert_select ".md-field--error"
  end

  test "only an admin can remove a message" do
    entry = guestbook_entries(:first)

    delete guestbook_entry_path(entry)
    assert_response :not_found

    post user_session_path, params: { user: { email: users(:admin).email, password: "correct horse battery" } }
    assert_difference -> { GuestbookEntry.count }, -1 do
      delete guestbook_entry_path(entry)
    end
    assert_redirected_to root_path
  end
end
