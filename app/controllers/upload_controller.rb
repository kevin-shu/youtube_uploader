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
    puts  'https://accounts.google.com/o/oauth2/token?'+
          'code='+Rack::Utils.escape(params['code'])+
          '&client_id=676069575889.apps.googleusercontent.com'+
          '&client_secret=omQ28jfzJe_aziZU7p4UNctm'+
          '&redirect_uri='+Rack::Utils.escape('http://localhost:3000/oauth2callback')+
          '&grant_type=authorization_code',
          :content_type => 'application/x-www-form-urlencoded'
    response = RestClient.post  'https://accounts.google.com/o/oauth2/token?'+
                                'code='+Rack::Utils.escape(params['code'])+
                                '&client_id=676069575889.apps.googleusercontent.com'+
                                '&client_secret=omQ28jfzJe_aziZU7p4UNctm'+
                                '&redirect_uri='+Rack::Utils.escape('http://localhost:3000/upload/oauth2callback')+
                                '&grant_type=authorization_code',
                                :content_type => 'application/x-www-form-urlencoded'
    
    puts '====================='
    puts response[:access_token]
    puts '====================='
    
    render :json => response.to_json
    
  end
end
