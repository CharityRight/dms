ROM::SQL.migration do
  change do
    add_column :causes, :active, TrueClass, null: false, default: false
  end
end
