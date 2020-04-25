require 'rails_helper'

RSpec.describe "通知ページのアクセスに関するテスト", type: :request do

  let(:user) { FactoryBot.create(:user) }

  describe "GET /notifications" do
    it "通知ページにアクセス可能テスト" do
      log_in_as(user)
      get "/notifications"
      expect(response).to have_http_status(:success)
    end
  end
end
