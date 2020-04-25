require 'rails_helper'

RSpec.describe "Likeに関するテスト", type: :system do

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:user_post){FactoryBot.create(:micropost,contributer:user)}

  #いいねボタンは[0]という名前で扱っております(カウントが増える場合のテスト)
  def submit_valid_likes
    visit micropost_path(1)
    click_button '0'
    visit current_path
  end
  #いいねボタンは[1]という名前で扱っております(カウントが減る場合のテスト)
  def submit_valid_unlikes
    click_button '1'
    visit current_path
  end

  before do
    login_system(user)
    user_post
  end

  it "他人の投稿にいいねを行いカウントが増えているか確認のテスト" do
    login_system(other_user)
    expect{ submit_valid_likes }.to change(other_user.likes,:count).by(1)
  end

  it "他人の投稿にいいねを行いカウントが減るか確認のテスト" do
    login_system(other_user)
    submit_valid_likes
    expect{ submit_valid_unlikes }.to change(other_user.likes,:count).by(-1)
  end

  #いいねボタンは[0]という名前で扱っております
  it "自分の投稿に対していいねボタンが無いことを確認のテスト" do
    visit micropost_path(1)
    expect(page).not_to have_button '0'
  end
end
