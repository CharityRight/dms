ROM::SQL.migration do
  change do
    create_table :donations do
      primary_key :id
      column :donor_id, :int, null: false, index: true
      column :amount, :int, null:false
      column :currency, :text, null: false
      column :donation_type, :int, null: false, index: true
      column :zakat, :boolean, default: false, index: true
      column :created_at, :timestamp, null: false, default: Sequel.lit("(now() at time zone 'utc')")
      column :updated_at, :timestamp, null: false, default: Sequel.lit("(now() at time zone 'utc')")
    end
  end
end
