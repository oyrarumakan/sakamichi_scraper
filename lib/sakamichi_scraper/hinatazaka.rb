require_relative "base"

module SakamichiScraper
  class Hinatazaka < Base
    def initialize
      super("hinatazaka")
    end

    def blog_top_page_title
      Nokogiri::HTML.parse(blog_top_page, nil, nil).title
    end

    def newest_blog_title
      scraped_title = Nokogiri.parse(blog_top_page, nil, nil)
                        .at_css(".p-blog-main__head > .c-blog-main__title")
                        .content
      format_content(scraped_title)
    end

    def recent_blog_info
      res = []
      Nokogiri.parse(blog_top_page, nil, nil).css(".p-blog-top__list > li").each do |c|
        info_arr = c.content.strip.split("\n").reject { |i| i.blank? }
        info = {
          member: info_arr[0],
          title: info_arr[1].lstrip,
          timestamp: format_timestamp(info_arr[2].lstrip)
        }
        res << info
      end
    end

    def picture_in_newest_article
      newest_article_url = article_urls_from_list_page(blog_top_page).first
      article_html = get_content(newest_article_url)
      image_urls = image_urls_from_article_url(article_html, "div.c-blog-article__text")

      mkdir_today_file_path unless Dir.exist?(image_file_path)
      download_images_from_url_list(image_urls)
    end

    private

    def article_urls_from_list_page(html)
      [].tap do |array|
        Nokogiri.parse(html, nil, nil).css(".p-blog-top__list > li").each do |c|
          array << "#{@home_page}#{c.css("a")[0][:href]}".match(/(.*)\?.*$/)[1]
        end
      end
    end

    def blog_top_page
      init_url_from_yml(@group_name, "blog_top_page")
    end
  end
end
