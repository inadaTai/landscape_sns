class NotificationsController < ApplicationController
  before_action :logged_in_user

  def index
    @notifications=current_user.passive_notifications.page(params[:page]).paginate(page: params[:page])
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
