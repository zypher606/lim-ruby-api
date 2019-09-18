class ContentsController < ApplicationController
    before_action :set_webpage
    before_action :set_webpage_content, only: [:show, :update, :destroy]

    # GET /webpages/:webpage_id/contents
    def index
        json_response(@webpage.contents)
    end

    # GET /webpages/:webpage_id/contents/:id
    def show
        json_response(@content)
    end

    # POST /webpages/:webpage_id/contents
    def create
        @webpage.contents.create!(content_params)
        json_response(@webpage, :created)
    end

    # PUT /webpages/:webpage_id/contents/:id
    def update
        @content.update(content_params)
        head :no_content
    end

    # DELETE /webpages/:webpage_id/contents/:id
    def destroy
        @content.destroy
        head :no_content
    end

    private

    def content_params
        params.permit(:content_type, :content_value)
    end

    def set_webpage
        @webpage = Webpage.find(params[:webpage_id])
    end

    def set_webpage_content
        @content = @webpage.contents.find_by!(id: params[:id]) if @webpage
    end
end
