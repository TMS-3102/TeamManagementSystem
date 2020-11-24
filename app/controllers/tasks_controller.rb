class TasksController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        @team = Team.find params[:team_id]
        @tasks = @team.tasks
        @task = Task.new

        respond_to do |format|
            format.html
            format.json
        end
    end

    def update
        @task = Task.find params[:id]
        @task.update(task_params)
        if params[:user_id]
            user = User.find params[:user_id]
            @task.users << user
        end
        redirect_to "/teams/#{params[:team_id]}/tasks"
    end

    def create
        @task = Task.new(task_params)
        @task.team_id = params[:team_id]
        @task.save
        redirect_to "/teams/#{params[:team_id]}/tasks"
    end

    def destroy
        @task = Task.find params[:id]
        @task.destroy
        respond_to do |format|
            format.json
        end
    end

    def edit
        @task = Task.find params[:id]
        @team = Team.find params[:team_id]
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

    def remove_user
        @task = Task.find params[:id]
        @task.users.delete(User.find params[:user_id])
        respond_to do |format|
            format.json 
        end
    end

    def set_complete
        @task = Task.find params[:id]
        @task.update(task_params)

        @team = Team.find params[:team_id]
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