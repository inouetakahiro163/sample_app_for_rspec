require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'is valid with all attributes' do
    task = FactoryBot.create(:task)
    expect(task).to be_valid
  end
end
