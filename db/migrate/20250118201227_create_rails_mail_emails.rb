class CreateRailsMailEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :rails_mail_emails do |t|
      t.json :data

      t.timestamps
    end
  end
end
