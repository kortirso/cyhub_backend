RSpec.describe User, type: :model do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_inclusion_of(:role).in_array(%w[user admin]) }

    it 'should be valid' do
        user = create :user

        expect(user).to be_valid
    end

    it 'should be valid with email and password' do
        user = User.new email: 'example@gmail.com', password: 'password'

        expect(user).to be_valid
    end

    it 'should be invalid without email' do
        user = User.new(email: nil)
        user.valid?

        expect(user.errors[:email]).to include("can't be blank")
    end

    it 'should be invalid without password' do
        user = User.new(password: nil)
        user.valid?

        expect(user.errors[:password]).to include("can't be blank")
    end

    it 'should be invalid with a duplicate email' do
        User.create(email: 'example@gmail.com', password: 'password')
        user = User.new(email: 'example@gmail.com', password: 'password')
        user.valid?

        expect(user.errors[:email]).to include('has already been taken')
    end
end
