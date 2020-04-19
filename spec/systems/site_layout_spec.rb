require 'rails_helper'

RSpec.describe "サイトのレイアウトに関するテスト", type: :system do

  describe "各パスのタイトル確認" do
    it "ルートパスのタイトル確認" do
      visit root_path
      expect(page).to have_title 'Landscape_sns'
    end

    it "アバウトのタイトル確認" do
      visit about_path
      expect(page).to have_title 'About | Landscape_sns'
    end

    it "お問い合わせのタイトル確認" do
      visit contact_path
      expect(page).to have_title 'お問い合わせ | Landscape_sns'
    end

    it "ヘルプのタイトル確認" do
      visit help_path
      expect(page).to have_title 'ヘルプ | Landscape_sns'
    end

    it "利用規約のタイトル確認" do
      visit policy_path
      expect(page).to have_title '利用規約 | Landscape_sns'
    end
  end
end
