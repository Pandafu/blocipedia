class WikisController < ApplicationController
  before_action :authorize_user, except: [:index, :show, :new, :edit, :create, :update]
  before_action :sign_in_required, except: [:index, :show]

  def index
    @wikis = Wiki.all
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
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki post was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:body, :title, :private)
  end

  def authorize_user
    unless current_user.admin?
      flash[:alert] = "You are not authorized to do that."
      redirect_to wikis_path
    end
  end
end
