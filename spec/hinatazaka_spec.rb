RSpec.describe(SakamichiScraper::Hinatazaka) do
  it "Should get blog page title for hinatazaka-46" do
    hinatazaka = SakamichiScraper::Hinatazaka.new
    expect(hinatazaka.get_blog_top_page_title).to eq "日向坂46公式ブログ | 日向坂46公式サイト"
  end
end
