require 'rails_helper'

RSpec.describe "サイトのレイアウトに関するテスト", type: :system do

  let(:user) { FactoryBot.create(:user) }
  let(:user_post){FactoryBot.create(:micropost,contributer:user)}

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

    it "通知一覧のタイトル確認" do
      login_system(user)
      visit notifications_path
      expect(page).to have_title '通知一覧 | Landscape_sns'
    end

    it "パスワード編集ページのタイトル確認" do
      login_system(user)
      visit password_edits_edit_path(user)
      expect(page).to have_title 'パスワード編集ページ | Landscape_sns'
    end
    #変数なのでユーザーの名前も変わればその都度ページの名前が変わります。
    it "ユーザー名(test)ページのタイトル確認" do
      login_system(user)
      visit user_path(user)
      expect(page).to have_title 'test | Landscape_sns'
    end

    it "ユーザ- 一覧ページのタイトル確認" do
      login_system(user)
      visit users_path
      expect(page).to have_title 'ユーザ- 一覧ページ | Landscape_sns'
    end

    it "新規登録のタイトル確認" do
      visit signup_path
      expect(page).to have_title '新規登録 | Landscape_sns'
    end

    it "返信ページのタイトル確認" do
      login_system(user)
      user_post
      visit micropost_path(1)
      expect(page).to have_title '返信 | Landscape_sns'
    end
  end
end
