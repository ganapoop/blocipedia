class CollaborationsController < ApplicationController
  def create
    wiki = Wiki.find(params[:wiki_id])
    user = User.find(params[:user_id])

    if Collaborator.create(user: user, wiki: wiki)
      redirect_to edit_wiki_path(wiki)
    else
      flash[:alert]
      "You have to upgrade to premium!"
    end
  end

  def destroy
    collaboration = Collaborator.find_by(user_id: params[:user_id], wiki_id: params[:wiki_id])

    if collaboration.try(:delete)
      collaboration.delete
      redirect_to edit_wiki_path(params[:wiki_id])
    else
      flash[:alert]
      "You cannot delete this collaboration!"
    end
  end
end
