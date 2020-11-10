RSpec.describe(SakamichiScraper::Sakurazaka) do
  before(:all) do
    @sakurazaka = SakamichiScraper::Sakurazaka.new
  end
  context "get_blog_top_page_title" do
    it "櫻坂46のブログページのタイトルが返却されること" do
      expect(@sakurazaka.get_blog_top_page_title).to eq "櫻坂46公式サイト"
    end
  end

  context "get_newest_blog_title" do
    it "櫻坂46の最新ブログ記事のタイトルが返却されること" do
      newest_blog_title = @sakurazaka.get_newest_blog_title
      expect(newest_blog_title).not_to eq nil
      expect(newest_blog_title).is_a?(String)
    end
  end

  context "get_recent_blog_info" do
    it "櫻坂46のnew postsの各要素が正しく返却されること" do
      recent_blog_info = @sakurazaka.get_recent_blog_info
      expect(recent_blog_info).not_to eq nil
      expect(recent_blog_info).is_a?(Array)
      expect(recent_blog_info.size).to eq 12
    end
  end
end
