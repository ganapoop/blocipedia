
class WikiPolicy < ApplicationPolicy

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?
    @wiki.public || @user.present? && (@user.admin? || @wiki.user == @user)
  end

  def new?
    if @user.present?
      @user.admin? || @user.premium?
    else
      false
    end
  end

  def create?
    if @wiki.private
      @user.admin? || @user.premium?
    else
      true
    end
  end

  def edit?
    if @wiki.private
      @user.admin? || @wiki.user == @user || @user.premium?
    else
      true
    end
  end

  def update?
    edit?
  end

  def destroy?
    if @user == nil
      false
    else
      @user.admin? || @wiki.user == user
    end
  end

  def allowed_params
    if @user.admin? || @user.premium?
      [:title, :body, :private]
    else
      [:title, :body]
    end
  end


  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.nil?
        scope.all.each do |wiki|
          if wiki.public
            wikis << wiki
          end
        end
      elsif user.admin?
        wikis = scope.all
      else
        scope.all.each do |wiki|
          if wiki.public || Collaboration.exists?(user_id: user.id, wiki: wiki.id) || wiki.user == user
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end
