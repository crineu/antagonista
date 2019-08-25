# frozen_string_literal: true
require 'parser'
require 'crawler'

module Anta

  # Complete news of a single page
  class ByPage
    attr_reader :page

    def initialize(page = 1)
      @page = page
      @page = 1 if @page < 2
    end

    def list
      📰 = Cleaner::NewsList.clean(
        Crawler::Web.crawlAntaNewsList(
          @page
        )
      )

      pool = []
      📰.each do |single_news|
        pool << Thread.new(single_news) do |news|
          news[:content] = Cleaner::SingleNews.clean(
            Crawler::Web.crawl(
              news[:full_path]
            )
          )
        end
      end
      pool.each(&:join)

      📰.reverse
    end
  end


  # Just the headlines of many pages
  class Headlines
    attr_reader :first, :pages

    def initialize(first: 1, pages: 10)
      @first = first
      @pages = pages
    end

    def list
      📰 = []
      🏃 = []
      (@first...(@first + @pages)).each do |single_page|
        🏃 << Thread.new(single_page) do |page|

        📰 << Cleaner::NewsList.clean(
          Crawler::Web.crawlAntaNewsList(
            page
          )
        )

        end
      end
      🏃.each(&:join)
      📰.flatten.sort { |a,b| b[:date] <=> a[:date] }
    end
  end

end

