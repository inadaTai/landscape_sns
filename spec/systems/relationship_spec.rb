require 'rails_helper'

RSpec.describe "フォローに関するテスト", type: :system do

    let(:user) { create(:user) }
    let(:other_user) { create(:other_user) }

    def submit_valid_login(remember_me = 0)
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      check 'session_remember_me' if remember_me == 1
      click_on 'Landscapeへログイン'
    end

    def submit_valid_other(remember_me = 0)
      fill_in 'メールアドレス', with: 'yamamoto@gmail.com'
      fill_in 'パスワード', with: 'foobar'
      check 'session_remember_me' if remember_me == 1
      click_on 'Landscapeへログイン'
    end

    def valid_follow
      visit '/users/2'
      click_on 'フォロー'
      visit current_path
    end

    describe "ユーザーが他ユーザに対するフォロー確認テスト" do
      before do
        visit login_path
        submit_valid_login
      end

      it "ユーザーが他人ユーザーをフォローできるかテスト" do
        log_in_as(other_user)
        visit '/users/2'
        click_on 'フォロー'
        visit current_path
        expect(page).to have_button 'フォロー解除'
      end

      it "フォローしたらカウントが増えるか確認のテスト" do
        log_in_as(other_user)
        expect{ valid_follow }.to change(user.following,:count).by(1)
      end

      it "ユーザーが他人ユーザーをフォロー解除ができるかテスト" do
        log_in_as(other_user)
        visit '/users/2'
        click_on 'フォロー'
        visit current_path
        click_on 'フォロー解除'
        visit current_path
        expect(page).to have_button 'フォロー'
      end

      it "ユーザーが自分のページにはフォローボタン表示無し確認のテスト" do
        log_in_as(user)
        visit '/users/1'
        expect(page).not_to have_button 'フォロー'
      end
    end
  end
