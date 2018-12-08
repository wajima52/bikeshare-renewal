require 'rails_helper'

RSpec.describe Bicycle, type: :model do

  let(:bicycle) {FactoryBot.build(:bicycle)}

  it "factoryが有効であること" do
    bicycle.valid?

    expect(bicycle).to be_valid
  end

  describe "バリデーションテスト" do

    it "nameが空のときにエラー" do
      bicycle.name = nil
      bicycle.valid?

      expect(bicycle).not_to be_valid
    end

    it "typeが空の時にエラー" do
      bicycle.bicycle_type = nil
      bicycle.valid?

      expect(bicycle).not_to be_valid
    end
  end

  describe "リレーションテスト" do
    it "ユーザーに紐づかないBicycleはエラー" do
      bicycle.user = nil
      bicycle.valid?

      expect(bicycle).not_to be_valid
    end

    it "ユーザが削除された時、紐づくBicycleも削除されること" do
      bicycle.save
      user = bicycle.user
      expect{user.destroy}.to change{Bicycle.count}.by(-1)
    end
  end
end
