require 'rails_helper'

RSpec.describe CollaborationsController, type: :controller do
  describe "Create" do
    it "creates a collaboration between the specified user and wiki" do
      user = create(:user)
      wiki = create(:wiki)
      post :create, params: {wiki_id: wiki.id, user_id: user.id}
      expect(Collaboration.find_by(user_id: user.id, wiki_id: wiki.id)).to_not be_nil
    end
  end
  describe "Delete" do
    it "destroys a collaboration between the specified user and wiki" do
      user = create(:user)
      wiki = create(:wiki)
      delete :delete, params: {wiki_id: wiki.id, user_id: user.id}
      expect(Collaboration.find_by(user_id: user.id, wiki_id: wiki_id)).to_be nil
    end
  end
end
