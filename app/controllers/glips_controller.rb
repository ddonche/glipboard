class GlipsController < ApplicationController
  before_action :set_glip, only: [:show, :edit, :update, :destroy]

  # GET /glips
  def index
    @glips = Glip.all
  end

  # GET /glips/1
  def show
  end

  # GET /glips/new
  def new
    @glip = Glip.new
  end

  # GET /glips/1/edit
  def edit
  end

  # POST /glips
  def create
    @glip = Glip.new(glip_params)

    respond_to do |format|
      if @glip.save
        format.html { redirect_to @glip, notice: 'You have a new Glip!' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /glips/1
  def update
    respond_to do |format|
      if @glip.update(glip_params)
        format.html { redirect_to @glip, notice: 'Glip was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /glips/1
  def destroy
    @glip.destroy
    respond_to do |format|
      format.html { redirect_to glips_url, notice: 'Glip was eradicated.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_glip
      @glip = Glip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def glip_params
      params.require(:glip).permit(:title, :content)
    end
end
