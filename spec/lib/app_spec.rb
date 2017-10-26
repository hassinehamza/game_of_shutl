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

  it 'responds to POST /quotes/basic_price with a JSON response and a static price' do
    post '/quotes/basic_price', request
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

  it 'responds to POST /quotes/price_by_vehicle with JSON response and a variable price depending to the vehicle' do
    post '/quotes/price_by_vehicle', request
    expect(last_response).to be_ok

    quote = JSON.parse(last_response.body)['quote']

    expect(quote['pickup_postcode']).to eql "SW1A 1AA"
    expect(quote['delivery_postcode']).to eql "EC2A 3LT"
    expect(quote['vehicle']).to eq "motorbike"
    expect(quote['price']).to eql 780.85
  end
end

describe 'Vehicle Price Limits Service' do

  it 'responds to POST /quotes/vehicle_by_price with JSON response and select the appropriate vehicle if it is not provided' do
    request =  {
     quote: {
       pickup_postcode:   'SW1A 1AA',
       delivery_postcode: 'EC2A 3LT'
     }
    }.to_json

    puts request
    post '/quotes/vehicle_by_price', request
    puts last_response
    expect(last_response).to be_ok

    quote = JSON.parse(last_response.body)['quote']

    expect(quote['pickup_postcode']).to eql "SW1A 1AA"
    expect(quote['delivery_postcode']).to eql "EC2A 3LT"
    expect(quote['vehicle']).to eq "motorbike"
    expect(quote['price']).to eql 780.85
  end

  it 'responds to POST /quotes/vehicle_by_price with JSON response if provided vehicle respects limit price ' do
    request =  {
     quote: {
       pickup_postcode:   'SW1A 1AA',
       delivery_postcode: 'EC2A 3LT',
       vehicle: 'small_van'
     }
    }.to_json

    puts request
    post '/quotes/vehicle_by_price', request
    puts last_response
    expect(last_response).to be_ok

    quote = JSON.parse(last_response.body)['quote']

    expect(quote['pickup_postcode']).to eql "SW1A 1AA"
    expect(quote['delivery_postcode']).to eql "EC2A 3LT"
    expect(quote['vehicle']).to eq "small_van"
    expect(quote['price']).to eql 882.7
  end

  it 'responds to POST /quotes/vehicle_by_price with JSON response if provided vehicle does NOT respect limit price ' do
    request =  {
     quote: {
       pickup_postcode:   'SW1A 1AA',
       delivery_postcode: 'EC2A 3LT',
       vehicle: 'bicycle'
     }
    }.to_json

    puts request
    post '/quotes/vehicle_by_price', request
    puts last_response
    expect(last_response).to be_ok

    quote = JSON.parse(last_response.body)['quote']

    expect(quote['pickup_postcode']).to eql "SW1A 1AA"
    expect(quote['delivery_postcode']).to eql "EC2A 3LT"
    expect(quote['vehicle']).to eq "motorbike"
    expect(quote['price']).to eql 780.85
  end


end
