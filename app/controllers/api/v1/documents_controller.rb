module Api::V1
  class DocumentsController < ApiController
    def create
      @document = Document.new(document_params)

      if @document.save
        render json: @document, status: :created
      else
        render json: @document.errors, status: :unprocessable_entity
      end
    end

    def show
      document = nil

      begin
        document = Document.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        document = nil
      end

      if document
        send_file document.file.pdf.path
      else
        render json: { 'message': 'Not found' }, status: :not_found
      end
    end

    private

    def document_params
      params.permit(:document_id, :file)
    end
  end
end
