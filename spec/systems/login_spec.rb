require 'rails_helper'

RSpec.describe "ログインに関するテスト", type: :system do

  let(:user) { create(:user) }

  def submit_invalid
    fill_in 'メールアドレス', with: ''
    fill_in 'パスワード', with: ''
    click_on 'Landscapeへログイン'
  end

  def submit_valid(remember_me = 0)
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    check 'session_remember_me' if remember_me == 1
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
      visit login_path
      submit_valid
      expect(current_path).to eq user_path(1)
      expect(page).to have_selector '.alert-success'
    end

    it "有効なログイン後にログアウトできるかテスト" do
      visit login_path
      submit_valid
      expect(current_path).to eq user_path(1)
      expect(page).to have_selector '.alert-success'
      click_on 'アカウント'
      click_on 'ログアウト'
      expect(current_path).to eq root_path
    end
  end
end
