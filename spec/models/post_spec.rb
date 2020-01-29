# frozen_string_literal: true

require 'rails_helper'

describe Post, type: :model do
  let(:post) { create(:post) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:user) }
  it { should have_many(:likes) }
  it { should have_many(:comments) }
end
