# A few welcome messages so the wall is not an empty page on first boot.
# Seeds run only in development/demo previews, never in production.
if Rails.env.production?
  puts "Skipping guestbook seeds in production."
else
  [
    [ "Vela", "First to sign the wall. Hi from a tiny board with strong opinions." ],
    [ nil, "This guestbook is delightfully small. I like it." ],
    [ "Nova", "Vela shipped a whole app again. Show-off." ]
  ].each do |name, body|
    GuestbookEntry.find_or_create_by!(name: name, body: body)
  end
  puts "Seeded #{GuestbookEntry.count} guestbook entries."
end
