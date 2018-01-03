ROM::SQL.migration do
  change do
    create_table :causes do
      primary_key :id
      column :name, :text, null: false, index:true
      column :code, :text, null: false, index:true
      column :description, :text
      column :created_at, :timestamp, null: false, default: Sequel.lit("(now() at time zone 'utc')")
      column :updated_at, :timestamp, null: false, default: Sequel.lit("(now() at time zone 'utc')")
    end
  end
end
