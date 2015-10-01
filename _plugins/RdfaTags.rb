module Jekyll
  # https://github.com/Shopify/liquid/wiki/Liquid-for-Programmers
  # https://github.com/jekyll/jekyll/issues/1380
  class RdfaVocabBlock < Liquid::Block
    def initialize(tag_name, markup, tokens)
      @url = markup
      super
    end

    def render(context)
      body = super
      site = context.registers[:site]
      converter = site.getConverterImpl(Jekyll::Converters::Markdown)
      body = converter.convert(super(context))
      "<div vocab=\"#{@url}\">\n\n#{body}\n\n</div>"
    end
  end
end

Liquid::Template.register_tag('vocab', Jekyll::RdfaVocabBlock)
