class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
  :recoverable, :rememberable, :trackable, :validatable
  has_many :wikis

  validates :role, presence: true

  enum role: [:standard, :premium, :admin]

  def downgrade!
    self.update(role: 'standard')
    make_wikis_public_if_not_premium
  end

  def make_wikis_public_if_not_premium
    if self.role == 'standard'
      self.wikis.each do |wiki|
        wiki.update(private: false)
      end
    end
  end

end
