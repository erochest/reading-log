module Jekyll
  class RdfaVocabBlock < Liquid::Block
    def initialize(tag_name, markup, tokens)
      @url = markup
      super
    end

    def render(context)
      site = context.registers[:site]
      converter = site.getConverterImpl(Jekyll::Converters::Markdown)
      body = converter.convert(super(context))
      "<div vocab=\"#{@url}\">\n\n#{body}\n\n</div>"
    end
  end

  class RdfaResourceSpan < Liquid::Block
    def initialize(tag_name, markup, tokens)
      params = markup.split ' '
      @url = params.shift
      @typeof = params.shift || nil
      super
    end

    def render(context)
      body = super

      span = "<span resource=\"#{@url}\""
      span << " typeof=\"#{@typeof}\"" unless @typeof.nil?
      span << ">#{body}</span>"

      span
    end
  end
end

Liquid::Template.register_tag('vocab', Jekyll::RdfaVocabBlock)
Liquid::Template.register_tag('rsc_span', Jekyll::RdfaResourceSpan)
