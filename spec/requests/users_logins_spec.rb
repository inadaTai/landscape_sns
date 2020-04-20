require 'rails_helper'

RSpec.describe "Usersログインに関するテスト", type: :request do
  include SessionsHelper

  let(:user) { create(:user) }

  def post_invalid_infomation
    post login_path, params: {
      session: {
        email: "",
        password: ""
      }
    }
  end
  #記憶トークンの引数つき有効なログイン情報のメソッド（ログインするためにpostを送る）
  def post_valid_information(remember_me = 0)
    post login_path,params:{
      session:{
        email: user.email,
        password: user.password,
        remember_me: remember_me
        }
      }
  end

  describe "記憶トークン(remember_token)に関するテスト" do
    it "2回ログアウトができないか確認のテスト" do
      get login_path
      post_valid_information(0)
      expect(is_logged_in?).to be_truthy
      follow_redirect!
      expect(request.fullpath).to eq '/users/1'
      delete logout_path
      expect(is_logged_in?).to be_falsey
      follow_redirect!
      expect(request.fullpath).to eq '/'
      delete logout_path
      expect(is_logged_in?).to be_falsey
      follow_redirect!
      expect(request.fullpath).to eq '/'
    end

    it "記憶トークンを利用してログインが出来ているかテスト" do
      get login_path
      post_valid_information(1)
      expect(is_logged_in?).to be_truthy
      expect(cookies[:remember_token]).not_to be_nil
    end

    it "記憶トークンを使用しログインしてログアウトした場合記憶トークンは空であるテスト" do
      get login_path
      post_valid_information(1)
      expect(is_logged_in?).to be_truthy
      expect(cookies[:remember_token]).not_to be_empty
      delete logout_path
      expect(is_logged_in?).to be_falsey
      expect(cookies[:remember_token]).to be_empty
    end
  end

  describe "GET /login" do
    it "無効なログイン情報送信テスト" do
      get login_path
      post_invalid_infomation
      expect(flash[:danger]).to be_truthy
      expect(is_logged_in?).to be_falsey
    end
    
    it "有効なログイン情報送信テスト" do
      get login_path
      post_valid_information(0)
      expect(is_logged_in?).to be_truthy
      expect(cookies[:remember_token]).to be_nil
    end

    it "有効なログイン後ログアウトする" do
      get login_path
      post_valid_information(1)
      expect(is_logged_in?).to be_truthy
      expect(cookies[:remember_token]).not_to be_empty
      delete logout_path
      expect(is_logged_in?).to be_falsey
      expect(cookies[:remember_token]).to be_empty
    end
  end
end
