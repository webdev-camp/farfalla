class ResellersController < AdminController
  before_action :set_reseller, only: [:show, :edit, :update, :destroy]

  # GET /resellers
  def index
    @q = Reseller.search params[:q]
    @reseller_scope = @q.result(:distinct => true)
    @resellers = @reseller_scope.paginate( :page => params[:page],:per_page => 20)
  end

  # GET /resellers/1
  def show
  end

  # GET /resellers/new
  def new
    @reseller = Reseller.new
  end

  # GET /resellers/1/edit
  def edit
  end

  # POST /resellers
  def create
    @reseller = Reseller.new(reseller_params)

    if @reseller.save
      redirect_to resellers_url, notice: 'Reseller was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /resellers/1
  def update
    if @reseller.update(reseller_params)
      redirect_to resellers_url, notice: 'Reseller was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /resellers/1
  def destroy
    @reseller.destroy
    redirect_to resellers_url, notice: 'Reseller was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reseller
      @reseller = Reseller.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reseller_params
      params.require(:reseller).permit(:name, :address, :city, :link , :post_code)
    end
end
