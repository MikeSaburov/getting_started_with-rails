class Product < ApplicationRecord
    validates :name, presence: { message: "не может быть пустым" }

    # Добавляем связь с картинкой
    has_one_attached :image
end
