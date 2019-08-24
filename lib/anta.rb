# frozen_string_literal: true
require 'parser'
require 'crawler'

module Anta

  class ByPage
    attr_reader :page

    def initialize(page = 1)
      @page = page
      @page = 1 if @page < 2
    end

    def news_list
      news_list = Cleaner::NewsList.clean(
        Crawler::Web.crawlAntaNewsList(
          @page
        )
      )

      pool = []
      news_list.each do |single_news|
        pool << Thread.new(single_news) do |news|
          news[:content] = Cleaner::SingleNews.clean(
            Crawler::Web.crawl(
              news[:full_path]
            )
          )
        end
      end
      pool.each(&:join)

      news_list.reverse
    end
  end

end

