class CategoriesController < ApplicationController

    def index
        @categories = Category.all
        render json:@categories, status: :ok
    end

    def show
        @category = Category.find_by(id: params[:id])
        render json:@category, status: :ok
    end

    def create
        category = Category.new(category_params)

        if category.save
          render json: { message: 'category created' }, status: :created
        else
          render json: { error: category.errors.full_messages.first }, status: :unprocessable_entity
        end
    end

    def destroy
        category = Category.find(params.require(:id))

        if category.destroy
          render json: { message: 'category deleted' }, status: :ok
        else
          render json: { error: 'Error deleting category' }, status: :unprocessable_entity
        end
    end

    def category_params
        params.require(:category).permit(:name)
    end
end
