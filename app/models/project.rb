class Project < ApplicationRecord
  validates_presence_of :name, :material
  belongs_to :challenge
  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects

  def count_contestants
    contestants.count
  end

  def contestant_avg_exp
    return 0 if contestants.empty?
    contestants.average(:years_of_experience).round(2)
  end
end