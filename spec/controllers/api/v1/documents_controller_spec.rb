require 'rails_helper'
require 'carrierwave/test/matchers'

describe Api::V1::DocumentsController, type: :api do
  include CarrierWave::Test::Matchers
  context 'POST create' do

    context 'when doesnt exist the secret token' do
      before do
        post 'api/v1/documents'
      end

      it 'responds with a 401 status' do
        expect(last_response.status).to eq 401
      end

      it 'responds with bad credentials' do
        expect(json['message']).to eq 'Bad credentials'
      end
    end

    context 'when secret token is invalid' do
      before do
        header "Authorization", "Token openredu1"
        post 'api/v1/documents'
      end

      it 'responds with a 401 status' do
        expect(last_response.status).to eq 401
      end

      it 'responds with bad credentials' do
        expect(json['message']).to eq 'Bad credentials'
      end
    end

    context 'when request is valid' do
      let(:file) do
        Rack::Test::UploadedFile.new(
          File.open(File.join("#{Rails.root}/spec/files/pptx/pptx4.pptx"))
        )
      end

      let(:valid_params) do
        {
          document_id: 15,
          file: file
        }
      end

      before do
        header "Authorization", "Token openredu"
        post 'api/v1/documents', valid_params
      end

      it 'responds with status 201' do
        expect(last_response.status).to be 201
      end

      it 'creates a valid document' do
        document = Document.find(json['id'])
        expect(document).to_not be nil
        expect(document.document_id).to be valid_params[:document_id]
        expect(document.file).to_not be nil
        expect(document.file.pdf).to_not be nil
      end

      context 'when create document with existing document_id' do
        before do
          header "Authorization", "Token openredu"
          post 'api/v1/documents', valid_params
        end

        it 'responds with status 422' do
          expect(last_response.status).to be 422
        end

        it 'shows errors' do
          expect(json['document_id']).to  contain_exactly(I18n.t('errors.messages.taken'))
        end
      end
    end

    context 'when request is not valid' do
      before do
        header "Authorization", "Token openredu"
        post 'api/v1/documents'
      end

      it 'responds with status 422' do
        expect(last_response.status).to be 422
      end

      it 'shows errors' do
        expect(json['file']).to  contain_exactly(I18n.t('errors.messages.blank'))
        expect(json['document_id']).to  contain_exactly(I18n.t('errors.messages.blank'))
      end

      context 'when extension file is invalid' do
        let!(:invalid_file) do
          Rack::Test::UploadedFile.new(
            File.open(File.join("#{Rails.root}/config/application.rb"))
          )
        end
        let!(:not_valid_extension_params) do
          {
            document_id: 1,
            file: invalid_file
          }
        end

        before do
          post 'api/v1/documents', not_valid_extension_params
        end

        it 'responds with status 422' do
          expect(last_response.status).to be 422
        end

        it 'shows errors' do

          expect(json['file']).to  contain_exactly(
            I18n.t('errors.messages.extension_whitelist_error'),
            I18n.t('errors.messages.blank')
          )
        end
      end
    end
  end

  context 'GET show' do
    context 'when doesnt exist the secret token' do
      before do
        get 'api/v1/documents/1'
      end

      it 'responds with a 401 status' do
        expect(last_response.status).to eq 401
      end

      it 'responds with bad credentials' do
        expect(json['message']).to eq 'Bad credentials'
      end
    end

    context 'when secret token is invalid' do
      before do
        header "Authorization", "Token openredu1"
        get 'api/v1/documents/1'
      end

      it 'responds with a 401 status' do
        expect(last_response.status).to eq 401
      end

      it 'responds with bad credentials' do
        expect(json['message']).to eq 'Bad credentials'
      end
    end

    context 'when request is valid' do
      let!(:document) { Document.create(document_id: 1, file: valid_file) }
      let!(:valid_file) do
        File.open(File.join("#{Rails.root}/spec/files/pptx/pptx4.pptx"))
      end
      before do
        header "Authorization", "Token openredu1"
        get 'api/v1/documents/1', id: document
      end

      it 'responds with a 200 status' do
      end
    end
  end
end
