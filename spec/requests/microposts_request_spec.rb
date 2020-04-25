require 'rails_helper'

RSpec.describe "Microposts", type: :request do

  let(:user) { FactoryBot.create(:user) }
  let(:user_post){FactoryBot.create(:micropost,contributer:user)}

  describe "GET /microposts/show" do
    it "コメント返信ページにアクセス可能テスト" do
      log_in_as(user)
      user_post
      get micropost_path(1)
      expect(response).to have_http_status(:success)
    end
  end
end
