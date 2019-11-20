class TeamsController < ApplicationController

    def index
        @teams = Team.all
    end

    def message_board
        @team = Team.find params[:id]
    end

end
