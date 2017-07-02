class WikisController < ApplicationController

  def index
    @wikis = Wiki.visible_to(current_user)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def edit
    @wiki = Wiki.find(params[:id])
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


    if @wiki.save
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
  else
    flash[:alert] = "You must be admin or the wiki owner!."
    redirect_to wikis_path
  end
end

private

def wiki_params
  params.require(:wiki).permit(WikiPolicy.new(current_user, @wiki).allowed_params)
end
