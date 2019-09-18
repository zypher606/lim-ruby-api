require 'rails_helper'

RSpec.describe 'Webpages API', type: :request do
  # initialize test data 
  let!(:webpages) { create_list(:webpage, 10) }
  let(:webpage_id) { webpages.first.id }

  # Test suite for GET /webpages
  describe 'GET /webpages' do
    # make HTTP get request before each example
    before { get '/webpages' }

    it 'returns webpages' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /webpages/:id
  describe 'GET /webpages/:id' do
    before { get "/webpages/#{webpage_id}" }

    context 'when the record exists' do
      it 'returns the webpage' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(webpage_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:webpage_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Webpage/)
      end
    end
  end

  # Test suite for POST /webpages
  describe 'POST /webpages' do
    # valid payload
    let(:valid_attributes) { { url: 'http://example.com'} }

    context 'when the request is valid' do
      before { post '/webpages', params: valid_attributes }

      it 'creates a webpage' do
        expect(json['url']).to eq('http://example.com')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/webpages', params: { url: 'http://example.com' } }

    #   it 'returns status code 422' do
    #     expect(response).to have_http_status(422)
    #   end

    #   it 'returns a validation failure message' do
    #     expect(response.body)
    #       .to match(/Validation failed: URL can't be blank/)
    #   end
    end
  end

  # Test suite for PUT /webpages/:id
  describe 'PUT /webpages/:id' do
    let(:valid_attributes) { { url: 'http://facebook.com' } }

    context 'when the record exists' do
      before { put "/webpages/#{webpage_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /webpages/:id
  describe 'DELETE /webpages/:id' do
    before { delete "/webpages/#{webpage_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end