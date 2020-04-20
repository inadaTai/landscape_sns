require 'rails_helper'

RSpec.describe "パスワード編集画面のテスト", type: :request do

  let(:user) { create(:user) }

  def patch_invalid
    patch password_edits_edit_path(user), params:{
      user:{
        current_password: "",
        password: "yamada516",
        password_confirmation: "yamada516",
      }
    }
  end

  def patch_valid
    patch password_edits_edit_path(user), params:{
      user:{
        current_password: "password",
        password: "yamada516",
        password_confirmation: "yamada516",
      }
    }
  end

  describe "GET /password_edits/edit" do
    it "パスワード編集ページにアクセスできるかテスト" do
      log_in_as(user)
      get "/password_edits/edit"
      expect(response).to have_http_status(:success)
    end

    context "パスワード変更に関するテスト" do
      it "無効なパスワード変更リクエストのテスト" do
        log_in_as(user)
        get password_edits_edit_path(user)
        patch_invalid
        expect(request.fullpath).to eq '/password_edits/edit.1'
      end

      it "有効なパスワード変更リクエストのテスト" do
        log_in_as(user)
        get password_edits_edit_path(user)
        patch_valid
        expect(flash[:success]).to be_truthy
        follow_redirect!
        expect(request.fullpath).to eq '/users/1'
      end
    end
  end
end
