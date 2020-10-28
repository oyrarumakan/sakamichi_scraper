require "sakamichi_scraper/base"

module SakamichiScraper
  class Hinatazaka < Base
    def get_blog_top_page_title
      html = get_blog_top_page
      Nokogiri::HTML.parse(html, nil, nil).title
    end

    def get_recent_blog_title
      html = get_blog_top_page
      scraped_title = Nokogiri.parse(html, nil, nil)
                        .at_css(".p-blog-main__head > .c-blog-main__title")
                        .content
      format_content(scraped_title)
    end

    private

    def get_blog_top_page
      init_url("hinatazaka", "blog_top_page")
    end
  end
end
