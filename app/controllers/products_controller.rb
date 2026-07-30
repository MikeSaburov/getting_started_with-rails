class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id]) #получаем товар по id
  end

  # 1. Этот метод срабатывает, когда мы переходим по кнопке "Добавить новый товар"
  def new
    @product = Product.new # Создаем пустой чертеж товара для будущей формы
  end

  def create
    # Применяем Strong Parameters (нашу защиту от хакеров)
    product_params = params.require(:product).permit(:name, :price)
    
    # Создаем товар с безопасными параметрами
    @product = Product.new(product_params)

    # Пытаемся сохранить в базу данных
    if @product.save
      redirect_to products_path # Если всё ок — возвращаем пользователя на главную
    else
      # Если сработала валидация (имя пустое) — заново рисуем страницу формы (new.html.erb)
      render :new, status: :unprocessable_entity 
    end
  end

  # 1. Этот метод находит товар по ID и автоматически открывает вьюху edit.html.erb
  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    
    # ВОТ ЭТОЙ СТРОКИ У ВАС НЕ ХВАТАЛО:
    product_params = params.require(:product).permit(:name, :price)

    if @product.update(product_params)
      # Перенаправляем на страницу этого конкретного товара (show)
      redirect_to product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end
end
