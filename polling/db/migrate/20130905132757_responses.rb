class Responses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :question_id
      t.integer :answer_choice_id

      t.timestamps
    end

    add_index(:responses, [:question_id, :answer_choice_id])
  end
end
