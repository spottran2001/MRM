class AddReferenceFacultyToSubject < ActiveRecord::Migration[7.0]
  def change
    add_reference :subjects, :faculty, index: true
  end
end
