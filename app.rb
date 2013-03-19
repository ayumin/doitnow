# encoding: utf-8

require 'sinatra/reloader'
  if development?
end



get '/' do
  @title = 'Do it now!'
  haml :index
end


get '/doitnow' do
  @title = 'Do it now!'
  haml :doitnow

  w = 420
  h = 400


  surface = Cairo::ImageSurface.new(w, h)
  context = Cairo::Context.new(surface)

  context.set_source_rgb(0, 0, 0)
  context.rectangle(0, 200, w, h)
  context.fill
  #Put a Mr.hayashi's face
  surface2 = Cairo::ImageSurface.from_png('views/0.png')
  context.select_font_face("meiryob.ttc")
  context.set_source(surface2, 0, 0)
  context.paint
  #Put a string
  context.set_source_rgb(25, 255, 255)
  context.font_size = 25
  context.move_to(20, 380)
  context.show_text('「'+params[:url]+'」')
  #Drawing background-color(Black)
  surface.write_to_png('views/paint.png')
  #Sent to doitnow.haml 
  content_type :png
  send_file "views/paint.png"
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
