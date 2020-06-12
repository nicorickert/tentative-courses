class LevelsController < ApplicationController
    def index
        @levels = Level.all
    end
    
    def new

    end

    def create
        @level = Level.new(post_params)

        @level.save
        redirect_to levels_path
    end

    private def post_params
        params.require(:post).permit(:name)
    end

end
