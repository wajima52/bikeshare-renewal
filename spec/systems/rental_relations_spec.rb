require 'rails_helper'

RSpec.describe "RentalRelations", type: :system do

  describe "current_userが詳細画面の自転車にレンタルを申し込んでいない時" do

    let(:user) {FactoryBot.create(:user)}
    let(:bicycle) {FactoryBot.create(:bicycle)}

    before do
      login(user)
      visit bicycle_path(bicycle)
    end

    it "「レンタルを申し込む」ボタンが表示される" do
      expect(page).to have_button("レンタルを申し込む")
    end

    it "「レンタルを申し込む」ボタンを押下するとRentalRelation.countが1増える" do
      expect {
        click_button "レンタルを申し込む"
      }.to change{RentalRelation.count}.by(1)
    end

    it "「レンタルを申し込む」ボタンを押下すると「この自転車のレンタルを申し込みました。」のメッセージが表示される" do
      click_button "レンタルを申し込む"
      expect(page).to have_content("この自転車のレンタルを申し込みました。")
    end

    it "「レンタルを申し込む」ボタンを押下するとbicycle#show画面にリダイレクトする" do
      click_button "レンタルを申し込む"
      expect(current_path).to eq(bicycle_path(bicycle))
    end

    it "「レンタル希望を取り消す」ボタンが表示される" do
      click_button "レンタルを申し込む"
      expect(page).to have_button "レンタル希望を取り消す"
    end
  end

  describe 'current_userが詳細画面の自転車にレンタルを申し込んでいる時' do

    let(:rental_relation) {FactoryBot.create(:rental_relation)}
    let(:bicycle) {rental_relation.bicycle}

    before do
      login(rental_relation.borrow_user)
      visit bicycle_path(bicycle)
    end

    it "レンタル希望を取り消す」ボタンが表示される" do
      expect(page).to have_button "レンタル希望を取り消す"
    end

    it "「レンタル希望を取り消す」ボタンを押下するとRentalRelation.countが1減る" do
      expect{
        click_button "レンタル希望を取り消す"
      }.to change{RentalRelation.count}.by(-1)
    end

    it "「レンタル希望を取り消す」ボタンを押下すると「この自転車のレンタル申し込みををキャンセルしました。」のメッセージが表示される" do
      click_button "レンタル希望を取り消す"
      expect(page).to have_content("この自転車のレンタル申し込みををキャンセルしました。")
    end

    it "「レンタル希望を取り消す」ボタンを押下するとbicycle#show画面にリダイレクトする" do
      click_button "レンタル希望を取り消す"
      expect(current_path).to eq(bicycle_path(bicycle))
    end

    it "「レンタル希望を取り消す」ボタンを押下すると「レンタルを申し込む」ボタンが表示される" do
      click_button "レンタル希望を取り消す"
      expect(page).to have_button "レンタルを申し込む"
    end



  end


  #以下、共通メソッド

  def login(user)
    visit new_user_session_path
    fill_in "user[email]"   , with: user.email
    fill_in "user[password]", with: user.password
    click_button "ログイン"
  end

end