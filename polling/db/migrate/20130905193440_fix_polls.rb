class FixPolls < ActiveRecord::Migration
  def change
    change_table :polls do |t|
      t.column(:author_id, :integer)
    end
  end
end
