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

  it 'responds to POST /quotes/price_by_vehicle with JSON response and a variable price depending on the vehicle' do
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

  it 'responds to POST /quotes/vehicle_by_price_limit with JSON response and select the appropriate vehicle if it is not specified' do
    request =  {
     quote: {
       pickup_postcode:   'SW1A 1AA',
       delivery_postcode: 'EC2A 3LT'
     }
    }.to_json

    post '/quotes/vehicle_by_price_limit', request
    expect(last_response).to be_ok

    quote = JSON.parse(last_response.body)['quote']

    expect(quote['pickup_postcode']).to eql "SW1A 1AA"
    expect(quote['delivery_postcode']).to eql "EC2A 3LT"
    expect(quote['vehicle']).to eq "motorbike"
    expect(quote['price']).to eql 780.85
  end

  it 'responds to POST /quotes/vehicle_by_price_limit with JSON response if the specifieded vehicle respects limit price ' do
    request =  {
     quote: {
       pickup_postcode:   'SW1A 1AA',
       delivery_postcode: 'EC2A 3LT',
       vehicle: 'small_van'
     }
    }.to_json

    post '/quotes/vehicle_by_price_limit', request
    expect(last_response).to be_ok

    quote = JSON.parse(last_response.body)['quote']

    expect(quote['pickup_postcode']).to eql "SW1A 1AA"
    expect(quote['delivery_postcode']).to eql "EC2A 3LT"
    expect(quote['vehicle']).to eq "small_van"
    expect(quote['price']).to eql 882.7
  end

  it 'responds to POST /quotes/vehicle_by_price_limit with JSON response if specified vehicle does NOT respect limit price ' do
    request =  {
     quote: {
       pickup_postcode:   'SW1A 1AA',
       delivery_postcode: 'EC2A 3LT',
       vehicle: 'bicycle'
     }
    }.to_json

    post '/quotes/vehicle_by_price_limit', request
    expect(last_response).to be_ok

    quote = JSON.parse(last_response.body)['quote']

    expect(quote['pickup_postcode']).to eql "SW1A 1AA"
    expect(quote['delivery_postcode']).to eql "EC2A 3LT"
    expect(quote['vehicle']).to eq "motorbike"
    expect(quote['price']).to eql 780.85
  end
end

describe 'Vechicle by volumetrics Service' do


  it 'responds to POST /quotes/vehicle_by_volumetrics with JSON response and required vehicle and price' do
    request = {
              quote: {
                pickup_postcode:   'SW1A 1AA',
                delivery_postcode: 'EC2A 3LT',
                products: [
                  {
                    weight: 10,
                    width: 5,
                    height: 10,
                    length: 5
                  },
                  {
                    weight: 5,
                    width: 50,
                    height: 50,
                    length: 50
                  },
                ]
              }
            }.to_json

    post '/quotes/vehicle_by_volumetrics', request
    expect(last_response).to be_ok

    quote = JSON.parse(last_response.body)['quote']

    expect(quote['pickup_postcode']).to eql "SW1A 1AA"
    expect(quote['delivery_postcode']).to eql "EC2A 3LT"
    expect(quote['vehicle']).to eq "parcel_car"
    expect(quote['price']).to eql 814.8
  end

  it 'responds to POST /quotes to calculate the required vehicle and price based on distance and volumetrics of the products' do
    request = {
              quote: {
                pickup_postcode:   'SW1A 1AA',
                delivery_postcode: 'EC2A 3LT',
                products: [
                  {
                    weight: 2,
                    width: 5,
                    height: 10,
                    length: 5
                  }
                ]
              }
            }.to_json

    post '/quotes', request
    expect(last_response).to be_ok

    quote = JSON.parse(last_response.body)['quote']

    expect(quote['pickup_postcode']).to eql "SW1A 1AA"
    expect(quote['delivery_postcode']).to eql "EC2A 3LT"
    expect(quote['vehicle']).to eq "motorbike"
    expect(quote['price']).to eql 780.85
  end
end
