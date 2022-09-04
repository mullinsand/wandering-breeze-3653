class ContestantsController < ApplicationController
  def index
    @contestants_name_projects = Project.pluck(:name)
  end
end