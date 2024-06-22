require 'securerandom'
require 'open-uri'
require 'nokogiri'

class UrlsController < ApplicationController

    def create
        @url = Url.new(url_params)

        if @url.validate(:target_url)
            @url.target_url = @url.target_url.gsub(/[[:space:]]/, '') 
            @url.short_url = get_short_url
            
            title_tag = get_title_tag(@url.target_url)
            if title_tag.present?
                @url.title_tag = title_tag
            end

            @url.save
            redirect_to url_path(@url.short_url)
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def new
        @url = Url.new
    end

    def show
        @url = Url.find_by(short_url: params[:short_url])
    end     

    def statistic
        @url = Url.find_by(short_url: params[:short_url])
    end
    
    def redirect
            @url = Url.find_by(short_url: params[:short_url])
            @url.increment(:clicks).save
            @url.visits.create(originating_geolocation: get_originating_geolocation)
            redirect_to @url.target_url, allow_other_host: true
    end

    private      
        def get_short_url()
            short_url = SecureRandom.hex(3)[0, 15]

            # Check if the short code is already taken
            while Url.find_by(short_url: short_url).present?
              short_url = SecureRandom.hex(3)[0, 15]
            end

            return short_url
        end

        def get_title_tag(target_url)
            begin
                html = URI.open(target_url)
                doc = Nokogiri::HTML(html)
                title_node_set = doc.css('title')
                return title_node_set.empty? ? nil : title_node_set.text
            rescue
                return nil
            end
        end

        def get_originating_geolocation
            ip_address = request.remote_ip == "127.0.0.1" ? "202.186.194.184" : request.remote_ip
            results = Geocoder.search(ip_address).first
            return "#{results.city}, #{results.country}"
        end   

        def url_params
            params.require(:url).permit(:target_url, :short_url)
        end

end
