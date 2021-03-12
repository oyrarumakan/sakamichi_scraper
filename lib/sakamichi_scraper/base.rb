require "fileutils"

module SakamichiScraper
  class Base
    def initialize(group_name)
      @group_name = group_name
      @home_page = "https://#{@group_name}46.com"
    end

    def init_url_from_yml(group_name, yml_key)
      url = YAML.load_file("config/url.yml")["#{group_name}"]["#{yml_key}"]
      get_content(url)
    end

    def get_content(url)
      URI.open(url, "User-Agent" => "Ruby/2.7.1", &:read)
    end

    def blog_top_page
      init_url_from_yml(@group_name, "blog_top_page")
    end

    def blog_list_page
      init_url_from_yml(@group_name, "blog_list_page")
    end

    def format_content(content)
      content.gsub(/[\r\n\s]/, "")
    end

    def format_timestamp(datetime)
      DateTime.parse(datetime).strftime("%Y-%-m-%-d %-H:%-M")
    end

    def exec_date
      @exec_date ||= Time.now.strftime("%Y%m%d")
    end

    def mkdir_today_file_path
      FileUtils.mkdir_p("img/#{exec_date}")
    end

    def exclude_img_path(group_name)
      YAML.load_file("config/url.yml")["#{group_name}"]["exclude_img_path"]
    end

    def image_urls_from_article_url(article_html, class_name)
      [].tap do |url|
        Nokogiri.parse(article_html, nil, nil).css("#{class_name} img").each do |c|
          image_url = c.attribute("src").value
          url << case @group_name
                 when "sakurazaka"
                   "#{@home_page}#{image_url}"
                 else
                   image_url
                 end
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
  end
end
