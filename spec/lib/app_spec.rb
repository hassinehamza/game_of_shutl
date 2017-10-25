require 'spec_helper'

describe 'Basic Service' do
  let(:request) do
    {
      quote: {
        pickup_postcode:   'SW1A 1AA',
        delivery_postcode: 'EC2A 3LT'
      }
    }.to_json
  end

  it 'responds to POST /quotes/basic with a JSON response and a static price' do
    post '/quotes/basic', request
    expect(last_response).to be_ok

    quote = JSON.parse(last_response.body)['quote']

    expect(quote['pickup_postcode']).to eql "SW1A 1AA"
    expect(quote['delivery_postcode']).to eql "EC2A 3LT"
    expect(quote['price']).to eql 679
  end
end

describe 'Variable Price by Vehicle Service' do
  let(:request) do
    {
      quote: {
        pickup_postcode:   'SW1A 1AA',
        delivery_postcode: 'EC2A 3LT',
        vehicle: 'motorbike'
      }
    }.to_json
  end

  it 'responds to POST /quotes/vehicle with JSON response and a variable price depending to the vehicle' do
    post '/quotes/vehicle', request
    expect(last_response).to be_ok

    quote = JSON.parse(last_response.body)['quote']

    expect(quote['pickup_postcode']).to eql "SW1A 1AA"
    expect(quote['delivery_postcode']).to eql "EC2A 3LT"
    expect(quote['vehicle']).to eq "motorbike"
    expect(quote['price']).to eql 780.85
  end
end
