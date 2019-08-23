# frozen_string_literal: true
require 'oga'
require 'open-uri'

module Crawler

  module Web
    def self.crawl(uri)
      html = open(uri, open_timeout: 10, redirect: true).read
      Oga.parse_html(html)
    rescue OpenURI::HTTPError
      ''
    end

    DOMAIN = 'https://www.oantagonista.com'.freeze

    def self.crawlAntaNewsList(page_number)
      crawl("#{DOMAIN}/pagina/#{page_number}")
    end
  end


  module File
    def self.crawl(full_path)
      Oga.parse_html(IO.read(full_path))
    end
  end

end
