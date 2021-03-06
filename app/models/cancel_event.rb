class CancelEvent < ApplicationRecord
    # belongs_to :users
    belongs_to :event_type

    def self.getTimeStats(user)
        # stats are obtained via SQL because of joins and aggregates.  there may be a way to do
        # this with ActiveRecord, but I didn't see anything obvious.  it's okay to group 
        # by event type name (vs id) since we enforce uniqueness in the logic responsible for 
        # adding new event types to the db.  SQL param does not need to be sanitized because the contract
        # for this method uses a user object (which we can trust).  
        time_stats = CancelEvent.find_by_sql [
            "SELECT date(e.created_at) AS date, t.name AS eventType, count(*) AS count
            FROM cancel_events e
                INNER JOIN event_types t ON e.event_type_id==t.id
            WHERE t.user_id=?
            GROUP BY t.name, date(e.created_at)
            ORDER BY event_type_id",
            user.id
        ]

        # my preferred contract here would be {eventType: [{date, count} ...], eventType: [{date, count} ...]}
        # none of the combinations of map + group_by that I tried did this, however...
        time_stats.group_by{|s| s.eventType }
    end

    def self.getEmailStats(user)
        # see comments in getTimeStats
        CancelEvent.find_by_sql [
            "SELECT substr(invitee_email, pos+1) AS emailProvider, count(*) AS count
            FROM
              (SELECT *, instr(invitee_email,'@') AS pos FROM cancel_events) e
              INNER JOIN event_types t ON e.event_type_id==t.id
            WHERE t.user_id=?
            GROUP BY substr(invitee_email, pos+1)",
            user.id
        ]
    end
end
