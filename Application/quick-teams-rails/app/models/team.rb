class Team < ApplicationRecord
    belongs_to :course
    has_one :message_board
end
