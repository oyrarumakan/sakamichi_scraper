require "fileutils"

module SakamichiScraper
  class Base
    def init_url(group_name, yml_key)
      url = YAML.load_file("config/url.yml")["#{group_name}"]["#{yml_key}"]
      get_content(url)
    end

    def get_content(url)
      URI.open(url, "User-Agent" => "Ruby/2.7.1") do |f|
        f.read
      end
    end

    def format_content(content)
      content.gsub(/[\r\n\s]/, "")
    end

    def format_timestamp(datetime)
      DateTime.parse(datetime).strftime('%Y-%-m-%-d %-H:%-M')
    end

    def exec_date
      @exec_date ||= Time.now.strftime('%Y%m%d')
    end

    def mkdir_today_file_path
      FileUtils.mkdir_p("img/#{exec_date}")
    end
  end
end
