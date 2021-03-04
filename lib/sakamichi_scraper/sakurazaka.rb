require "sakamichi_scraper/base"
require "open-uri"

module SakamichiScraper
  class Sakurazaka < Base
    HOME_PAGE = "https://sakurazaka46.com".freeze

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

    def get_picture_in_newest_article
      html = get_blog_list_page
      newest_article_url = article_urls_from_list_page(html).first
      article_html = get_content(newest_article_url)
      image_urls = image_urls_from_article_url(article_html)

      mkdir_today_file_path unless Dir.exist?("img/#{exec_date}")
      download_images_from_url_list(image_urls)
    end

    private

    def get_blog_top_page
      init_url("sakurazaka", "blog_top_page")
    end

    def get_blog_list_page
      init_url("sakurazaka", "blog_list_page")
    end

    def article_urls_from_list_page(html)
      [].tap do |array|
        Nokogiri.parse(html, nil, nil).css(".com-blog-part.box4.fxpc > li").each do |c|
          array << "#{HOME_PAGE}#{c.css("a")[0][:href]}"
        end
      end
    end

    def image_urls_from_article_url(article_html)
      [].tap do |url|
        Nokogiri.parse(article_html, nil, nil).css("img").each do |c|
          image_url = c.attribute("src").value
          next unless image_url.include?("diary")

          url << "#{HOME_PAGE}#{image_url}"
        end
      end
    end

    def download_images_from_url_list(image_urls)
      image_urls.each do |image_url|
        dest_image_path = "img/#{exec_date}/#{image_url[%r([^/]+$)]}"
        File.open(dest_image_path, 'w') do |pass|
          URI.parse(image_url).open do |img|
            pass.write(img.read)
          end
        end
      end
    end
  end
end
