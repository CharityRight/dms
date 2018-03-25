ROM::SQL.migration do
  change do
    add_column :donations, :correlation_id, String, null: false, index: true
  end
end
