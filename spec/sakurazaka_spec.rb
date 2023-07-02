RSpec.describe(SakamichiScraper::Sakurazaka) do
  before(:all) do
    @sakurazaka = SakamichiScraper::Sakurazaka.new
  end
  context "get_blog_top_page_title" do
    it "櫻坂46のブログページのタイトルが返却されること" do
      expect(@sakurazaka.blog_top_page_title).to eq "櫻坂46公式サイト"
    end
  end

  context "get_newest_blog_title" do
    it "櫻坂46の最新ブログ記事のタイトルが返却されること" do
      newest_blog_title = @sakurazaka.newest_blog_title
      expect(newest_blog_title).not_to eq nil
      expect(newest_blog_title).is_a?(String)
    end
  end

  context "get_recent_blog_info" do
    it "櫻坂46のnew postsの各要素が正しく返却されること" do
      recent_blog_info = @sakurazaka.recent_blog_info
      expect(recent_blog_info.empty?).to eq false
      expect(recent_blog_info).is_a?(Array)
      expect(recent_blog_info.size).to eq 12
    end
  end

  context "get_picture_in_newest_article" do
    let(:image_path) { "img/sakurazaka/#{Time.now.strftime("%Y%m%d")}" }

    # specを流す前にDLした画像を削除する
    before(:example) do
      Dir.glob("#{image_path}/*.jpg").each { |f| File.delete(f) }
    end

    it "櫻坂46の最新ブログ記事の画像がダウンロードできること" do
      @sakurazaka.picture_in_newest_article
      expect(Dir.glob("#{image_path}/*.jpg").count).to be >= 1
    end
  end

  context "members_name_kanji" do
    it "櫻坂46の漢字のメンバー名一覧が返却されること" do
      expect_res = %w(上村莉菜 小池美波 小林由依 齋藤冬優花 土生瑞穂 井上梨名 遠藤光莉 大園玲 大沼晶保 幸坂茉里乃 武元唯衣 田村保乃
                      藤吉夏鈴 増本綺良 松田里奈 森田ひかる 守屋麗奈 山﨑天 石森璃花 遠藤理子 小田倉麗奈 小島凪紗 谷口愛梨 中島優月 的野美青 向井純葉 村井優 村山美羽 山下瞳月)
      expect(@sakurazaka.members_name_kanji).to eq expect_res
    end
  end

  context "members_name_hiragana" do
    it "櫻坂46のひらがなのメンバー名一覧が返却されること" do
      expect_res = %w(うえむらりな こいけみなみ こばやしゆい さいとうふゆか はぶみづほ いのうえりな えんどうひかり おおぞのれい おおぬまおきほ
                      こうさかまりの たけもとゆい たむらほの ふじよしかりん ますもときら まつだりな もりたひかる もりやれな やまさきてん いしもりりか えんどうりこ おだくられいな こじまなぎさ たにぐちあいり なかしまゆづき まとのみお むかいいとは むらいゆう むらやまみう やましたしづき)
      expect(@sakurazaka.members_name_hiragana).to eq expect_res
    end
  end

  context "members_name_en" do
    it "櫻坂46のアルファベットのメンバー名一覧が返却されること" do
      expect_res = ["Rina Uemura", "Minami Koike", "Yui Kobayashi", "Fuyuka Saito", "Mizuho Habu", "Rina Inoue",
                    "Hikari Endo", "Rei Ozono", "Akiho Onuma", "Marino Kosaka", "Yui Takemoto", "Hono Tamura", "Karin Fujiyoshi", "Kira Masumoto", "Rina Matsuda", "Hikaru Morita", "Rena Moriya", "Ten Yamasaki", "Rika Ishimori", "Riko Endo", "Reina Odakura", "Nagisa Kojima", "Airi Taniguchi", "Yuzuki Nakashima", "Mio Matono", "Itoha Mukai", "Yu Murai", "Miu Murayama", "Shizuki Yamashita"]
      expect(@sakurazaka.members_name_en).to eq expect_res
    end
  end
end
