require 'rails_helper'

RSpec.describe WikiPolicy do
  describe '#edit?' do
    context "standard user" do
      let(:current_user) { create(:user, role: :standard) }

      context "wiki creator" do
        context "when the wiki is public" do
          let(:wiki) { create(:wiki, user: current_user, private: false) }

          it { expect(WikiPolicy.new(current_user, wiki).edit?).to eq(true) }
        end

        context "private wiki" do
          let(:wiki) { create(:wiki, user: current_user, private: true) }

          it { expect(WikiPolicy.new(current_user, wiki).edit?).to eq(true) }
        end
      end

      context "non-wiki creator" do
        context "public wiki" do
          let(:wiki) { create(:wiki, private: false) }

          it { expect(WikiPolicy.new(current_user, wiki).edit?).to eq(true) }
        end

        context "private wiki" do
          let(:wiki) { create(:wiki, private: true) }

          it { expect(WikiPolicy.new(current_user, wiki).edit?).to eq(false) }
        end
      end
    end

    context "premium user" do
      let(:current_user) { create(:user, role: :premium) }

      context "non-wiki creator" do
        context "when the wiki is public" do
          let(:wiki) { create(:wiki, private: false) }

          it { expect(WikiPolicy.new(current_user, wiki).edit?).to eq(true) }
        end

        context "private wiki" do
          let(:wiki) { create(:wiki, private: true) }

          it { expect(WikiPolicy.new(current_user, wiki).edit?).to eq(false) }
        end
      end
    end

    context "admin user" do
      let(:current_user) { create(:user, role: :admin) }

      context "non-wiki creator" do
        context "private wiki" do
          let(:wiki) { create(:wiki, private: true) }

          it { expect(WikiPolicy.new(current_user, wiki).edit?).to eq(true) }
        end
      end
    end
  end

  describe "#new?" do
    it "when the user is not logged in, returns false" do
      current_user = nil
      wiki = Wiki.new
      expect(WikiPolicy.new(current_user, wiki).new?).to eq(false)
    end

    it "when the user is logged in, returns false" do
      current_user = create(:user)
      wiki = Wiki.new
      expect(WikiPolicy.new(current_user, wiki).new?).to eq(true)
    end
  end

  describe "#create?" do
    context "when the user is standard" do
      let(:current_user) { create(:user, role: :standard) }

      it "they can create a public wiki" do
        wiki = build(:wiki, private: false)
        expect(WikiPolicy.new(current_user, wiki).create?).to eq(true)
      end

      it "they can't create a private wiki" do
        wiki = build(:wiki, private: true)
        expect(WikiPolicy.new(current_user, wiki).create?).to eq(false)
      end
    end

    context "premium user" do
      it "when the user is premium, they can create a private wiki" do
        current_user = create(:user, role: :premium)
        wiki = build(:wiki, private: true)
        expect(WikiPolicy.new(current_user, wiki).create?).to eq(true)
      end
    end
  end

  describe "#show?" do
    context "premium user" do
      let(:current_user) { create(:user, role: :premium) }
      it "should not be allowed to view another users private wiki" do
        wiki = build(:wiki, private: true)
        expect(WikiPolicy.new(current_user, wiki).show?).to eq(false)
      end
    end
  end
end
