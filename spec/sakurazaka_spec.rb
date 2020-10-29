RSpec.describe(SakamichiScraper::Sakurazaka) do
  before(:all) do
    @sakurazaka = SakamichiScraper::Sakurazaka.new
  end
  context "get_blog_top_page_title" do
    it "櫻坂46のブログページのタイトルが返却されること" do
      expect(@sakurazaka.get_blog_top_page_title).to eq "櫻坂46公式サイト"
    end
  end
end
