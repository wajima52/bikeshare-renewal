require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "正常なユーザーログイン" do
    user = FactoryBot.create(:user)

    visit new_user_session_path
    fill_in "user[email]"   , with: user.email
    fill_in "user[password]", with: user.password
    click_button "ログイン"

    expect(current_path).to eq(root_path)
    expect(page).to have_content "ログインしました。"
  end

  scenario "正常なユーザ登録" do
    user = FactoryBot.build(:user)

    visit new_user_registration_path
    fill_in "user[username]"             , with: user.username
    fill_in "user[email]"                , with: user.email
    fill_in "user[password]"             , with: user.password
    fill_in "user[password_confirmation]", with: user.password
    click_button "アカウント登録"

    expect(current_path).to eq(root_path)
    expect(page).to have_content"アカウント登録が完了しました。"
  end

  scenario "パスワードを３回まで間違えてもアカウントロックされない" do
    user = FactoryBot.create(:user)
    3.times do
      visit new_user_session_path
      fill_in "user[email]"   , with: user.email
      fill_in "user[password]", with: "hogehoge123"
      click_button "ログイン"

      expect(page).to have_content"Eメールまたはパスワードが違います。"
      expect(current_path).to eq(new_user_session_path)
    end

    fill_in "user[email]"   , with: user.email
    fill_in "user[password]", with: user.password
    click_button "ログイン"

    expect(current_path).to eq(root_path)
    expect(page).to have_content "ログインしました。"
  end

  scenario "パスワードを4回間違えるとアカウントロックされる" do
    user = FactoryBot.create(:user)
    4.times do
      visit new_user_session_path
      fill_in "user[email]"   , with: user.email
      fill_in "user[password]", with: "hogehoge123"
      click_button "ログイン"

      expect(page).to have_content"Eメールまたはパスワードが違います。"
      expect(current_path).to eq(new_user_session_path)
    end

    fill_in "user[email]"   , with: user.email
    fill_in "user[password]", with: user.password
    click_button "ログイン"

    expect(page).to have_content"Eメールまたはパスワードが違います。"
    expect(current_path).to eq(new_user_session_path)
  end
end
