require 'rails_helper'

RSpec.describe Micropost, type: :model do

  let(:user) { create(:user) }
  let(:micropost) { user.microposts.build(content: "綺麗な景色",
                                          picture: File.open("#{Rails.root}/db/images_seeds/1.jpeg") ) }

  describe "Micropost" do
    context "有効な送信パターン" do
      it "有効な投稿か確認" do
        expect(micropost).to be_valid
      end

      it "コメント140文字と写真がある有効な投稿" do
        micropost.content = "a" * 140
        micropost.picture =  File.open("#{Rails.root}/db/images_seeds/1.jpeg")
        expect(micropost).to be_valid
      end
    end

    context "無効な送信パターン" do
      it "コメント無と写真ありの場合は無効な投稿" do
        micropost.content = ""
        micropost.picture = File.open("#{Rails.root}/db/images_seeds/1.jpeg")
        expect(micropost).to be_invalid
      end

      it "コメントあり(141文字以上)と写真ありの場合は無効な投稿" do
        micropost.content = "a"*141
        micropost.picture = File.open("#{Rails.root}/db/images_seeds/1.jpeg")
        expect(micropost).to be_invalid
      end

      it "コメントありと写真無しの場合は無効な投稿" do
        micropost.content = "綺麗な景色"
        micropost.picture = nil
        expect(micropost).to be_invalid
      end
    end
  end
end
