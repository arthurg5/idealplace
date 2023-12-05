# controllers/notifications_controller.rb
class NotificationsController < ApplicationController
  def index
    # get the notifications for the current user
    # add a .all method to ensure the variable is not nil
    @notifications = current_user.notifications.all
    # render the notification partial as a response
    render partial: 'notifications/notification'
  end
end
