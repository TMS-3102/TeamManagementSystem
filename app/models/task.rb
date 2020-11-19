class Task < ApplicationRecord
    belongs_to :team
    has_and_belongs_to_many :users

    default_scope { order(order: :asc) }
end