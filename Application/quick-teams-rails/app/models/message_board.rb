class MessageBoard < ApplicationRecord
    belongs_to :team
    has_many :messages
end
