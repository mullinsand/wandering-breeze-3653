class ContestantsController < ApplicationController
  def index
    @contestants_name_projects = Contestant.all
  end
end