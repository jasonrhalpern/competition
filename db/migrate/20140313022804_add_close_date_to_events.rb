class AddCloseDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :close_date, :date
  end
end
