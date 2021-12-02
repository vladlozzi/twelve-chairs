class SubcategoriesController < ApplicationController
  before_action :set_subcategory, only: %i[ show edit update destroy ]
  before_action :set_categories_for_select, only: %i[ new edit create update ]
  before_action :set_admin, only: %i[ new create edit update destroy ]

  # GET /subcategories or /subcategories.json
  def index
    @subcategories = Subcategory.all
  end

  # GET /subcategories/1 or /subcategories/1.json
  def show
  end

  # GET /subcategories/new
  def new
    @subcategory = Subcategory.new
  end

  # GET /subcategories/1/edit
  def edit
  end

  # POST /subcategories or /subcategories.json
  def create
    @subcategory = Subcategory.new(subcategory_params)

    respond_to do |format|
      if @subcategory.save
        format.html { redirect_to @subcategory, notice: "Subcategory was successfully created." }
        format.json { render :show, status: :created, location: @subcategory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subcategories/1 or /subcategories/1.json
  def update
    respond_to do |format|
      if @subcategory.update(subcategory_params)
        format.html { redirect_to @subcategory, notice: "Subcategory was successfully updated." }
        format.json { render :show, status: :ok, location: @subcategory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subcategories/1 or /subcategories/1.json
  def destroy
    @subcategory.destroy
    respond_to do |format|
      format.html { redirect_to subcategories_url, notice: "Subcategory was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subcategory
      @subcategory = Subcategory.find(params[:id])
    end

    def set_admin
      redirect_to(root_path) unless current_user.is_admin
    end

    # Only allow a list of trusted parameters through.
    def subcategory_params
      params.require(:subcategory).permit(:subcategory, :category_id)
    end

    def set_categories_for_select
      @categories_for_select = []
      Category.select("category, id").each do |row|
        @categories_for_select.push([row[:category], row[:id]])
      end
    end

end