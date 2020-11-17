class Team < ApplicationRecord
    belongs_to :course
    has_one :message_board
    has_many :requests
    has_and_belongs_to_many :users
    has_many :tasks
    validates :name, :liaison_id, :maximum_capacity, :minimum_capacity, :deadline, :course_id, presence: true
    validates :name, uniqueness: true
end