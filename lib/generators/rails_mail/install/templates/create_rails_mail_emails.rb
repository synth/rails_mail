class CreateRailsMailEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :rails_mail_emails do |t|
      t.string :from
      t.text :to
      t.text :cc
      t.text :bcc
      t.string :subject
      t.text :body
      t.string :content_type
      t.text :attachments

      t.timestamps
    end
  end
end 