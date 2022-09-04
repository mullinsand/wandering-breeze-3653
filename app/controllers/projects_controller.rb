class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @challenge_theme = Challenge.find(@project.challenge_id).theme
    @contestant_count = @project.count_contestants
    @project_cont_avg_exp = @project.contestant_avg_exp
  end
end