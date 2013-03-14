class UploadController < ApplicationController
  
  require 'youtube_it'
  require 'rest_client'
  require "erb"
  include ERB::Util
  
  def initialize
    #@client = YouTubeIt::Client.new(:dev_key => "AI39si7aAybCcNVsQ-K6lB0R_mY9eIVKxwrA6ujGMKcYkyZUQb9VnQ6hAxLJznidQXgdsI8jklAsBqElYhpv9CvkLwT46tfnyg")
    @client = YouTubeIt::Client.new(:username => "kevin78515", :password =>  "", :dev_key => "AI39si7aAybCcNVsQ-K6lB0R_mY9eIVKxwrA6ujGMKcYkyZUQb9VnQ6hAxLJznidQXgdsI8jklAsBqElYhpv9CvkLwT46tfnyg")
  end
  
  def index
    
  end
  
  def login 
    
  end
  
  def upload 
    params = {  :title => "title", 
                :description => "description", 
                :category => "People", 
                :keywords => ["test"]
             }
    @upload_info = @client.upload_token(params, "http://127.0.0.1:3000/upload/index")
  end
  
  def oauth2callback
    
    require 'rubygems'
    require 'faraday'
    
    conn = Faraday.new(:url => 'https://accounts.google.com',:ssl => {:verify => false}) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
    
    result = conn.post  '/o/oauth2/token', 
                        { 'code' => Rack::Utils.escape(params['code']),
                          'client_id' => "676069575889.apps.googleusercontent.com",
                          'client_secret' => "Xd7h74h8f5V2XeqjMAhbEi1u",
                          'redirect_uri' => Rack::Utils.escape("http://localhost:3000/upload/oauth2callback"),
                          'grant_type' => 'authorization_code'
                        }
    
    puts result.body.inspect
    
    client = YouTubeIt::OAuth2Client.new( :client_access_token => "access_token",
                                          :client_refresh_token => "refresh_token", 
                                          :client_id => "client_id", 
                                          :client_secret => "client_secret", 
                                          :dev_key => "dev_key", 
                                          :expires_at => "expiration time")
    
    # puts  'https://accounts.google.com/o/oauth2/token?'+
          # 'code='+Rack::Utils.escape(params['code'])+
          # '&client_id=676069575889.apps.googleusercontent.com'+
          # '&client_secret=omQ28jfzJe_aziZU7p4UNctm'+
          # '&redirect_uri='+Rack::Utils.escape('http://localhost:3000/oauth2callback')+
          # '&grant_type=authorization_code',
          # :content_type => 'application/x-www-form-urlencoded'
    # response = RestClient.post  'https://accounts.google.com/o/oauth2/token?'+
                                # 'code='+Rack::Utils.escape(params['code'])+
                                # '&client_id=676069575889.apps.googleusercontent.com'+
                                # '&client_secret=omQ28jfzJe_aziZU7p4UNctm'+
                                # '&redirect_uri='+Rack::Utils.escape('http://localhost:3000/upload/oauth2callback')+
                                # '&grant_type=authorization_code',
                                # :content_type => 'application/x-www-form-urlencoded'
#     
    # puts '====================='
    # puts response[:access_token]
    # puts '====================='
    
    render :json => result
    
  end
end
