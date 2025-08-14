class Public::WeeksController < ApplicationController
  def index
    @weeks = Week.all
  end
end
