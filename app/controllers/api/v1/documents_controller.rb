# frozen_string_literal: true

module Api
  module V1
    class DocumentsController < ApiBaseController
      before_action :set_document, except: :create
      before_action :authenticate_api_v1_api_v1_user!

      after_action :verify_authorized

      def delete_document_attachment
        authorize @document
        doc = @document.files.find(params[:id_attachment])
        doc.purge_later
        @document.delete_file!(current_api_v1_api_v1_user.id, doc.filename.to_s)
        render :show
      end

      def add_document_attachment
        authorize @document
        if @document.files.size < @document.document_number
          params[:files].each_value do |v|
            break unless @document.upload_file?

            @document.files.attach(v)
            @document.uploaded_file!(current_api_v1_api_v1_user.id, v.original_filename)
          end
          render :show
        else
          render json: { error: 'Document size full' }, status: :unprocessable_entity
        end
      end

      def export_document
        authorize @document
        @document.export!(current_api_v1_api_v1_user.id)
        CreatePdfFromDocumentAttachmentsJob.perform_async(@document.id)
        render :show
      end

      def history
        authorize @document
        @history = DocumentHistory.where(document: @document).order(created_at: :desc)
        render :index_history
      end

      # POST /documents or /documents.json
      def create
        @document = Document.new(document_create_params)
        authorize @document
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
        authorize @document
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
        authorize @document
        @document.destroy!

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
        params.require(:document).permit(:name, :tax_income_id, :files, :document_number)
      end
    end
  end
end
