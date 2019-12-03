class CoursesController < ApplicationController

    def index
        if current_user.is_student?
            flash[:warning] = "Your user account type is not authorized to view all courses."
            redirect_to "/accounts/#{current_user.id}" and return
        end

        # @courses = Course.where(instructor_id: current_user.id)
        @courses = Course.all
    end

    def add_students
        user = User.find(params[:student_id])
        course = Course.find(params[:id])

        if course.users.where(id: user.id).empty?
            course.users << user
            flash[:success] = "#{user.name} has been registered to #{course.code}"
        else
            if user.is_student
                flash[:danger] = "This student is already registered to #{course.code}"
            else
                flash[:danger] = "This instructor is already registered to #{course.code}"
            end
        end    
        redirect_to '/courses'
    end

    def show 
        @course = Course.find params[:id]
        @request = Request.new

        @student_on_team = false
        @course.teams do |team|
            team.users do |member|
                if member.id == current_user.id
                    @student_on_team = true
                end
            end
        end
    end

    def new
        @course = Course.new

        if current_user.is_student?
            flash[:warning] = "Your user account type is not authorized to create new courses."
            redirect_to "/courses/"
        end
    end

    def create
        @course = Course.new(course_params)
        @course.instructor_id = current_user.id

        current_user.courses << @course

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
            flash[:danger] = "There is already an active request for this user to this team."
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
