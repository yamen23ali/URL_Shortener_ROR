class MainController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def index
  	
  	# in this case it is a short url need to be redirect
  	if params.length>2
  	  url_key=""
  	  params.each{|key,value|
  		url_key = key 
  		break
  	  }

  	  result= Url.find_by key: url_key

      mlogger=Logger.new("#{Rails.root}/log/my.log")
      mlogger.info(result)

  	  if !result.nil?
  	  	redirect_to result.url 
  	  end
  	end

  end

  def generate
  	url=params[:url]
  	#generate random key
  	short_url=SecureRandom.hex(6)

  	# add url to DB
  	record=Url.new
  	record.key=short_url
  	record.url=url
  	record.save
  	
  	# return the shortened url to user
  	render :json => {:result=>short_url}
  end

end
