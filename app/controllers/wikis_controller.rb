class WikisController < ApplicationController
  before_action :authenticate_user!

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki =  Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.wikis.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki post saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "Error. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update(wiki_params)
      flash[:notice] = "Wiki post was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
  end

  def add_as_collaborator
    @wiki = Wiki.find(params[:id])
    collaborator = User.find_by(email: params[:collaborator_email])
    #check if the wiki exists and check if user is authorize
    #check if collaborator doesn't exist
      if current_user.premium? || current_user.admin?
        @wiki.add_collaborator(collaborator)
      end
        redirect_to @wiki
  end

  def remove_as_collaborator
    @wiki = Wiki.find(params[:id])
    collaborator = User.find(params[:user_id])
    if current_user.premium? || current_user.admin?
      if @wiki.check_collaborator(collaborator)
        @wiki.remove_collaborator(collaborator)
      else
        flash.now[:alert] = "The user is not a collaborator."
      end
    end
      redirect_to @wiki
  end

  private

  def wiki_params
    params.require(:wiki).permit(:body, :title, :private)
  end
end
