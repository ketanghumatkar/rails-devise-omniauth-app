class VisitorsController < ApplicationController
  before_action :authenticate_user!

  def index
    @visitors = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @visitors }
    end
  end
end
