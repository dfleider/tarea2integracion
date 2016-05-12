class InstagramController < ApplicationController
skip_before_action :verify_authenticity_token

require 'rest-client'
require 'json'

  def inicio

  	tag = params[:tag].to_s
  	token = params[:access_token].to_s
  	#recibo el parametro del tag a buscar
  	busqueda = RestClient.get 'https://api.instagram.com/v1/tags/'+tag+'/media/recent?access_token='+token

  	busquedaTotal = RestClient.get 'https://api.instagram.com/v1/tags/'+tag+'?access_token='+token
  	#https://api.instagram.com/oauth/authorize/?client_id=5fe4edf794844d62b62b81bbb07d6f0a&redirect_uri=http://tarea-deployment.herokuapp.com/&response_type=token&scope=public_content
  	busquedaParseada = JSON.parse busqueda
  	total = JSON.parse busquedaTotal
  	
  	for i in 0..19 
  	puts busquedaParseada["data"][i]["tags"]
  	puts busquedaParseada["data"][i]["caption"]["from"]["username"]
  	puts busquedaParseada["data"][i]["likes"]["count"]
  	puts busquedaParseada["data"][i]["images"]["standard_resolution"]["url"]
  	puts busquedaParseada["data"][i]["caption"]["text"]
  	puts "------------------------------------------------------------------"

  end
    puts 'cantidadTag ='+total["data"]["media_count"].to_s
  end
end
