require 'rails_helper'

RSpec.describe "Likeに関するテスト", type: :system do

  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:micropost) { user.microposts.build(content:"キレイな写真",picture: File.open("#{Rails.root}/db/images_seeds/1.jpeg"), user_id: user.id) }

  def submit_valid_micropost
    fill_in '投稿フォーム', with: 'キレイな写真',match: :first
    attach_file 'micropost[picture]', "#{Rails.root}/db/images_seeds/1.jpeg",match: :first
    click_button '投稿する'
  end

  def submit_valid_login(remember_me = 1)
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    check 'session_remember_me' if remember_me == 1
    click_on 'Landscapeへログイン'
  end

  #いいねボタンは[0]という名前で扱っております
  def submit_valid_likes(remember_me = 1)
    fill_in 'メールアドレス', with: "yamamoto@gmail.com"
    fill_in 'パスワード', with: 'foobar'
    check 'session_remember_me' if remember_me == 1
    click_on 'Landscapeへログイン'
    visit micropost_path(1)
    click_button '0'
    visit current_path
  end

  #いいねボタンは[0]という名前で扱っております
  it "他人の投稿にいいねが可能なテスト" do
    visit login_path
    submit_valid_login(remember_me = 1)
    visit root_path
    submit_valid_micropost
    click_on 'アカウント'
    click_on 'ログアウト'
    visit root_path
    visit login_path
    expect{submit_valid_likes(remember_me = 1)}.to change(other_user.likes,:count).by(1)
  end

  #いいねボタンは[0]という名前で扱っております
  it "自分の投稿に対していいねボタンが無いことを確認のテスト" do
    visit login_path
    submit_valid_login(remember_me = 1)
    visit root_path
    submit_valid_micropost
    visit micropost_path(1)
    expect(page).not_to have_button '0'
  end
end
