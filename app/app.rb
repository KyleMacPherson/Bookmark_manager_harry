require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  get '/' do
    erb :homepage
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])

    tags = params[:tags].split(" ")
    p tags
    tags.each do |t|
      tag = Tag.create(name: t)
      link.tags << tag
      link.save
    end
    redirect '/links'
  end

  get '/links/new' do
    erb :'links/new'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

run! if app_file == BookmarkManager

end
