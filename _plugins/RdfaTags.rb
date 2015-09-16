module Jekyll
  class RdfaTypeOfTag < Liquid::Tag
    def render(context)
    end
  end
end

Liquid::Template.register_tag('typeof', Jekyll::RdfaTypeOfTag)
