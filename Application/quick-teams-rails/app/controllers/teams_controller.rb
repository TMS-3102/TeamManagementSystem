class TeamsController < ApplicationController

    def index
        @teams = Team.all
    end

    def message_board
        @team = Team.find params[:id]
        @message_board = team.message_board
    end

end