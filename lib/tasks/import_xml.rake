require 'nokogiri'

namespace :import do
  desc "Import cars from XML file"
  task cars: :environment do
    xml_file = File.open('путь/к/вашему/файлу.xml')
    doc = Nokogiri::XML(xml_file)

    doc.xpath('//car').each do |car_node|
      car = Car.new

      car_node.elements.each do |element|
        next if element.name == 'images'
        car[element.name] = element.text if car.has_attribute?(element.name)
      end

      if car.save
        car_node.xpath('.//image').each do |image_node|
          car.images.create(image_url: image_node.text)
        end
        puts "Сохранен автомобиль: #{car.mark_id} #{car.model_name}"
      else
        puts "Ошибка сохранения автомобиля: #{car.errors.full_messages.join(', ')}"
      end
    end

    puts "Импорт завершен"
  end
end
