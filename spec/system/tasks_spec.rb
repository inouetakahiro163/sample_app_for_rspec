require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:task){ create(:task) }
  describe 'ログイン前' do
    describe 'タスクの新規作成' do
      context 'ログインしていない場合' do
        it 'タスクの新規作成ができない' do
          visit new_task_path
          expect(page).to have_content('Login required')
          expect(current_path).to eq login_path
        end
      end
    end

    describe 'タスクの編集' do
      context 'ログインしていない場合' do
        it 'タスクの編集ができない' do
          visit edit_task_path(task)
          expect(page).to have_content('Login required')
          expect(current_path).to eq login_path
        end
      end
    end

    describe 'マイページへの遷移' do
      context 'ログインしていない場合' do
        it 'マイページへの遷移ができない'
      end
    end
  end

  describe 'ログイン後' do
    describe 'タスクの新規作成' do
      context 'ログインした場合' do
        it 'タスクの新規作成ができる'
      end
    end

    describe 'タスクの編集' do
      context 'ログインした場合' do
        it 'タスクの編集ができる'
      end
    end

    describe 'タスクの削除' do
      context 'ログインした場合' do
        it 'タスクの削除ができる'
      end
    end
  end
end
