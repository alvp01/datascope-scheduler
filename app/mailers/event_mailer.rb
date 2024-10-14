class EventMailer < ApplicationMailer
  def event_created(event, user)
    @event = event
    @user = user

    mail(
      to: "admin@example.com", # Replace with your personal email
      from: ENV["ADMIN_EMAIL"], # Make sure this environment variable is set
      subject: "New Event Created: #{@event.location}"
    ) do |format|
      format.text { render plain: email_body } # Use render plain for the email body
    end
  end

  private

  def email_body
    <<~BODY
      A new event has been created with the following details:

      Location: #{@event.location}
      Start Time: #{@event.start_time.strftime("%A, %B %d, %Y %I:%M %p")}
      End Time: #{@event.end_time.strftime("%A, %B %d, %Y %I:%M %p")}

      Created for: #{@user.name} (Email: #{@user.email})

      Please log into the system to view or manage the event.
    BODY
  end
end
