require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let(:micropost) { user.microposts.build(content: "綺麗な景色",
                                          picture: File.open("#{Rails.root}/db/images_seeds/1.jpeg") ) }
  let(:comment){ FactoryBot.create(:comment) }

  describe "コメント機能" do
    it "有効なコメントか確認" do
      expect(comment).to be_valid
    end

    it "コメント140文字のコメントは有効なコメント" do
      comment.body = "a" * 140
      expect(comment).to be_valid
    end

    it "コメント141文字を超えるコメントは無効なコメント" do
      comment.body = "a" * 141
      expect(comment).to be_invalid
    end

    it "コメントが空欄の場合は無効なコメント" do
      comment.body = ""
      expect(comment).to be_invalid
    end
  end
end
