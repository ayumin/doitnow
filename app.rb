# coding: utf-8
require 'sinatra'
require 'haml'
require 'cairo'
require 'tempfile'

configure :development do
  require 'pry'
  require 'sinatra/reloader'
end

get '/' do
  @title = 'Do it now!'
  haml :index
end


get '/doitnow' do
  # binding.pry

  @title = 'Do it now!'

  w = 420
  h = 360

  surface = Cairo::ImageSurface.new(w, h)
  context = Cairo::Context.new(surface)

  context.set_source_rgb(0, 0, 0)
  context.rectangle(0, 0, w, h)
  context.fill
  #Put a Mr.hayashi's face
  surface2 = Cairo::ImageSurface.from_png('views/0.png')
  context.set_source(surface2, 0, 0)
  context.paint
  #Put a string
  context.set_source_rgb(25, 255, 255)
  context.font_size = 25
  context.move_to(10, 50)
  context.show_text(params[:url])

  #Drawing background-color(Black)
  tmpfile = Tempfile.new(["hayashi", ".png"])
  surface.write_to_png(tmpfile.path)
  tmpfile.open # reopen

  #Render png binary content
  content_type :png
  tmpfile.read
end


helpers do
  def add_schema(url)
    if url !~ /^https?/
      if url =~ /\/\//
        "http:#{url}"
      else
        "http://#{url}"
      end
    else
      url
    end
  end
end
