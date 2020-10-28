RSpec.describe(SakamichiScraper::Hinatazaka) do
  context "日向坂46の公式サイトにアクセスした際" do
    before(:all) do
      @hinatazaka = SakamichiScraper::Hinatazaka.new
    end
    it "日向坂46のブログページのタイトルが返却されること" do
      expect(@hinatazaka.get_blog_top_page_title).to eq "日向坂46公式ブログ | 日向坂46公式サイト"
    end

    it "日向坂46の最新ブログ記事のタイトルが返却されること" do
      expect(@hinatazaka.get_recent_blog_title).not_to eq nil
    end
  end
end
