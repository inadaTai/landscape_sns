require 'rails_helper'

RSpec.describe Like, type: :model do

  let(:like){FactoryBot.create(:like)}

  it '有効なlikeの関係性のテスト' do
    expect(like).to be_valid
  end

  it 'Likeはuserがないと無効テスト' do
    like.user = nil
    expect(like).not_to be_valid
  end

  it 'Likeはmicropostがないと無効テスト' do
    like.micropost = nil
    expect(like).not_to be_valid
  end
end
