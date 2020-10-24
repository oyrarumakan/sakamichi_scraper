


module SakamichiScraper
  class Hinatazaka
    attr_reader :html

    def initialize
      url = YAML.load_file("config/url.yml")["hinatazaka"]["blog_top_page"]
      @html = URI.open(url, "User-Agent" => "Chrome/86.0.4240.80") do |f|
        f.read
      end
    end

    def get_blog_top_page_title
      Nokogiri::HTML.parse(html, nil, nil).title
    end
  end
end
