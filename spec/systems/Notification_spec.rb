require 'rails_helper'

RSpec.describe "通知機能に関するテスト", type: :system do

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:user_post){FactoryBot.create(:micropost,contributer:user)}

  def valid_follow
    visit '/users/1'
    click_on 'フォロー'
    visit current_path
  end

  def valid_iine
    visit micropost_path(1)
    click_on '0'
  end

  def valid_comment
    visit micropost_path(1)
    fill_in "comment_body", with: 'test投稿します'
    click_on 'コメント投稿'
  end

  describe "コメントが貰えたら通知ページにて通知されているかテスト" do
    before do
      login_system(user)
      user_post
    end
    #たくさん繰り返しのテストを走らせた場合たまに失敗します。
    it "他人ユーザーからフォローされたら有効な通知が来ているかテスト" do
      login_system(other_user)
      valid_follow
      login_system(user)
      visit notifications_path
      expect(page.body).to have_content 'yamamotoがあなたをフォローしました'
    end

    it "いいねされたら有効な通知が来ているかテスト" do
      login_system(other_user)
      valid_iine
      login_system(user)
      visit notifications_path
      expect(page.body).to have_content 'yamamotoがあなたの投稿にいいねをしました。'
    end

    it "自分の投稿へコメントを行い有効な通知が通知欄に来ているかテスト" do
      valid_comment
      visit notifications_path
      expect(page.body).to have_content 'testがあなたの投稿にコメントしました'
    end
  end
end
