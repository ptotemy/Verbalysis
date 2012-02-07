class CreateAnswerTags < ActiveRecord::Migration
def self.up
create_table :answer_tags do |t|
      t.integer :answer_id
      t.integer :tag_id
t.timestamps
    end
  end

  def self.down
    drop_table :answer_tags
  end
end


