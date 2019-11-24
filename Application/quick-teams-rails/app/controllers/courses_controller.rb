class CoursesController < ApplicationController

    def show 
        @course = Course.find params[:id]

        @request = Request.new
    end

    def new
        @course = Course.new

        if current_user.is_student?
            flash[:warning] = "Your user account type is not authorized to create new courses."
            redirect_to "/accounts/#{current_user.id}"
        end
    end

    def create
        @course = Course.new(course_params)

        if @course.save
            flash[:success] = "New course created."
            redirect_to "/accounts/#{current_user.id}"
        else
            render 'new'
            flash[:danger] = "Error: Course creation failed."
        end
    end

    def request_join_team
        team = Team.find(params[:team_id])
        request = team.requests.find_by(student_id: current_user)
        if request.present?
            flash[:danger] = "There is already an active request for this user."
            redirect_to "/courses/#{params[:id]}" and return
        end

        request = Request.new(student_id: current_user.id)
        team.requests << request

        if request.save
            flash[:success] = "New request created."
        else
            flash[:danger] = "Error: Request creation failed."
        end
        redirect_to "/courses/#{params[:id]}"
    end

    private

        def course_params
            params.require(:course).permit(:name, :code)
        end

end
