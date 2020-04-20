require 'rails_helper'

RSpec.describe "ユーザー新規登録に関するテスト", type: :request do
  include SessionsHelper

  def post_invalid
    post signup_path, params: {
      user: {
        realname: "",
        name: "",
        email: "user@invalid",
        password: "foo",
        password_confirmation: "bar"
        }
      }
  end

  def post_valid
    post signup_path, params: {
      user: {
        realname: "tanaka",
        name: "tanaka",
        email: "user@gmail.com",
        password: "foobar",
        password_confirmation: "foobar"
        }
      }
  end

  describe "GET /signup" do
    it "新規登録画面へアクセスできるかテスト" do
      get "/signup"
      expect(response).to have_http_status(:success)
    end

    it "無効な新規登録情報テスト" do
      get signup_path
      expect { post_invalid }.not_to change(User, :count)
      expect(is_logged_in?).to be_falsey
    end

    it "有効な新規登録情報テスト" do
      get signup_path
      expect { post_valid }.to change(User, :count).by(1)
      expect(is_logged_in?).to be_truthy
      follow_redirect!
      expect(request.fullpath).to eq '/users/1'
    end
  end
end
