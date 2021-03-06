require 'rails_helper'

RSpec.describe "投稿に関するテスト", type: :system do

  let(:user) { FactoryBot.create(:user) }
  let(:micropost) { user.microposts.build(content:"キレイな写真",picture: File.open("#{Rails.root}/db/images_seeds/1.jpeg"), user_id: user.id) }

  def submit_valid_micropost
    fill_in '投稿フォーム', with: 'キレイな写真',match: :first
    attach_file 'micropost[picture]', "#{Rails.root}/db/images_seeds/1.jpeg",match: :first
    click_button '投稿する'
  end

  def submit_invalid_micropost
    fill_in '投稿フォーム', with: 'a'*141, match: :first
    attach_file 'micropost[picture]', "#{Rails.root}/db/images_seeds/1.jpeg",match: :first
    click_button '投稿する'
  end

  context "有効な投稿一覧" do
    before do
      login_system(user)
      visit root_path
    end

    it "有効な投稿をした場合成功したメッセージが出ているかテスト" do
      submit_valid_micropost
      expect(current_path).to eq root_path
      expect(page).to have_selector '.alert-success'
    end

    it "有効な投稿してその後投稿物を削除し成功のメッセージまで出るかテスト" do
      submit_valid_micropost
      expect(current_path).to eq root_path
      expect(page).to have_selector '.alert-success'
      click_on '削除'
      expect(page.driver.browser.switch_to.alert.text).to eq "投稿を削除しますか?"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_selector '.alert-success'
    end
  end

  context "無効な投稿一覧" do
    it "無効な投稿をした場合エラーメッセージが出ているかテスト" do
      login_system(user)
      visit root_path
      submit_invalid_micropost
      expect(current_path).to eq '/microposts'
      expect(page).to have_selector '.alert-danger'
    end
  end
end
