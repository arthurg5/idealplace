class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    @groups = current_user.groups
    @group = Group.new
  end
end
