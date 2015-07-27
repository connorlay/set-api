require 'rails_helper'

RSpec.describe Membership, type: :model do

  subject { create :membership }

  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :lobby }

  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:lobby_id) }

  it { is_expected.to have_db_index :user_id }
  it { is_expected.to have_db_index :lobby_id }
  it { is_expected.to have_db_index [ :user_id, :lobby_id ] }

end
