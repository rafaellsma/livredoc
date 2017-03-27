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

    private

    def document_params
      params.permit(:document_id, :file)
    end
  end
end
