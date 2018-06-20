class AddItemReferenceToLog < ActiveRecord::Migration[5.2]
  def change
    add_reference :logs, :item, foreign_key: true
  end
end
