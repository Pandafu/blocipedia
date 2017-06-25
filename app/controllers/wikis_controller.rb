class WikisController < ApplicationController
before_action :set_wiki, only: [:show, :edit, :update, :destroy]

  def index
    @wikis = Wiki.all
    authorize @wikis
  end

  def show
    #@wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    #@wiki = Wiki.new(wiki_params)
    @wiki = current_user.wikis.create(wiki_params)
    @wiki.user = current_user
    authorize @wiki
     @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    if @wiki.save
      flash[:notice] = "Wiki post saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "Error. Please try again."
      render :new
    end
  end

  def edit
    #@wiki = Wiki.find(params[:id])
  end

  def update
    #@wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    if @wiki.update(article_params)
      flash[:notice] = "Wiki post was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    #@wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def wiki_params
    params.require(:wiki).permit(:body, :title, :user_id)
  end

end
