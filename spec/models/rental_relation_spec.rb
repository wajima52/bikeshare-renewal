require 'rails_helper'

RSpec.describe RentalRelation, type: :model do

  let(:bicycle) { FactoryBot.create(:bicycle)}
  let(:borrow_user) {FactoryBot.create(:user)}

  context 'CRUD, バリデーション' do
    it 'bicycle_idとborrow_userの情報があればcreateが成功すること' do
      rental_relation = RentalRelation.new(bicycle: bicycle, borrow_user: borrow_user)
      expect(rental_relation).to be_valid
    end

    it '自転車が削除された時、その自転車に申し込みをしている情報が削除されること' do
      RentalRelation.create(bicycle: bicycle, borrow_user: borrow_user)
      expect{ bicycle.destroy }.to change{RentalRelation.count}.by(-1)
    end

    it '自転車と申し込み者の組み合わせに重複がある場合はエラー' do
      RentalRelation.create(bicycle: bicycle, borrow_user: borrow_user)
      rental_relation = RentalRelation.new(bicycle: bicycle, borrow_user: borrow_user)
      expect(rental_relation).not_to be_valid
    end

    it '自転車の情報が空の場合はエラー' do
      rental_relation = RentalRelation.new(bicycle_id: nil, borrow_user: borrow_user)
      expect(rental_relation).not_to be_valid
    end

    it '申し込み者の情報が空の場合はエラー' do
      rental_relation = RentalRelation.create(bicycle: bicycle)
      expect(rental_relation).not_to be_valid
    end

    it '出品者は自分の自転車の申し込みができないこと' do
      rental_relation = RentalRelation.new(bicycle: bicycle, borrow_user: bicycle.user)
      expect(rental_relation).not_to be_valid
    end
  end

  context '関数定義' do
    it '自転車を貸しているユーザーを出力するlend_userメソッドを作成する' do
      rental_relation = RentalRelation.create(bicycle: bicycle, borrow_user: borrow_user)
      expect(rental_relation.lend_user).to eq bicycle.user
    end
  end

end

