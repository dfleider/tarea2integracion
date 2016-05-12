class InstagramController < ApplicationController
skip_before_action :verify_authenticity_token

require 'rest-client'
require 'json'

  def inicio

  	tag = params[:tag].to_s
  	#recibo el parametro del tag a buscar
  	busqueda = RestClient.get 'https://api.instagram.com/v1/tags/'+tag+'/media/recent?access_token=3230931781.5fe4edf.ca4155e5c64647dfbfacc7d9ef64bd35'
  	#https://api.instagram.com/oauth/authorize/?client_id=5fe4edf794844d62b62b81bbb07d6f0a&redirect_uri=http://tarea-deployment.herokuapp.com/&response_type=token&scope=public_content
  	busquedaParseada = JSON.parse busqueda
  	puts busquedaParseada["data"][0]["likes"]["count"]
  	puts busquedaParseada["data"][1]["likes"]
  	puts busquedaParseada["data"][2]["caption"]["from"]["username"]
  	puts busquedaParseada["data"][3]["caption"]["from"]["username"]
  end
end
