require 'oga'
require 'open-uri'

module WebCrawler
  def self.crawl(uri)
    begin
      html = open(uri, open_timeout: 10, redirect: true).read
      return Oga.parse_html(html)
    rescue OpenURI::HTTPError => httpe
      return ""
    end
  end

  DOMAIN = "https://www.oantagonista.com".freeze

  def self.crawlAntaNewsList(page_number)
    self.crawl("#{DOMAIN}/pagina/#{page_number}")
  end

  def self.crawlAntaSingleNews(category, title)
    self.crawl("#{DOMAIN}/#{category}/#{title}")
  end
end


module FileCrawler
  def self.crawl(full_path)
    return Oga.parse_html(IO.read(full_path))
  end
end
