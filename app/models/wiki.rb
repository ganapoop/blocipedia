class Wiki < ActiveRecord::Base

  default_scope { order('created_at DESC') }

  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  def public
    not self.private
  end

  def update_collaborators(collaborator_string)
    return if collaborator_string.blank?
    collaborator_string.split(",").map do |email|
      user = User.find_by_email(email)
      collaborators.create(user: user)
    end
  end
end
