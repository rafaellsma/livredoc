require 'rails_helper'

describe ConversionService do
  describe '#to_pdf' do
    context 'conversion ppt' do
      %w(ppt1 ppt2).each do |s|
        it 'Should create ' + s do
          path_pdf = "#{Rails.root}/public/files/#{s}.pdf"
          FileUtils.rm(path_pdf) if File.file? path_pdf
          described_class.to_pdf("#{Rails.root}/spec/files/ppt/#{s}.ppt")
          expect(File.read("#{Rails.root}/public/files/#{s}.pdf")).to_not be nil
        end
      end
    end

    context 'conversion pptx' do
      %w(pptx1 pptx2 pptx3).each do |s|
        it 'Should create ' + s do
          path_pdf = "#{Rails.root}/public/files/#{s}.pdf"
          FileUtils.rm(path_pdf) if File.file? path_pdf
          described_class.to_pdf("#{Rails.root}/spec/files/pptx/#{s}.pptx")
          expect(File.read(path_pdf)).to_not be nil
        end
      end
    end
  end
end
