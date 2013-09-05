class FixResponses < ActiveRecord::Migration
  def change
    change_table :responses do |t|
      t.column(:user_id, :integer)
    end

  end
end
