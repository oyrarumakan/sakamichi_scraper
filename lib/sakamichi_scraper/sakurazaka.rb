require "sakamichi_scraper/base"

module SakamichiScraper
  class Sakurazaka < Base
    def get_blog_top_page_title
      html = get_blog_top_page
      Nokogiri::HTML.parse(html, nil, nil).title
    end

    private

    def get_blog_top_page
      init_url("sakurazaka", "blog_top_page")
    end
  end
end