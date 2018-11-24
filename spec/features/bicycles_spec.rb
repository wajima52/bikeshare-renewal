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
      create_bicycle

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
      create_bicycle_in_interface
    end

    let(:bicycle) { @user.bicycles.find_by(
        name: "Fenix"
    )}

    scenario "正常なBicycle編集" do
      visit edit_bicycle_path(bicycle)

      fill_in "bicycle[name]", with: "BIG.NINE"
      select "マウンテンバイク", from: "bicycle[bicycle_type]"
      click_button "登録"

      expect(current_path).to eq(bicycle_path(bicycle))
      expect(Bicycle.find(bicycle.id).name).to eq("BIG.NINE")
      expect(Bicycle.find(bicycle.id).bicycle_type).to eq("mountain")
    end

    scenario "名前を未入力で「登録」ボタンをクリック" do
      visit edit_bicycle_path(bicycle)

      fill_in "bicycle[name]", with: ""
      select "マウンテンバイク", from: "bicycle[bicycle_type]"
      click_button "登録"

      expect(page).to have_content("自転車の名前を入力してください")
    end
  end

  describe 'deleteアクション' do

    before do
      create_bicycle_in_interface
    end

    let(:bicycle) { @user.bicycles.find_by(
        name: "Fenix"
    )}

    scenario "通常の削除操作" do
      visit bicycle_path(bicycle)
      click_link "削除する"

      expect(Bicylce.find(bicycle.id)).not_to exists
    end
    #
    # scenario "異なるuserが出品したbicycleは削除不可" do
    #   it "bicycleの詳細画面で「削除する」リンクが表示されないこと" do
    #
    #   end
    #
    #   it "直接deleteメソッドを送っても拒否されること" do
    #
    #   end
    #
    # end
  end

  #以下、共通メソッド

  def create_bicycle_in_interface
    visit new_bicycle_path
    fill_in "bicycle[name]", with: "Fenix"
    select "ロードバイク", from: "bicycle[bicycle_type]"
    click_button "登録"
  end
end
