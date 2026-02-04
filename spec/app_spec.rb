require 'rspec'
require 'rack/test'
require_relative '../app' # Adjust the path based on your file structure

RSpec.describe 'Vulnerable Ruby App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'Edge cases and bugs' do
  it 'handles empty search input' do
    post '/search', name: ''
    expect(last_response).to be_ok
  end

  it 'handles nil parameter gracefully' do
    post '/search'
    expect(last_response).to be_ok
  end
end

  describe 'GET /' do
    it 'renders the index page' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to include('Welcome') # Adjust based on your HTML content
    end
  end

  describe 'POST /search' do
    context 'with valid input' do
      it 'returns search results' do
        post '/search', name: 'John'
        expect(last_response).to be_ok
        expect(last_response.body).to include('Results for John') # Adjust based on your view
      end
    end

    context 'with unsanitized input (SQL Injection)' do
      it 'executes the query with injection' do
        post '/search', name: "' OR '1'='1"
        expect(last_response).to be_ok
        expect(last_response.body).to include('Some unexpected results') # Modify based on actual output
      end
    end
  end

  describe 'POST /find_user' do
    it 'returns user details' do
      post '/find_user', name: 'Jane'
      expect(last_response).to be_ok
      expect(last_response.body).to include('Results for Jane') # Adjust based on your view
    end
  end

  describe 'POST /lookup_user' do
    it 'returns search results for lookup' do
      post '/lookup_user', name: 'Doe'
      expect(last_response).to be_ok
      expect(last_response.body).to include('Results for Doe') # Adjust based on your view
    end
  end

  describe 'POST /get_user' do
    it 'returns search results for get_user' do
      post '/get_user', name: 'Smith'
      expect(last_response).to be_ok
      expect(last_response.body).to include('Results for Smith') # Adjust based on your view
    end
  end

  describe 'Potential XSS vulnerability' do
    it 'renders user message safely' do
      get '/', message: '<script>alert("XSS")</script>'
      expect(last_response.body).not_to include('<script>alert("XSS")</script>')
      expect(last_response.body).to include('alert("XSS")') # Expect the script to be escaped
    end
  end
end
