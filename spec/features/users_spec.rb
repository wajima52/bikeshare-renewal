require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "正常なユーザーログイン" do
    user = FactoryBot.create(:user)

    visit new_user_session_path
    fill_in "user[email]"                , with: user.email
    fill_in "user[password]"             , with: user.password
    click_button "ログイン"

    expect(page).to have_content "ログインしました。"
  end


end


