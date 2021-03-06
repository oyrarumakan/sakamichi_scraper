RSpec.describe(SakamichiScraper::Hinatazaka) do
  before(:all) do
    @hinatazaka = SakamichiScraper::Hinatazaka.new
  end
  context "get_blog_top_page_title" do
    it "日向坂46のブログページのタイトルが返却されること" do
      expect(@hinatazaka.blog_top_page_title).to eq "日向坂46公式ブログ | 日向坂46公式サイト"
    end
  end

  context "get_newest_blog_title" do
    it "日向坂46の最新ブログ記事のタイトルが返却されること" do
      newest_blog_title = @hinatazaka.newest_blog_title
      expect(newest_blog_title).not_to eq nil
      expect(newest_blog_title).is_a?(String)
    end
  end

  context "get_recent_blog_info" do
    it "日向坂46のnew postsの各要素が正しく返却されること" do
      recent_blog_info = @hinatazaka.recent_blog_info
      expect(recent_blog_info).not_to eq nil
      expect(recent_blog_info).is_a?(Array)
      expect(recent_blog_info.size).to eq 12
    end
  end

  context "get_picture_in_newest_article" do
    let(:image_path) { "img/hinatazaka/#{Time.now.strftime("%Y%m%d")}/" }

    # specを流す前にDLした画像を削除する
    before(:example) do
      Dir.glob("#{image_path}/*.jpg").each { |f| File.delete(f) }
    end

    it "日向坂46の最新ブログ記事の画像がダウンロードできること" do
      @hinatazaka.picture_in_newest_article
      expect(Dir.glob("#{image_path}/*.jpg").count).to be >= 1
    end
  end
end
