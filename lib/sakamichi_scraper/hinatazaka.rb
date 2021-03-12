require "sakamichi_scraper/base"

module SakamichiScraper
  class Hinatazaka < Base
    def initialize
      @group_name = "hinatazaka"
      @home_page = "https://#{@group_name}46.com"
    end

    def get_blog_top_page_title
      html = get_blog_top_page
      Nokogiri::HTML.parse(html, nil, nil).title
    end

    def get_newest_blog_title
      html = get_blog_top_page
      scraped_title = Nokogiri.parse(html, nil, nil)
                        .at_css(".p-blog-main__head > .c-blog-main__title")
                        .content
      format_content(scraped_title)
    end

    def get_recent_blog_info
      res = []
      html = get_blog_top_page
      Nokogiri.parse(html, nil, nil).css(".p-blog-top__list > li").each do |c|
        info_arr = c.content.strip.split("\n").reject { |i| i.blank? }
        info = {
          member: info_arr[0],
          title: info_arr[1].lstrip,
          timestamp: format_timestamp(info_arr[2].lstrip)
        }
        res << info
      end
    end

    def get_picture_in_newest_article
      html = get_blog_top_page
      newest_article_url = article_urls_from_list_page(html).first
      article_html = get_content(newest_article_url)
      image_urls = image_urls_from_article_url(article_html)

      mkdir_today_file_path unless Dir.exist?("img/#{exec_date}")
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

    def image_urls_from_article_url(article_html)
      [].tap do |url|
        Nokogiri::HTML.parse(article_html, nil, nil).css("div.c-blog-article__text img").each do |c|
          url << c.attribute("src").value
        end
      end
    end

    def download_images_from_url_list(image_urls)
      image_urls.each do |image_url|
        dest_image_path = "img/#{exec_date}/#{image_url[%r([^/]+$)]}"
        File.open(dest_image_path, "w") do |pass|
          URI.parse(image_url).open do |img|
            pass.write(img.read)
          end
        end
      end
    end

    def get_blog_top_page
      init_url(@group_name, "blog_top_page")
    end
  end
end
