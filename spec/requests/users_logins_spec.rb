require 'rails_helper'

RSpec.describe "Usersログインに関するテスト", type: :request do

  let(:user) { create(:user) }

  describe "GET /login" do
    it "無効なログイン情報送信テスト" do
      get login_path
      post login_path, params: {
        session: {
          email: "",
          password: ""
        }
      }
      expect(flash[:danger]).to be_truthy
      expect(is_logged_in?).to be_falsey
    end

    it "有効なログイン情報送信テスト" do
      get login_path
      post login_path, params: {
        session: {
          email: user.email,
          password: user.password
        }
      }
      expect(flash[:danger]).to be_falsey
      expect(is_logged_in?).to be_truthy
    end

    it "有効なログイン後ログアウトする" do
      get login_path
      post login_path, params: {
        session: {
        email: user.email,
        password: user.password
        }
      }
      expect(is_logged_in?).to be_truthy
      delete logout_path
      expect(is_logged_in?).to be_falsey
  end
  end
end
