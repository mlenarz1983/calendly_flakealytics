# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

eventTypes = %w[30min coffee walkAndTalk]
names = %w[Thelonious Sara Matt Felicia Alton]
emailDomains = %w[gmail.com hotmail.com yahoo.com dear_leader.gov.nk]
reasons = ["sick", "lazy", "asteroid", "dog ate homework"]

User.destroy_all
EventType.destroy_all
CancelEvent.destroy_all

1.times do
    user = User.create(
        email_address:'fake_user@gmail.com', 
        first_name:'Fake', 
        last_name: 'User', 
        avatar_url: 'https://d3v0px0pttie1i.cloudfront.net/uploads/user/avatar/1887449/24b2bc5e.png'
    )

    eventTypes.each do |e|
        eventRow = user.event_types.create(
            name: e
        )

        (Date.new(2018, 10, 10)..Date.new(2018, 10, 17)).each do |d|

            rand(1..20).times do

                name = names[rand(names.length)]
                email = name + "@" + emailDomains[rand(emailDomains.length)]


                event = eventRow.cancel_events.create(
                    invitee_name: name,
                    invitee_email: email,
                    reason: reasons[rand(reasons.length)]
                )

                # p event.errors 

                event.created_at = d
                event.updated_at = d
                event.save
            end
        end
    end
end

