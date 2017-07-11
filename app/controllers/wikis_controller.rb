class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    unless WikiPolicy.new(current_user, @wiki).show?
      flash[:alert] = "You are not authorized to view this wiki."
      redirect_to new_wikis_path
    end
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.includes(:wikis).all
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki
    if @wiki.save!
      flash[:notice] = "Your wiki was saved successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving your wiki. Please try again later."
      render :new
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.attributes=(wiki_params)

    if @wiki.save && (@wiki.user == current_user || current_user.admin?)
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    elsif @wiki.save
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
