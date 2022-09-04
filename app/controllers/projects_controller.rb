class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @challenge_theme = Challenge.find(@project.challenge_id).theme
    @contestant_count = @project.count_contestants
  end
end