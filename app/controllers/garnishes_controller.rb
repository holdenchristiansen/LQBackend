class GarnishesController < ApplicationController
  before_action :set_garnish, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_only, :except => :show

  # GET /garnishes
  # GET /garnishes.json
  def index
    @garnishes = Garnish.where("LOWER(name) like ?", "%#{params[:q] ? params[:q].downcase : ''}%").paginate(:page => params[:page], :per_page => 198).order(:name)
    respond_to do |format|
        format.html
        format.json {render :json => @garnishes.map(&:attributes)}
    end
  end

  # GET /garnishes/1
  # GET /garnishes/1.json
  def show
  end

  # GET /garnishes/new
  def new
    @garnish = Garnish.new
  end

  # GET /garnishes/1/edit
  def edit
  end

  # POST /garnishes
  # POST /garnishes.json
  def create
    @garnish = Garnish.new(garnish_params)

    respond_to do |format|
      if @garnish.save
        format.html { redirect_to garnishes_url, notice: 'Garnish was successfully created.' }
        format.json { render :show, status: :created, location: @garnish }
      else
        format.html { render :new }
        format.json { render json: @garnish.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /garnishes/1
  # PATCH/PUT /garnishes/1.json
  def update
    respond_to do |format|
      if @garnish.update(garnish_params)
        format.html { redirect_to garnishes_url, notice: 'Garnish was successfully updated.' }
        format.json { render :show, status: :ok, location: @garnish }
      else
        format.html { render :edit }
        format.json { render json: @garnish.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /garnishes/1
  # DELETE /garnishes/1.json
  def destroy
    @garnish.destroy
    respond_to do |format|
      format.html { redirect_to garnishes_url, notice: 'Garnish was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_garnish
      @garnish = Garnish.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def garnish_params
      params.require(:garnish).permit(:name)
    end

  private
  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end
end
