require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe "#full_title" do
    context "ページタイトルが空のとき" do
      it "ページタイトルが空欄の時テスト" do
        expect(helper.full_title).to eq('Landscape_sns')
      end
    end

    context "ページタイトルが入っているとき" do
      it "フルタイトルメソッドのテスト" do
        expect(helper.full_title('About')).to eq('About | Landscape_sns')
      end
    end
  end
end
