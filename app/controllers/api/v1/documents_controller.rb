module Api::V1

class DocumentsController < ApiBaseController
  before_action :set_document, except: %i[index, create]
  before_action :authenticate_api_v1_user!

  # GET /documents or /documents.json
  def index
    @documents = Document.all
  end

  def delete_document_attachment
    doc = @document.files.find(params[:id_attachment])
    doc.purge
    @document.delete_file!(current_api_v1_user, doc.filename)
    render :show
  end

  def add_document_attachment
    if @document.files.size < @document.document_number
      params[:files].values.each do |v|
        if @document.upload_file?
          @document.files.attach(v)
          @document.uploaded_file!(current_api_v1_user, v.original_filename)
        else
          break
        end
      end
      render :show
    else
      render json: {error: "Document size full"}, status: :unprocessable_entity
    end
  end

  def export_document
    CreatePdfFromDocumentAttachmentsJob.perform_later(@document)
    @document.export!(current_api_v1_user)
    render :show
  end

  def history
    @history = DocumentHistory.where(document: @document).order(created_at: :desc)
    render :index_history
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
      params.require(:document).permit(:name, :lawyer_id, :tax_income_id, :user_id, :files, :document_number)
    end
end
end