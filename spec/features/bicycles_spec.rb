require 'rails_helper'

RSpec.feature "Bicycles", type: :feature do

  before do
    @user = FactoryBot.create(:user)

    visit new_user_session_path
    fill_in "user[email]"   , with: @user.email
    fill_in "user[password]", with: @user.password
    click_button "ログイン"
  end

  describe 'newアクション'do

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
end
