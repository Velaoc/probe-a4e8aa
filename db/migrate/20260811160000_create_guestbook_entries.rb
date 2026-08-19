class CreateGuestbookEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :guestbook_entries do |t|
      t.string :name, limit: 60
      t.text :body, null: false

      t.timestamps
    end
  end
end
