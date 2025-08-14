class Admin::JobsController < ApplicationController
  def index
    @week = Week.find(params[:week_id])
    @users = User.all
  end
end
