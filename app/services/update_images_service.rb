class UpdateImagesService
    def initialize(images_params)
      @images_params = images_params
    end
  
    def call
      @images_params.each do |image_params|
        image = Image.find_by(id: image_params[:id])
        if image
          image.update(url: image_params[:url], car_id: image_params[:car_id])
        end
      end
    end
  end