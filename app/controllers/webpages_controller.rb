require 'nokogiri'
require 'open-uri'

class WebpagesController < ApplicationController
    before_action :set_webpage, only: [:show, :update, :destroy]

    # GET /webpages
    def index
        @webpages = Webpage.all
        json_response(@webpages)
    end

    # POST /webpages
    def create
        print "*********************************"
        print webpage_params
        url = webpage_params['url']
        document = Nokogiri::HTML.parse(open(url))
        print "*********************************\n"
        tags = document.xpath("//a")
        links = tags.map { |t| t[:href] }

        tag_h1 = document.xpath("//h1")
        h1 = tag_h1.map { |t| t.text }

        tag_h2 = document.xpath("//h2")
        h2 = tag_h2.map { |t| t.text }

        tag_h3 = document.xpath("//h3")
        h3 = tag_h3.map { |t| t.text }
   
        print h3
        print "\n*********************************"
        

        @webpage = Webpage.create!(webpage_params)

        
        content_params = {"content_type" => "", "content_value" => ""}
        h1.each { |x| @webpage.contents.create!({"content_type" => "h1", "content_value" => x}) }
        h2.each { |x| @webpage.contents.create!({"content_type" => "h2", "content_value" => x}) }
        h3.each { |x| @webpage.contents.create!({"content_type" => "h3", "content_value" => x}) }
        links.each { |x| @webpage.contents.create!({"content_type" => "links", "content_value" => x}) }

        json_response({'domain_details': @webpage, 'data': { 'h1': h1, 'h2': h2, 'h3': h3, 'links': links }})
    end

    # GET /webpages/:id
    def show
        json_response(@webpage)
    end

    # PUT /webpages/:id
    def update
        @webpage.update(webpage_params)
        head :no_content
    end

    # DELETE /webpages/:id
    def destroy
        @webpage.destroy
        head :no_content
    end

    private

    def webpage_params
        # whitelist params
        params.permit(:url)
    end

    def set_webpage
        @webpage = Webpage.find(params[:id])
    end
end
