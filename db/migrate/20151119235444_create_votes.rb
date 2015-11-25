class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :vote
      t.integer :user_id
      t.string :votable_type
      t.integer :votable_id
      t.timestamps

      t.index [:votable_type, :votable_id]


    end
  end
end
