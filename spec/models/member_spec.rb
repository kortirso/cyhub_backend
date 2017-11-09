RSpec.describe Member, type: :model do
    it { should belong_to :user }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }

    it 'should be valid' do
        member = create :member

        expect(member).to be_valid
    end
end
