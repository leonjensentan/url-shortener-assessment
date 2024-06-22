require 'securerandom'
require 'open-uri'
require 'nokogiri'

class UrlsController < ApplicationController
  #Action to create a new URL record
  def create
    @url = Url.new(url_params)

    #Validate the presence of the target URL
    if @url.validate(:target_url)
      @url.target_url = @url.target_url.gsub(/[[:space:]]/, '') #Remove any whitespace from the target URL
      @url.short_url = get_short_url #Generate a unique short URL

      #Fetch the title tag of the target URL if present
      title_tag = get_title_tag(@url.target_url)
      @url.title_tag = title_tag if title_tag.present?

      #Save the URL record and redirect to the show page
      @url.save
      redirect_to url_path(@url.short_url)
    else
      #Render the new form with errors if validation fails
      render 'new', status: :unprocessable_entity
    end
  end

  #Action to display the new URL form
  def new
    @url = Url.new
  end

  #Action to display a shortened URL's details
  def show
    @url = Url.find_by(short_url: params[:short_url])
  end

  #Action to display usage statistics for a shortened URL
  def statistic
    @url = Url.find_by(short_url: params[:short_url])
  end

  #Action to handle redirection from the short URL to the target URL
  def redirect
    @url = Url.find_by(short_url: params[:short_url])
    @url.increment(:clicks).save # Increment the click count
    @url.visits.create(originating_geolocation: get_originating_geolocation) # Record the visit with geolocation
    redirect_to @url.target_url, allow_other_host: true
  end

  private

  #Helper method to generate a unique short URL
  def get_short_url
    short_url = SecureRandom.hex(3)[0, 15]

    #Ensure the generated short URL is unique
    while Url.find_by(short_url: short_url).present?
      short_url = SecureRandom.hex(3)[0, 15]
    end

    short_url
  end

  #Helper method to fetch the title tag of a target URL
  def get_title_tag(target_url)
    begin
      html = URI.open(target_url)
      doc = Nokogiri::HTML(html)
      title_node_set = doc.css('title')
      title_node_set.empty? ? nil : title_node_set.text
    rescue
      nil
    end
  end

  #Helper method to get the originating geolocation of the request
  def get_originating_geolocation
    ip_address = request.remote_ip == "127.0.0.1" ? "202.186.194.184" : request.remote_ip
    results = Geocoder.search(ip_address).first
    "#{results.city}, #{results.country}"
  end

  #Safely collect data from the form
  def url_params
    params.require(:url).permit(:target_url, :short_url)
  end
end