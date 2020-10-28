module SakamichiScraper
  class Base
    def init_url(group_name, yml_key)
      url = YAML.load_file("config/url.yml")["#{group_name}"]["#{yml_key}"]
      get_content(url)
    end

    def get_content(url)
      URI.open(url, "User-Agent" => "Chrome/86.0.4240.80") do |f|
        f.read
      end
    end

    def format_content(content)
      content.gsub(/[\r\n\s]/, "")
    end

    def format_timestamp(datetime)
      DateTime.parse(datetime).strftime('%Y-%-m-%-d %-H:%-M')
    end
  end
end
