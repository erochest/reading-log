module Jekyll
  class RdfaPage < Page
  end

  class RdfaGenerator < Generator
    priority :low
    safe true

    def generate(site)
      require 'rdf'
    end
  end
end
