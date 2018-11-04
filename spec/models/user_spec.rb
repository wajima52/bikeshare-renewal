require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { User.new(
      username: "taro",
      email: "example@aa.com",
      password: "example1"
  )}


  it "ユーザ名、メール、パスワードがあれば有効であること" do
    expect(user).to be_valid
  end

  context "ユーザ名がnilの場合" do
    it "バリデーションエラー" do
      user.username = nil
      expect(user).not_to be_valid
    end
  end

  context "emailがnilの場合" do
    it "バリデーションエラー" do
      user.email = nil
      expect(user).not_to be_valid
    end
  end

  context "passwordがnilの場合" do
    it "バリデーションエラー" do
      user.password = nil
      expect(user).not_to be_valid
    end
  end

  context "パスワードが英字のみの場合" do
    it "バリデーションエラー" do
      user.password = "exampleeeee"
      expect(user).not_to be_valid
    end
  end

  context "パスワードが数字のみの場合" do
    it "バリデーションエラー" do
      user.password = "12345678"
      expect(user).not_to be_valid
    end
  end

  context "パスワードが7字の場合" do
    it "バリデーションエラー" do
      user.password = "exampl2"
      expect(user).not_to be_valid
    end
  end

  context "同じメールアドレスが登録された場合" do
    it "バリデーションエラー" do
      user.save
      user2 = User.new(
          username: "hanako",
          email: "example@aa.com",
          password: "hanako11"
      )
      expect(user2).not_to be_valid
    end
  end

  it "ファクトリが有効であること" do
    expect(FactoryBot.build(:user)).to be_valid
  end

end
