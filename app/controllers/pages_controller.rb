class PagesController < ApplicationController
    # Displays static page created
    def show
        render template: "pages/#{params[:page]}"
    end
end