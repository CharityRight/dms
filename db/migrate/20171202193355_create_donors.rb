# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :donors do
      primary_key :id
      column :email, :text, null: false, index: true
      column :first_name, :text, null: false
      column :last_name, :text, null: false
      column :created_at, :timestamp, null: false, default: Sequel.lit("(now() at time zone 'utc')")
      column :updated_at, :timestamp, null: false, default: Sequel.lit("(now() at time zone 'utc')")
    end
  end
end
