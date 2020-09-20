class PagesController < ApplicationController

    def home
        if current_user.present?
            redirect_to "/accounts/#{current_user.id}"
        else
            redirect_to new_user_session_path
        end
    end

end