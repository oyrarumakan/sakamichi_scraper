require_relative "base"

module SakamichiScraper
  class Sakurazaka < Base
    def initialize
      super("sakurazaka")
    end

    def blog_top_page_title
      Nokogiri::HTML.parse(blog_top_page, nil, nil).title
    end

    def newest_blog_title
      Nokogiri.parse(blog_list_page, nil, nil).at_css(".date-title > .title").children.to_s
    end

    def recent_blog_info
      res = []
      Nokogiri.parse(blog_list_page, nil, nil).css(".com-blog-part.box4.fxpc > li").each do |c|
        info = {
          member: c.css(".prof-in.fx > .name").children.to_s,
          title: c.css(".date-title > .title").children.to_s,
          timestamp: c.css(".date.wf-a").children.to_s
        }
        res << info
      end
    end

    def picture_in_newest_article
      newest_article_url = article_urls_from_list_page(blog_list_page).first
      article_html = get_content(newest_article_url)
      image_urls = image_urls_from_article_url(article_html, "div.box-article")

      mkdir_today_file_path unless Dir.exist?(image_file_path)
      download_images_from_url_list(image_urls)
    end

    def members_name_kanji
      extract_member_list(target: "name_ja")
    end

    def members_name_hiragana
      extract_member_list(target: "name_ja_hiragana")
    end

    def members_name_en
      extract_member_list(target: "name_en")
    end

    private

    def article_urls_from_list_page(html)
      [].tap do |array|
        Nokogiri.parse(html, nil, nil).css(".com-blog-part.box4.fxpc > li").each do |c|
          array << "#{@home_page}#{c.css("a")[0][:href]}"
        end
      end
    end
  end
end
