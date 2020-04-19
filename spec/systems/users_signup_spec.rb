require 'rails_helper'

RSpec.describe "ユーザのログインに関するテスト", type: :system do

  it "無効な新規登録をした場合" do
    visit signup_path
    fill_in '名前(サイト内で公開されるお名前です) (例：山田太郎)', with: ''
    fill_in 'ユーザーネーム(サイト内で公開されるお名前です) (例:yamada_517)', with: ''
    fill_in 'メールアドレス', with: 'user@invalid'
    fill_in 'パスワード', with: 'foo'
    fill_in 'もう１度パスワード入力してください', with: 'bar'
    click_on 'アカウント登録'
    expect(current_path).to eq signup_path
    expect(page).to have_selector '#error_explanation'
  end

  it "有効な新規登録をした場合" do
    visit signup_path
    fill_in '名前(サイト内で公開されるお名前です) (例：山田太郎)', with: 'Example User'
    fill_in 'ユーザーネーム(サイト内で公開されるお名前です) (例:yamada_517)', with: 'realname'
    fill_in 'メールアドレス', with: 'user@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'もう１度パスワード入力してください', with: 'password'
    click_on 'アカウント登録'
    expect(current_path).to eq user_path(1)
    expect(page).not_to have_selector '#error_explanation'
  end
end
