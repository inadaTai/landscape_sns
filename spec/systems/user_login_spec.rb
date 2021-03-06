require 'rails_helper'

RSpec.describe "ログインに関するテスト", type: :system do

  let(:user) { FactoryBot.create(:user) }

  def submit_invalid
    fill_in 'メールアドレス', with: ''
    fill_in 'パスワード', with: ''
    click_on 'Landscapeへログイン'
  end

  context "ログイン失敗時のメッセージに関するテスト" do
    it "無効なログイン情報を渡した場合エラー表記が出ているか" do
      visit login_path
      submit_invalid
      expect(current_path).to eq login_path
      expect(page).to have_selector '.alert-danger'
    end

    it "無効なログイン情報を渡しエラー表記がログインページのみ出ているかテスト" do
      visit login_path
      submit_invalid
      expect(current_path).to eq login_path
      expect(page).to have_selector '.alert-danger'
      visit root_path
      expect(page).not_to have_selector '.alert-danger'
    end
  end

  context "有効なログイン時のメッセージに関するテスト" do
    it "有効なログイン情報を渡した場合成功の表記が出ているか" do
      login_system(user)
      expect(current_path).to eq user_path(1)
      expect(page).to have_selector '.alert-success'
    end

    it "有効なログイン後にログアウトできるかテスト" do
      login_system(user)
      expect(current_path).to eq user_path(1)
      expect(page).to have_selector '.alert-success'
      click_on 'アカウント'
      click_on 'ログアウト'
      expect(current_path).to eq root_path
    end

    it "有効なログイン後にLandscapeを退会できるかテスト" do
      login_system(user)
      expect(current_path).to eq user_path(1)
      expect(page).to have_selector '.alert-success'
      click_on 'アカウント'
      click_on '設定'
      click_on 'Landscapeを退会',match: :first
      expect(page.driver.browser.switch_to.alert.text).to eq "退会の手続きをされますと全てのサービスが利用不可となります、再度ご利用いただくにはID登録が必要となります。
本当に退会してよろしいですか?"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_selector '.alert-success'
      expect(current_path).to eq root_path
    end
  end
end
