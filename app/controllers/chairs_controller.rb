class ChairsController < ApplicationController
  before_action :set_chair, only: %i[ show edit update destroy ]
  before_action :set_subcategories_for_select, only: %i[ new edit create update ]
  before_action :set_admin, only: %i[ new create edit update destroy ]

  # GET /chairs or /chairs.json
  def index
    @chairs = Chair.all
  end

  # GET /chairs/1 or /chairs/1.json
  def show
  end

  # GET /chairs/new
  def new
    @chair = Chair.new
  end

  # GET /chairs/1/edit
  def edit
  end

  # POST /chairs or /chairs.json
  def create
    @chair = Chair.new(chair_params)

    respond_to do |format|
      if @chair.save
        format.html { redirect_to @chair, notice: "Chair was successfully created." }
        format.json { render :show, status: :created, location: @chair }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chair.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chairs/1 or /chairs/1.json
  def update
    respond_to do |format|
      if @chair.update(chair_params)
        format.html { redirect_to @chair, notice: "Chair was successfully updated." }
        format.json { render :show, status: :ok, location: @chair }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chair.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chairs/1 or /chairs/1.json
  def destroy
    @chair.destroy
    respond_to do |format|
      format.html { redirect_to chairs_url, notice: "Chair was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chair
      @chair = Chair.find(params[:id])
    end

    def set_admin
      redirect_to(root_path) unless current_user.is_admin
    end

    # Only allow a list of trusted parameters through.
    def chair_params
      params.require(:chair).permit(:subcategory_id, :chair, :price)
    end

    def set_subcategories_for_select
      @subcategories_for_select = []
      Subcategory.select("subcategory, id").each do |row|
        @subcategories_for_select.push([row[:subcategory], row[:id]])
      end
    end

end