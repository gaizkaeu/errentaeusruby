module Api::V1

class DocumentsController < ApiBaseController
  before_action :set_document, only: %i[ show edit update destroy delete_document_attachment ]
  skip_before_action :verify_authenticity_token

  # GET /documents or /documents.json
  def index
    @documents = Document.all
  end

  def delete_document_attachment
    doc = @document.data.find(params[:id_attachment])
    doc.purge
    render :show
  end

  # GET /documents/1 or /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents or /documents.json
  def create
    @document = Document.new(document_create_params)

    respond_to do |format|
      if @document.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1 or /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.json { render :show, status: :ok }
      else
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1 or /documents/1.json
  def destroy
    @document.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def document_create_params
      params.require(:document).permit(:name, :description, :tax_income_id, :requested_by_id, :requested_to_id, :data)
    end
end
end
