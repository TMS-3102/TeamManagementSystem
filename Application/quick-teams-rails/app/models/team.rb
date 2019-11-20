class Team < ApplicationRecord
    belongs_to :course
    has_one :message_board
    has_and_belongs_to_many :users
end