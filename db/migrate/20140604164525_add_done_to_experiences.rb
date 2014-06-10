class AddDoneToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :done, :boolean, null: false, default: false
    
    Experience.reset_column_information
    
    Experience.find_each do |exp|
      exp.update_attributes(done: true) if exp.status == 'Done!'
    end
  end
end
