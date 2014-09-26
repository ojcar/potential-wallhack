class User < ActiveRecord::Base
  has_many :quizzes
  has_and_belongs_to_many :roles

  def admin?
  	roles.map(&:name).include?('admin')
  end
end
