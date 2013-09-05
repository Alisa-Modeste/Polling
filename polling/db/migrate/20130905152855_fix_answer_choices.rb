class FixAnswerChoices < ActiveRecord::Migration
  def change
    change_table :answer_choices do |t|
      t.column(:response_id, :integer)
    end
  end
end
