class Modality < ApplicationRecord
    validates_presence_of :name, :max_students
end
