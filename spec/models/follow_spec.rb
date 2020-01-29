# frozen_string_literal: true

require 'rails_helper'

describe Follow, type: :model do
  let(:follow) { create(:follow) }

  it { should belong_to(:follower) }
  it { should belong_to(:following) }
end
