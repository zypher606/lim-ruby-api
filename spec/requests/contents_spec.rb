require 'rails_helper'

RSpec.describe 'Contents API' do
  # Initialize the test data
  let!(:webpage) { create(:webpage) }
  let!(:contents) { create_list(:content, 20, webpage_id: webpage.id) }
  let(:webpage_id) { webpage.id }
  let(:id) { contents.first.id }

  # Test suite for GET /webpages/:webpage_id/contents
  describe 'GET /webpages/:webpage_id/contents' do
    before { get "/webpages/#{webpage_id}/contents" }

    context 'when webpage exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all webpage contents' do
        expect(json.size).to eq(20)
      end
    end

    context 'when webpage does not exist' do
      let(:webpage_id) { 0 }

    #   it 'returns status code 404' do
    #     expect(response).to have_http_status(404)
    #   end

    #   it 'returns a not found message' do
    #     expect(response.body).to match(/Couldn't find webpage/)
    #   end
    end
  end

  # Test suite for GET /webpages/:webpage_id/contents/:id
  describe 'GET /webpages/:webpage_id/contents/:id' do
    before { get "/webpages/#{webpage_id}/contents/#{id}" }

    context 'when webpage content exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the content' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when webpage content does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find content/)
      end
    end
  end

  # Test suite for PUT /webpages/:webpage_id/contents
  describe 'POST /webpages/:webpage_id/contents' do
    let(:valid_attributes) { { content_type: 'h1', content_value: 'Hello World' } }

    context 'when request attributes are valid' do
      before { post "/webpages/#{webpage_id}/contents", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/webpages/#{webpage_id}/contents", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Content Type can't be blank/)
      end
    end
  end

  # Test suite for PUT /webpages/:webpage_id/contents/:id
  describe 'PUT /webpages/:webpage_id/contents/:id' do
    let(:valid_attributes) { { content_type: 'h3' } }

    before { put "/webpages/#{webpage_id}/contents/#{id}", params: valid_attributes }

    context 'when content exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the content' do
        updated_content = Content.find(id)
        expect(updated_content.content_type).to match(/h3/)
      end
    end

    context 'when the content does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find content/)
      end
    end
  end

  # Test suite for DELETE /webpages/:id
  describe 'DELETE /webpages/:id' do
    before { delete "/webpages/#{webpage_id}/contents/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
