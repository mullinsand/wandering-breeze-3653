class ContestantsController < ApplicationController
  def index
    @contestants_name_projects = Contestant.all
  end

  def create
    project = Project.find(params[:project_id])
    project.contestants.create(contestant_params)
    redirect_to "/projects/#{project.id}"
  end

  private
  def contestant_params
    params.permit(:name, :age, :hometown, :years_of_experience)
  end
end