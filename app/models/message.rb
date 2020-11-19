class Message < ApplicationRecord
    belongs_to :message_board

    default_scope { order(priority: :asc) }
end
