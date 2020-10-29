require "sakamichi_scraper/base"

module SakamichiScraper
  class Sakurazaka < Base
    def get_blog_top_page_title
      html = get_blog_top_page
      Nokogiri::HTML.parse(html, nil, nil).title
    end

    def get_newest_blog_title
      html = get_blog_list_page
      Nokogiri.parse(html, nil, nil).css(".inner.title-wrap > .title").first.children.to_s
    end

    private

    def get_blog_top_page
      init_url("sakurazaka", "blog_top_page")
    end

    def get_blog_list_page
      init_url("sakurazaka", "blog_list_page")
    end
  end
end
