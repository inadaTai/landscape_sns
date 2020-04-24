require 'rails_helper'

RSpec.describe "コメントに関するテスト", type: :system do

  let(:user) { create(:user) }
  let(:micropost) { user.microposts.build(content:"キレイな写真",picture: File.open("#{Rails.root}/db/images_seeds/1.jpeg"), user_id: user.id) }
  let(:comment){FactoryBot.create(:comment)}

  def submit_valid(remember_me = 0)
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    check 'session_remember_me' if remember_me == 1
    click_on 'Landscapeへログイン'
  end

  def submit_valid_micropost
    fill_in '投稿フォーム', with: 'キレイな写真',match: :first
    attach_file 'micropost[picture]', "#{Rails.root}/db/images_seeds/1.jpeg",match: :first
    click_button '投稿する'
  end

  it "返信フォームにアクセスができるかテスト" do
    visit login_path
    submit_valid
    visit root_path
    submit_valid_micropost
    click_on 'この投稿に返信をする'
    expect(current_path).to eq micropost_path(1)
  end

  it "空欄で無効なコメントをしエラーが出るかテスト" do
    visit login_path
    submit_valid
    visit root_path
    submit_valid_micropost
    click_on 'この投稿に返信をする'
    click_on 'コメント投稿'
    expect(page).to have_selector '.alert-danger'
  end

  it "141文字以上の無効なコメントをしエラーが出るかテスト" do
    visit login_path
    submit_valid
    visit root_path
    submit_valid_micropost
    click_on 'この投稿に返信をする'
    fill_in "comment_body", with: 'a'*141
    click_on 'コメント投稿'
    expect(page).to have_selector '.alert-danger'
  end

  it "返信フォームで有効な投稿が出来るかテスト" do
    visit login_path
    submit_valid
    visit root_path
    submit_valid_micropost
    click_on 'この投稿に返信をする'
    fill_in "comment_body", with: 'test投稿します'
    click_on 'コメント投稿'
  end
end
