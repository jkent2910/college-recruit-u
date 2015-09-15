require 'rails_helper'

RSpec.describe "rack-redirect", type: :request do
  def app
    @app ||= Rack::Builder.new do
      use CRU::RackRedirect
      run lambda { |env| [200, { 'Content-Type' => 'text/plain' }, ['Hello College Recruit U!'] ] }
    end
  end

  before do
    @controller = ApplicationController.new
  end

  it 'displays the CRU site when the server is www.collegerecruitu.com' do
    get '/', {}, {'SERVER_NAME' => 'www.collegerecruitu.com'}
    expect(response.body).to match /Hello College Recruit U!/
  end

  it 'redirects to www.collegerecruitu.com when the server is collegerecruitu.com' do
    get '/', {}, {'SERVER_NAME' => 'collegerecruitu.com'}
    expect(response.status).to eql 302
    expect(response['Location']).to eql 'https://www.collegerecruitu.com/'
  end

  it 'redirects to www.collegerecruitu.com when the server is ec2-52-6-207-202.compute-1.amazonaws.com' do
    get '/', {}, {'SERVER_NAME' => 'ec2-52-6-207-202.compute-1.amazonaws.com'}
    expect(response.status).to eql 302
    expect(response['Location']).to eql 'https://www.collegerecruitu.com/'
  end
end
