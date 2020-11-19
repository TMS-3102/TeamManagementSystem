class TasksController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        @team = Team.find params[:team_id]
        @tasks = @team.tasks

        respond_to do |format|
            format.html
            format.json
        end
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

    def bulk_update
        @team = Team.find params[:team_id]

        params[:tasks].each do |task|
            current_task = Task.find task[:task][:id]
            current_task.update(order: task[:task][:order])
        end

        @tasks = @team.tasks

        respond_to do |format|
            format.json 
        end
    end

    private
        def task_params
            params.require(:task).permit(:description, :title, :deadline, :completed, :order, :priority)
        end

end