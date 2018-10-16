class EventType < ApplicationRecord
    belongs_to :user
    has_many :cancel_events
end
