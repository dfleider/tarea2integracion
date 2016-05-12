class InstagramController < ApplicationController
skip_before_action :verify_authenticity_token

require 'rest-client'
require 'json'

  def inicio

  	unless params[:tag] and params[:access_token]
	head 400
		return
		end

  	tag = params[:tag].to_s
  	token = params[:access_token].to_s
  	#verifico que el access token sea valido (falta)
  	#unless RestClient.get 'https://api.instagram.com/v1/tags/'+tag+'/media/recent?access_token='+token
  	#	head 400
  	#	return
  	#end
  	busqueda = RestClient.get 'https://api.instagram.com/v1/tags/'+tag+'/media/recent?access_token='+token
  	busquedaTotal = RestClient.get 'https://api.instagram.com/v1/tags/'+tag+'?access_token='+token
  	#https://api.instagram.com/oauth/authorize/?client_id=5fe4edf794844d62b62b81bbb07d6f0a&redirect_uri=http://tarea-deployment.herokuapp.com/&response_type=token&scope=public_content
  	busquedaParseada = JSON.parse busqueda
  	total = JSON.parse busquedaTotal
  	
  	#genero los arreglos en los que guardo las distintas informaciones
  	tags = Array.new
  	usuarios = Array.new
  	likes = Array.new
  	url = Array.new
  	caption = Array.new

  	for i in 0..19 
  	puts busquedaParseada["data"][i]["tags"]
  	tags.push(busquedaParseada["data"][i]["tags"])

  	puts busquedaParseada["data"][i]["caption"]["from"]["username"]
  	usuarios.push(busquedaParseada["data"][i]["caption"]["from"]["username"])

  	puts busquedaParseada["data"][i]["likes"]["count"]
  	likes.push(busquedaParseada["data"][i]["likes"]["count"])

  	puts busquedaParseada["data"][i]["images"]["standard_resolution"]["url"]
  	url.push(busquedaParseada["data"][i]["images"]["standard_resolution"]["url"])

  	puts busquedaParseada["data"][i]["caption"]["text"]
  	caption.push(busquedaParseada["data"][i]["caption"]["text"])

  	puts "------------------------------------------------------------------"

  end
    puts 'cantidadTag ='+total["data"]["media_count"].to_s

    #ahora debemos cargar todo a un JSON a retornar
    metadata = ({:total => total["data"]["media_count"].to_i})

    posts = Array.new
    for i in 0..19


    post = ({:tags => tags[i], :username => usuarios[i], :likes => likes[i],
    	:url => url[i], :caption => caption[i]})

    posts.push(post)
	end

	version = '2.0.1'

	render json: {metadata: metadata, posts: posts, version: version}

  end
end
