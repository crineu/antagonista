# frozen_string_literal: true
require 'sinatra'

require 'crawler'
require 'parser'

use Rack::Deflater

get '/:num?' do
  @page = params[:num].to_i

  if @page < 2
    @page = 1
    @next_page = @page + 1
  else
    @prev_page = @page - 1
    @next_page = @page + 1
  end

  @news_list = NewsListCleaner.clean(
    WebCrawler.crawlAntaNewsList(
      @page
    )
  )

  threads = []
  @news_list.each do |single_news|
    threads << Thread.new(single_news) do |news|
      news[:content] = SingleNewsCleaner.clean(
        WebCrawler.crawl(
          news[:full_path]
        )
      )
    end
  end
  threads.each { |t| t.join }

  erb :main
end
