class TextsController < ApplicationController
  include TextsHelper

  before_action :set_text, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new edit create update destroy]

  before_action do
    set_meta_tags site: "Hākuturi Texts"
  end

  def index
    page = (params[:page] || "1").to_i
    limit = (params[:limit] || "20").to_i
    @texts = Text.all.order(published_on: :desc).page(page).per(limit)
  end

  def show
    respond_to do |format|
      format.html
      format.text
      format.epub do
        send_data(render_epub(@text), filename: "#{@text.id}.epub", type: "application/epub")
      end
    end
  end

  def new
    @text = Text.new
    authorize @text
  end

  def edit
    authorize @text
  end

  def create
    @text = Text.new(text_params)
    authorize @text

    respond_to do |format|
      if @text.save
        format.html { redirect_to @text, notice: "Text was successfully created." }
        format.json { render :show, status: :created, location: @text }
      else
        format.html { render :new }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @text
    respond_to do |format|
      if @text.update(text_params)
        format.html { redirect_to @text, notice: "Text was successfully updated." }
        format.json { render :show, status: :ok, location: @text }
      else
        format.html { render :edit }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @text
    @text.destroy
    respond_to do |format|
      format.html { redirect_to texts_url, notice: "Text was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_text
    @text = Text.find(params[:id])
  end

  def text_params
    params.require(:text).permit(:title, :author, :body, :source, :published_on)
  end
end
