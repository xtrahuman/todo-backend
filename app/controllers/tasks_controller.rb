class TasksController < ApplicationController
    def index
        @category = Category.find(params[:category_id])
        @tasks = @category.tasks.all.order('created_at ASC')
        render json:@tasks, status: :ok
    end

    def show
        @category = Category.find_by(id: params[:category_id])
        @task = @category.tasks.find(params[:id])
        render json:@task, status: :ok
    end

    def create
        category = Category.find_by(id: params[:category_id])
        task = category.tasks.new(task_params)

        if task.save
          render json: { message: 'task created' }, status: :created
        else
          render json: { error: task.errors.full_messages.first }, status: :unprocessable_entity
        end
    end

    def destroy
        category = Category.find_by(id: params[:category_id])
        task = category.tasks.find(params.require(:id))

        if task.destroy
          render json: { message: 'task deleted' }, status: :ok
        else
          render json: { error: 'Error deleting task' }, status: :unprocessable_entity
        end
    end

    def update
        task = Task.find(params.require(:id))
        update_task = task.update(task_params)

        if update_task
          render json: { message: 'task updated' }, status: :ok
        else
          render json: { error: 'error updating tasks' }, status: :unprocessable_entity
        end
    end

    def task_params
        params.require(:task).permit(:name, :description, :completed)
    end
end
