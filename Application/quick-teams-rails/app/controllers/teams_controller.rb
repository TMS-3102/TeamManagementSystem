class TeamsController < ApplicationController

    def index
        @teams = Team.all
    end

    def message_board
        @team = Team.find params[:id]
        @message_board = @team.message_board

        @message = Message.new
    end

    def create_message
        @message = Message.new

        @message.title = params[:message][:title]
        @message.content = params[:message][:content]
        @message.priority = params[:message][:priority]

        team = Team.find(params[:id])
        team.message_board.messages << @message 

        if @message.save
            flash[:success] = "New message created."
        else
            flash[:danger] = "Error: Message creation failed."
        end
        redirect_to "/teams/#{params[:id]}/message_board"
    end

    def student_requests
        team = Team.find params[:id]
        @requests = team.requests

        if(current_user.id != team.liaison_id && current_user.is_student)
            flash[:danger] = "Your account is not authorized to visit that page."
            redirect_to "/accounts/#{current_user.id}"
        end

    end

    def approve_or_reject_join_team
        student = User.find(params[:student_id])
        request = Request.find(params[:request_id])

        if params[:status] == "true"
            team = Team.find(params[:id])
            if team.users.length >= team.maximum_capacity
                flash[:warning] = "Team already full."
                redirect_to "/teams/#{params[:id]}/student_requests" and return
            else
                team.users << student
                team.status = true if team.users.length == team.maximum_capacity
                team.save
                flash[:success] = "Request successfully approved."
            end
        else
            flash[:danger] = "Request successfully rejected."
        end
        request.destroy
        redirect_to "/teams/#{params[:id]}/student_requests"
    end
    
    def new
        @team = Team.new

        if current_user.is_student?
            flash[:warning] = "Your user account type is not authorized to create new teams."
            redirect_to "/accounts/#{current_user.id}"
        end
    end

    def create
        @team = Team.new(team_params)
        @team.status = false
    
        mb = MessageBoard.new(number_stored: params[:number_stored])
        @team.message_board = mb

        if params[:team][:course_id].present?
            course = Course.find(params[:team][:course_id])
            course.teams << @team
        end
        
        if @team.save
            flash[:success] = "New team created."
            redirect_to "/accounts/#{current_user.id}"
        else
            render 'new'
            flash[:danger] = "Error: Team creation failed."
        end    
    end

    # def edit
    # end

    # def update
    # end

    # def destroy
    # end

    private
    def team_params
        params.require(:team).permit(:name, :liaison_id, :maximum_capacity, :minimum_capacity, :deadline, :course_id)
    end    

end