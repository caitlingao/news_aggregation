class BannerUploader < BaseUploader
  def filename
    if super.present?
      @name ||= SecureRandom.hex(3)
      "banner/#{model.id}/#{@name}.#{file.extension.downcase}"
    end
  end
end
