# -*- coding: utf-8 -*-
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def cu?
    !!current_user
  end

  def show_tags(o)
    o.tags.inject("<span class='tagcloud'>") do |str, tag|
      str += "<a href='/#{tag.name}'>#{tag.name}</a> "
    end + "</span>"
  end

  def tag_cloud(tags = Tag.all)
    return "No tags" if tags.empty?
    counts = tags.map(&:count)
    max, min = counts.max, counts.min
    divisor = ((max - min) / 6) + 1

    tags.inject("<div class='cloud'>") do |str, tag|
      str += "<a href='/#{tag.name}' class='cloud#{(tag.count - min) / divisor}'>#{tag.name}</a> "
    end + "</div>"
  end

  def puts_pub(pub, avatar=false, latest=false)
    out = ""
    if avatar
      out << "<span class='thumb'>#{image_tag pub.user.avatar.url(:thumb)}</span><span class='pub_body'>"
    else
      out << "<span>"
    end
    out << "<span class='#{latest ? 'pub_highlight' : 'pub_body_text'}'>"
    out << "<a href=/#{pub.user.login}>#{pub.user.login}</a>" #if avatar
    out << " #{pub.parsed_text} </span>"
    out << "<span class='pub_info'>"
    # out << "On #{link_to pub.project.name, pub.project} " if pub.project
    out << "(#{pub.created_at})</span></span>"
    out << "<ul class='actions-hover'><li><span class='del'><span class='delete-icon icon'>
           <a  href='/' ></a> </span> </span></li></ul>"
  end

  def display_flashes
    flashes = ''
    unless flash.size == 0
      flash.each_pair  do |key, value|
        flashes += content_tag(:div, content_tag(:div, value, :class => 'message '+key.to_s), :class => 'flash')
      end
    end
    flashes
  end

  def sidebar(&block)
    content_for :sidebar do
      concat "<div class='block'><h3>Menu</h3><ul class='navigation'>"
      yield
      concat '</ul></div>'
    end
  end

  def yn(bool)
    bool ? "Sim" : "Não"
  end

  def link_or_nil(obj, *args)
    opts = { :link_text => obj, :url => obj, :text => '-' }.update( args.extract_options! )
    if obj
      link_to((opts[:link_text_method] ? obj.send(opts[:link_text_method]) : opts[:link_text]), opts[:url])
    else
      opts[:text]
    end
  end

  def back_link(txt = "Voltar")
    link_to txt, { :controller => controller.controller_name, :action => :index } , :class => 'icon back'
  end

  def edit_link(id=nil, txt = "Editar")
    if id
      id = id.id unless id.is_a? Integer
      link_to txt, { :controller => controller.controller_name, :action => :edit, :id => id }, :class => 'icon edit'
    else
      link_to txt, { :controller => controller.controller_name, :action => :edit }, :class => 'icon edit'
    end
  end

  def destroy_link(id = nil, txt = "Excluir")
    if id
      id = id.id unless id.is_a? Integer
      link_to txt, { :controller => controller.controller_name, :action => :destroy, :id => id }, :class => 'icon destroy', :method => :delete, :confirm => "Really delete?"
    else
      link_to txt, { :controller => controller.controller_name, :action => :destroy }, :class => 'icon destroy', :method => :delete, :confirm => "Really delete?"
    end
  end

  def save_or_cancel(f)
    out = "<div class='clear'></div><div class='navform'>"
    link = url_for(:controller => controller.controller_name, :action => :index) rescue "/"
    out += link_to "back", link
    out += " or "
    out += f.submit "Save", :class => "button"
    out += "</div>"
  end

  def count_as_text(num, one, more, zero = nil)

    out = case num
    when 0; zero || one;
    when 1; one;
    else more;
    end
    out % num
  end

  def mark_search(name, *opts)
    opts = { :search => params[:search] }.update(opts.extract_options!)
    name = h(name)
    return name if not opts[:search].is_a?(String) or opts[:search].size <= 0
    name.gsub(/(#{opts[:search]})/i, '<strong class="mark_search">\1</strong>')
  end


  def show_for(what, fields=nil)
    #raise ArgumentError, "Missing block" unless block_given?
    if fields
      fields.inject("") do |out, field|
        out << "<p><b>#{I18n.t('activerecord.attributes.' + what.class.to_s.downcase + "." + field.to_s, :default => field.to_s.capitalize)}:</b> #{what.send(field)}</p>"
      end
    else
      "<p><b>#{what}</b></p>"
    end
    #concat  yield self
    #"#{what} #{block.call what}" #"#{what.class}: #{yield what}" #"dd" #what.to_s #
    #out << block #{ |w| w ? "<b>#{I18n.t(what)}:</b>#{what}-#{w}" : nil}.call(what)
   # out
  end

  def link_to_map(obj, label=false)
    link_to label ? "Ver no mapa" :  "", "/map##{obj.class.table_name}/#{obj.id}", :class => "icon map"
  end

  def date_or_text(date, *args)
    opts = { :text => 'Sem data' }.update( args.extract_options! )
    if date
      l(date, :format => opts[:format])
    else
      opts[:text]
    end
  end

  def show_links
      [
        back_link,
        edit_link,
        destroy_link
      ].join(' | ')
  end


  def puts_coord(coord)
    "x: %f.3 y:"
  end

  def percentage(t, f)
    total = (t+f > 0) ? f*100/(t+f) : 0
    "#{total}%"
  end


  def total_percentage(t, f)
    (f * 100 / t).to_i.to_s + "%"
  end


end
