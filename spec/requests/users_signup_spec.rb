require 'rails_helper'

RSpec.describe "Users新規登録に関するテスト", type: :request do

  describe "GET /signup" do
    it "新規登録画面へアクセスできるかテスト" do
      get "/signup"
      expect(response).to have_http_status(:success)
    end

    it "無効なログイン情報テスト" do
      get signup_path
      expect {
      post signup_path, params: {
          user: {
          realname: "",
          name: "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar"
          }
        }
      }.not_to change(User, :count)
    end

    it "有効なログイン情報テスト" do
      get signup_path
      expect {
      post signup_path, params: {
          user: {
          realname: "tanaka",
          name: "tanaka",
          email: "user@gmail.com",
          password: "foobar",
          password_confirmation: "foobar"
          }
        }
      }.to change(User, :count).by(1)
    end
  end
end
