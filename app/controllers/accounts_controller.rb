class AccountsController < ApplicationController

    def show
        @user=User.find(params[:id])
    end

    def course
        @course=Course.new
        course.name=params[:coursename]
        course.code=params[:coursecode]
        course.save
    end
end
