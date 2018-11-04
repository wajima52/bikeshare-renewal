require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "ユーザー登録" do
    context "正常なログイン動作" do
      before do
        user = FactoryBot.create(:user)
      end
    end
    visit new_user_session_path
    fill_in "user[username]", with: user.username
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    fill_in "user[password_confirmation]", with: user.password
    click_button "アカウント登録"

    expect
end


