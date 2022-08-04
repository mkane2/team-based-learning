class ChangeBodyToChoiceBody < ActiveRecord::Migration[5.1]
  def change
    rename_column :choices, :body, :choice_body
  end
end
