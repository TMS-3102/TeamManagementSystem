class TasksController < ApplicationController
    def index
        @team = Team.find params[:team_id]
        @tasks = @team.tasks
    end

    def update
        @task = params[:id]
        @task.update(task_params)
        redirect_to "/teams/#{params[:team_id]}/tasks"
    end

    def create
        @task = Task.new(task_params)
        @task.team_id = params[:team_id]
        @task.save
        redirect_to "/teams/#{params[:team_id]}/tasks"
    end

    def destroy
        @task = params[:id]
        @task.destroy(task_params)
        redirect_to "/teams/#{params[:team_id]}/tasks"
    end

    private
        def task_params
            params.require(:task).permit(:description, :title, :deadline, :completed, :order, :priority)
        end

end