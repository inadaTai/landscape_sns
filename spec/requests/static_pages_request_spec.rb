require 'rails_helper'

RSpec.describe "Staticpages", type: :request do

  describe "GET /home" do
    it "ルートへアクセス可能テスト" do
      get "/home"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /help" do
    it "ヘルプへアクセス可能テスト" do
      get "/help"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /about" do
    it "アバウトへアクセス可能テスト" do
      get "/about"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /contact" do
    it "お問合せへアクセス可能テスト" do
      get "/contact"
      expect(response).to have_http_status(:success)
    end
  end

end
