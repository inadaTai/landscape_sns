require 'rails_helper'

RSpec.describe "フォローに関するテスト", type: :system do

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }

  def valid_follow
    visit '/users/1'
    click_on 'フォロー'
    visit current_path
  end

  def valid_unfollow
    visit '/users/1'
    click_on 'フォロー解除'
    visit current_path
  end

  describe "ユーザーが他ユーザに対するフォロー確認テスト" do
    before do
      login_system(user)
    end

    it "ユーザーが他人ユーザーをフォローできるかテスト" do
      login_system(other_user)
      valid_follow
      expect(page).to have_button 'フォロー解除'
    end

    it "フォローしたらfollowingカウントが増えるか確認のテスト" do
      login_system(other_user)
      expect{ valid_follow }.to change(other_user.following,:count).by(1)
    end

    it "フォロー解除したらfollowersカウントが減るか確認のテスト" do
      login_system(other_user)
      valid_follow
      expect{ valid_unfollow }.to change(user.followers,:count).by(-1)
    end

    it "ユーザーが他人ユーザーをフォロー解除ができるかテスト" do
      login_system(other_user)
      valid_follow
      click_on 'フォロー解除'
      visit current_path
      expect(page).to have_button 'フォロー'
    end

    it "ユーザーが自分のページにはフォローボタン表示無し確認のテスト" do
      visit '/users/1'
      expect(page).not_to have_button 'フォロー'
    end
  end
end
