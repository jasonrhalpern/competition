class CreateDistinctions < ActiveRecord::Migration
  def change
    create_table :distinctions do |t|
      t.string :type

      t.timestamps
    end
  end
end
