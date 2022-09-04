class ContestantsController < ApplicationController
  def index
    @contestants_name_projects = Contestant.all
  end

  def update
    ContestantProject.create(contestant_id: params[:contestant_id], project_id: params[:project_id])
    redirect_to "/projects/#{params[:project_id]}"
  end
end