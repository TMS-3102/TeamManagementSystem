class CoursesController < ApplicationController

    def show
        @course = Course.find params[:id]
        @teams = @course.teams
    end

end
