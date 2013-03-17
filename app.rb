# coding: utf-8
require 'sinatra'
require 'haml'
require 'cairo'
require 'pango'

configure :development do
  require 'pry'
  require 'sinatra/reloader'
end

configure do
  set :font_families, Pango::CairoFontMap.default.families.collect {|family|
    name = family.name
    name.force_encoding("UTF-8") if name.respond_to?(:force_encoding)
    name
  }
  set :default_font, lambda {
    font_families.find do |name|
      ["Osaka", "MS PGothic", "VL PGothic", "Monospace"].include? name
    end or font_families.find {|n| n =~ /gothic/i }
  }
end

get '/' do
  @title = 'Do it now!'
  haml :index
end


get '/doitnow' do
  # binding.pry

  @title = 'Do it now!'
  haml :doitnow

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
  layout = context.create_pango_layout
  layout.text = params[:url]
  layout.font_description = begin
                              font_description = Pango::FontDescription.new
                              font_description.family = get_font_name
                              font_description.size = 25 * Pango::SCALE
                              font_description
                            end
  context.move_to(10, 50)
  context.show_pango_layout(layout)

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

  def get_font_name
    params[:font].to_s.empty? ? settings.default_font : params[:font]
  end
end
