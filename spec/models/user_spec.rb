require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe "validations" do
    context "role" do
      let(:user) { build(:user, role: nil) }

      it "should be invalid without role" do
        expect(user.valid?).to be false
      end

      it "should be valid with role" do
        user.role = :admin

        expect(user.valid?).to be true
      end
    end
  end
  describe "attributes" do
    it "responds to role" do
      expect(user).to respond_to(:role)
    end

    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end

    it "responds to premium?" do
      expect(user).to respond_to(:premium?)
    end

    it "responds to standard?" do
      expect(user). to respond_to(:standard?)
    end
  end

  describe "roles" do
    it "is standard by default" do
      expect(user.role).to eq ("standard")
    end

    context "standard user" do
      it "returns true for #standard?" do
        expect(user.standard?).to be_truthy
      end

      it "returns fale for #admin?" do
        expect(user.admin?).to be_falsey
      end

      it "returns false for #premium?" do
        expect(user.premium?).to be_falsey
      end
    end
    context "premium user" do
      before do
        user.premium!
      end

      it "returns false for #standard?" do
        expect(user.standard?).to be_falsey
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end

      it "returns true for #premium?" do
        expect(user.premium?).to be_truthy
      end
    end

    context "admin user" do
      before do
        user.admin!
      end

      it "returns false for #standard?" do
        expect(user.standard?).to be_falsey
      end

      it "returns false for #premium?" do
        expect(user.premium?).to be_falsey
      end

      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end
    end
  end

  describe "downgrading" do
    context "a premium user" do
      let(:user) { create(:user, role: 'premium') }

      context "with some private wikis" do
        before do
          5.times do
            create(:wiki, user: user, private: true)
          end
        end

        it "makes their wikis public" do
          user.downgrade!
          expect(user.wikis.where(private: true)).to be_empty
        end
      end
    end
  end
end
