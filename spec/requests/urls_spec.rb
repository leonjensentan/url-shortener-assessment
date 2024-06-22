# spec/requests/urls_spec.rb
require 'rails_helper'

RSpec.describe "Urls", type: :request do

  describe "POST /urls" do
    context "with valid attributes" do
      let(:valid_attributes) { attributes_for(:url) }

      #Test that a new URL is created
      it "creates a new URL" do
        expect {
          post urls_path, params: { url: valid_attributes }
        }.to change(Url, :count).by(1)
      end

      #Test that the response redirects to the show page
      it "redirects to the show page" do
        post urls_path, params: { url: valid_attributes }
        expect(response).to redirect_to(url_path(Url.last.short_url))
      end
    end

    context "with invalid attributes" do
      let(:invalid_attributes) { attributes_for(:url, target_url: "invalid_url") }

      #Test that a new URL is not created
      it "does not create a new URL" do
        expect {
          post urls_path, params: { url: invalid_attributes }
        }.not_to change(Url, :count)
      end

    end
  end

  describe "GET /:short_url" do
    let(:url) { create(:url) }

    #Test that the response redirects to the target URL
    it "redirects to the target URL" do
      get "/#{url.short_url}"
      expect(response).to redirect_to(url.target_url)
    end

    #Test that the click count is incremented
    it "increments the click count" do
      expect {
        get "/#{url.short_url}"
      }.to change { url.reload.clicks }.by(1)
    end
  end

end