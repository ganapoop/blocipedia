class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.belongs_to :wiki
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
