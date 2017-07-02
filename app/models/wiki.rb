class Wiki < ActiveRecord::Base

  default_scope { order('created_at DESC') }
  
  belongs_to :user
  scope :visible_to, -> (user) { user ? all : where(private: false) }

  def public
    not self.private
  end
end
