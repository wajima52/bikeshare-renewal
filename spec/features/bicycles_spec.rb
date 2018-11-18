require 'rails_helper'

RSpec.feature "Bicycles", type: :feature do

  before do
    @user = FactoryBot.create(:user)

    visit new_user_session_path
    fill_in "user[email]"   , with: @user.email
    fill_in "user[password]", with: @user.password
    click_button "ログイン"
  end

  describe 'new, createアクション'do
    scenario "正常なBicycle投稿" do
      visit new_bicycle_path
      fill_in "bicycle[name]", with: "Fenix"
      select "ロードバイク", from: "bicycle[bicycle_type]"
      click_button "登録"

      expect(page).to have_content("正常に登録されました")
    end

    scenario "名前を未入力で「登録」ボタンをクリック" do
      visit new_bicycle_path
      select "ロードバイク", from: "bicycle[bicycle_type]"
      click_button "登録"

      expect(page).to have_content("自転車の名前を入力してください")
      expect(current_path).to eq('/bicycles')
    end
  end

  describe 'edit, updateアクション'do
    before do
      visit new_bicycle_path
      fill_in "bicycle[name]", with: "Fenix"
      select "ロードバイク", from: "bicycle[bicycle_type]"
      click_button "登録"
    end

    scenario "正常なBicycle編集" do
      visit edit_bicycle_path

      fill_in "bicycle[name]", with: "BIG.NINE"
      select "マウンテンバイク", from: "bicycle[bicycle_type]"
      click_button "編集"

      expect(Bicycle.first.name).to eq("BIG.NINE")
      expect(Bicycle.first.bicycle_type).to eq("マウンテンバイク")
    end

    scenario "名前を未入力で「登録」ボタンをクリック" do
      visit edit_bicycle_path

      fill_in "bicycle[name]", with: ""
      select "マウンテンバイク", from: "bicycle[bicycle_type]"
      click_button "編集"

      expect(page).to have_content("自転車の名前を入力してください")
    end
  end

end
