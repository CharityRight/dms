ROM::SQL.migration do
  change do
    add_column :causes, :location, String, null: false
  end
end
