class LinksController < ApplicationController
  before_action :set_link, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new edit create update destroy]

  before_action do
    set_meta_tags site: "Hākuturi News"
  end

  def index
    page = (params[:page] || "1").to_i
    limit = (params[:limit] || "10").to_i
    @links = Link.all.order(created_at: :desc).page(page).per(limit)
  end

  def show
  end

  def new
    @link = Link.new
    authorize @link
  end

  def edit
    authorize @link
  end

  def create
    @link = Link.new(link_params)
    authorize @link

    respond_to do |format|
      if @link.url.present? && params[:commit] == "Crawl"
        @link.crawl
        format.html { render :new }
      elsif @link.save
        format.html { redirect_to links_path, notice: "Link was successfully created." }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @link
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to links_path, notice: "Link was successfully updated." }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @link
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: "Link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:title, :url, :body, :created_at)
  end
end
