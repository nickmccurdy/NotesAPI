describe 'Notes' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before :each do
    # post '/', 'name' => 'Example Note', 'body' => 'Hello, world!'
    Note.create id: 0, name: 'Example Note', body: 'Hello, world!'
  end

  after :each do
    Note.delete_all
  end

  let(:note_json) { '{"id":0,"name":"Example Note","body":"Hello, world!"}' }

  describe 'GET /' do
    it 'gets all notes' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq "[#{note_json}]"
    end
  end

  describe 'POST /' do
    it 'creates a note' do
      # response = Net::HTTP.post_form URI('http://localhost:3000/'), 'name' => 'New Note', 'body' => 'This is a new note.'
      begin
        post '/', name: 'New Note', body: 'This is a new note.'
        expect(last_response.status).to be 201
      rescue NoMethodError => message
        p message.exception
        # p message.match(/(0x[0-9a-f]+)/)[0]
        # p ObjectSpace._id2ref(s1.object_id)
      end
    end
  end

  describe 'GET /:id' do
    it 'gets a note' do
      get '/0'
      expect(last_response).to be_ok
      expect(last_response.body).to eq note_json
    end
  end

  describe 'PUT /:id' do
    it 'updates a note' do
      put '/0', name: 'New Note', body: 'This is a new note.'
      expect(last_response.status).to be 201
    end
  end

  describe 'DELETE /:id' do
    it 'deletes a note' do
      delete '/0'
      expect(last_response.status).to be 204
    end
  end
end
