require "sakamichi_scraper/base"

module SakamichiScraper
  class Sakurazaka < Base
    def get_blog_top_page_title
      html = get_blog_top_page
      Nokogiri::HTML.parse(html, nil, nil).title
    end

    def get_newest_blog_title
      html = get_blog_list_page
      Nokogiri.parse(html, nil, nil).at_css(".date-title > .title").children.to_s
    end

    def get_recent_blog_info
      res = []
      html = get_blog_list_page
      Nokogiri.parse(html, nil, nil).css(".com-blog-part.box4.fxpc > li").each do |c|
        info = {
          member: c.css(".prof-in.fx > .name").children.to_s,
          title:  c.css(".date-title > .title").children.to_s,
          timestamp: c.css(".date.wf-a").children.to_s
        }
        res << info
      end
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
