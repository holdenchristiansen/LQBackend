class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_only, :except => :show

  # GET /ingredients
  # GET /ingredients.json
  def index
    @ingredients = Ingredient.where("LOWER(name) like ?", "%#{params[:q] ? params[:q].downcase : ''}%").paginate(:page => params[:page], :per_page => 198).order(:name)
    @condition = "%#{params[:q] ? params[:q].downcase : ''}%"
    #@ingr_json = Ingredient.find_by_sql("SELECT DISTINCT id, name FROM ingredients WHERE (LOWER(name) like '%"+  @condition +"%' AND secondaryname = '') UNION (SELECT DISTINCT id,  CONCAT(name,' (',secondaryname, ')') AS name FROM ingredients WHERE (LOWER(secondaryname) like '%"+  @condition +"%'))")
    @ingr_json = Ingredient.find_by_sql("SELECT DISTINCT id, name FROM ingredients WHERE (LOWER(name) like '%"+  @condition +"%')")    

    respond_to do |format|
        format.html
        format.json {render :json => @ingr_json.map(&:attributes)}
    end
  end

  # GET /ingredients/1
  # GET /ingredients/1.json
  def show
  end

  # GET /ingredients/new
  def new
    @ingredient = Ingredient.new
  end

  # GET /ingredients/1/edit
  def edit
  end

  def update_optionalsetname(new_ingredient)
    if (new_ingredient[:secondaryname].blank?)
      unless (new_ingredient[:image_url].blank? || new_ingredient[:image_url].nil?)
        @file = new_ingredient[:image_url].original_filename.downcase
        new_ingredient[:optionalassetname] = File.basename(@file,".*")
      end
    else
      unless (new_ingredient[:image_url].blank? || new_ingredient[:image_url].nil?)
        @file = new_ingredient[:image_url].original_filename.downcase
        new_ingredient[:optionalassetname] = File.basename(@file,".*")
      else
        @file = Ingredient.select(:optionalassetname).where("name like ?", new_ingredient[:secondaryname]).first
        unless @file.optionalassetname.nil?
          new_ingredient[:optionalassetname] = @file.optionalassetname.downcase
        end
      end
    end
    return new_ingredient
  end

  # POST /ingredients
  # POST /ingredients.json
  def create

    @new_ingredient = self.update_optionalsetname(ingredient_params.dup)
    @ingredient = Ingredient.new(@new_ingredient)

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to ingredients_url, notice: 'Ingredient was successfully created.' }
        format.json { render :show, status: :created, location: @ingredient }
      else
        format.html { render :new }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredients/1
  # PATCH/PUT /ingredients/1.json
  def update
    @new_ingredient = ingredient_params.dup

    @new_ingredient = self.update_optionalsetname(ingredient_params.dup)

    respond_to do |format|
      if @ingredient.update(@new_ingredient)
        format.html { redirect_to ingredients_url, notice: 'Ingredient was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingredient }
      else
        format.html { render :edit }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1
  # DELETE /ingredients/1.json
  def destroy
    @ingredient.destroy
    respond_to do |format|
      format.html { redirect_to ingredients_url, notice: 'Ingredient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_params
      params.require(:ingredient).permit(:scratchedoffshoppingcart, :shoppingcart, :name, :optionalassetname, :secondaryname, :type, :cabinet, :primary_name, :image_url, :image_highlight_url)
    end

  private
  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end
end
