module Jekyll
  class RdfaPage < Page
  end

  class RdfaGenerator < Generator
    priority :low
    safe true

    def generate(site)
      require 'fileutils'
      require 'json'
      require 'json/ld'
      require 'rdf'
      require 'rdf/turtle'
      require 'rdf/rdfa'

      converter = site.getConverterImpl(Jekyll::Converters::Markdown)

      graph = RDF::Graph.new
      site.posts.each do |post|
        html = converter.convert(post.content)
        if post.data.member? "vocab"
          html = "<div vocab='#{post.data["vocab"]}'>#{html}</div>"
        end
        graph.from_rdfa html
      end

      dirname = "_linked-data"
      FileUtils.mkpath(dirname) unless File.exists?(dirname)

      File.open("#{dirname}/posts.ttl", 'w') do |file|
        file.write(graph.to_ttl)
      end
      site.static_files << Jekyll::StaticFile.new(
        site, "_linked-data", "", "posts.ttl"
      )
      File.open("#{dirname}/posts.json", 'w') do |file|
        file.write(graph.dump(:jsonld, standard_prefixes: true))
      end
      site.static_files << Jekyll::StaticFile.new(
        site, "_linked-data", "", "posts.json"
      )
    end
  end
end
