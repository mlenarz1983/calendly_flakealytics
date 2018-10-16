class CancelEvent < ApplicationRecord
    # belongs_to :users
    belongs_to :event_type

    def self.getTimeStats(user)
        # stats are obtained via SQL because of joins and aggregates.  there may be a way to do
        # this with ActiveRecord, but I didn't see anything obvious.  it's okay to group 
        # by event type name (vs id) since we enforce uniqueness in the logic responsible for 
        # adding new event types to the db.  SQL param does not need to be sanitized because the contract
        # for this method uses a user object (which we can trust).  
        #
        # This query also returns a null id parameter.  I'd make sure this wasn't in the result set, but
        # I can't seem to find a way to stop this auto-magical behavior.
        CancelEvent.find_by_sql [
            "SELECT date(e.created_at) AS date, t.name AS eventType, count(*) AS instances
            FROM cancel_events e
                INNER JOIN event_types t ON e.event_type_id==t.id
            WHERE t.user_id=?
            GROUP BY t.name, date(e.created_at)
            ORDER BY event_type_id",
            user.id
        ]
    end
end
