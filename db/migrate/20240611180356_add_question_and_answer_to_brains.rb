class AddQuestionAndAnswerToBrains < ActiveRecord::Migration[7.1]
  def change
    add_column :brains, :question, :string
    add_column :brains, :answer, :string
  end
end
