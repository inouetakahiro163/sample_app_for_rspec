require 'rails_helper'

RSpec.describe 'Users', type: :system do
  # login処理をsupportから呼び込む
  include LoginSupport
  # userの遅延読み込みletを定義
  let(:user){ FactoryBot.create(:user) }

  describe 'Before_login' do
    describe 'create new user' do
      context 'fill_in collect' do
        it 'success create new user' do
          # Signupページへ
          visit sign_up_path
          # Emailの入力
          fill_in "Email", with: "test@example.com"
          # passwordの入力
          fill_in "Password", with: "password"
          # Password confirmationの入力
          fill_in "Password confirmation", with: "password"
          # SignUpボタンを押す
          click_button "SignUp"

          expect(current_path).to eq login_path
          expect(page).to have_content "User was successfully created."
        end
      end
      context 'email is not fill_in ' do
        it 'fail create new user' do
          # Signupページへ
          visit sign_up_path
          # Emailが未入力
          fill_in "Email", with: nil
          # passwordの入力
          fill_in "Password", with: "password"
          # Password confirmationの入力
          fill_in "Password confirmation", with: "password"
          # SignUpボタンを押す
          click_button "SignUp"

          expect(current_path).to eq users_path
          expect(page).to have_content "Email can't be blank"
        end
      end
      context 'duplicate email' do
        it 'fail create new user' do
          # Signupページへ
          visit sign_up_path
          # Emailが未入力
          fill_in "Email", with: user.email
          # passwordの入力
          fill_in "Password", with: "password"
          # Password confirmationの入力
          fill_in "Password confirmation", with: "password"
          # SignUpボタンを押す
          click_button "SignUp"

          expect(current_path).to eq users_path
          expect(page).to have_content "Email has already been taken"
        end
      end
    end

    describe 'link to mypage' do
      context 'before login' do
        it 'fail to access mypage' do
          visit user_path(user)
          expect(current_path).to eq login_path
          expect(page).to have_content "Login required"
        end
      end
    end
  end

  describe 'After_login' do
    # user新規をcreate、login処理
    before { login_as(user) }
    describe 'edit user' do
      context 'fill_in correct' do
        it 'success edit user' do
          visit edit_user_path(user)
          # Emailの入力
          fill_in "Email", with: "test@example.com"
          # passwordの入力
          fill_in "Password", with: "password"
          # Password confirmationの入力
          fill_in "Password confirmation", with: "password"
          # SignUpボタンを押す
          click_button "Update"

          expect(current_path).to eq user_path(user)
          expect(page).to have_content "User was successfully updated."
          
        end
      end
      context 'email is not fill in' do
        it 'fail to edit user' do
          visit edit_user_path(user)
          # Emailの入力
          fill_in "Email", with: nil
          # passwordの入力
          fill_in "Password", with: "password"
          # Password confirmationの入力
          fill_in "Password confirmation", with: "password"
          # SignUpボタンを押す
          click_button "Update"

          expect(current_path).to eq user_path(user)
          expect(page).to have_content "Email can't be blank"
        end
      end
      context 'already exsisted email' do
        it 'fail to edit user' do
          another_user = create(:user)
          visit edit_user_path(user)
          # Emailの入力
          fill_in "Email", with: another_user.email
          # passwordの入力
          fill_in "Password", with: "password"
          # Password confirmationの入力
          fill_in "Password confirmation", with: "password"
          # SignUpボタンを押す
          click_button "Update"

          expect(current_path).to eq user_path(user)
          expect(page).to have_content "Email has already been taken"
        end
      end
      context 'access to another users edit page' do
        it '編集ページへのアクセスが失敗する' do
          another_user = create(:user)
          visit edit_user_path(another_user)
          
          expect(page).to have_content "Forbidden access."
        end
      end
    end

    describe 'マイページ' do
      context 'タスクを作成' do
        it '新規作成したタスクが表示される' do
          user.tasks.create(title: 'test_title', status: :todo)
          visit user_path(user)
          expect(page).to have_content('You have 1 task.')
          expect(page).to have_content('test_title')
        end
      end
    end
  end
end
