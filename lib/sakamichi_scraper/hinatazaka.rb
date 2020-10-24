require "sakamichi_scraper/base"

module SakamichiScraper
  class Hinatazaka < Base
    def get_blog_top_page_title
      html = init_url("hinatazaka", "blog_top_page")
      Nokogiri::HTML.parse(html, nil, nil).title
    end
  end
end
