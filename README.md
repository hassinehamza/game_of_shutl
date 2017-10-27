# Game of Shutl

This is a RESTful service endpoint that takes a few details and works out the price for a delivery.

## NOTES To the test reviewer:

__This is my first ruby program__ .It was really an opportunity to learn ruby and sinatra.

During the test, I choosed the MVC design pattern. and I tried __to do my best__ to respect a standard code quality.

For version controlling, I used git . So for every feature , I create a new branch . Once I finihed to implement the feature, I merged the branch with master. At the end , I pushed the master.

For each feature , we created service that responds to a POST url

* Variable Prices By Distance : /quotes/basic_price
* Simple Variable Prices By Vehicle : /quotes/price_by_vehicle
* Vehicle Price Limits: /quotes/vehicle_by_price_limit
* Complex Volumetrics: /quotes/vehicle_by_volumetrics

and at the end I created a created a  __completed service that takes into consideration all the features__

* all features : _/quotes_
<p>

</p>
The purpose of that :

  - __more flexiblilty API :__  we give the opportunity to the user to consume the service he wants according to the feature he wishes to take into consideration
  - __track code evolution :__
I keeped all the services ( inside my code ) to give an idea to the reviewer how my code evolves from one feature to another. if we are looking only for the completed service , we could keep only the service that responds to a POST to '/quotes'.

I remain available for further justifications.

## TRY IT

### Run the Application

Clone the Project

`git clone https://github.com/hassinehamza/game_of_shutl.git`

Move inside the folder

`cd game_of_shutl`

Install dependencies

`bundle install`

Run it

`bundle exec rackup`

Your Application will be runned on the default port = 9292

Enjoy it !

### Run tests

`bundle exec rspec spec`


## Features


### Variable Prices By Distance

Build a service that responds to a POST to '/quotes/basic_price', with the following request structure:

      {
        "quote": {
          "pickup_postcode":   "SW1A 1AA",
          "delivery_postcode": "EC2A 3LT",
        }
      }

and responds with the following variable price:

      {
        "quote": {
          "pickup_postcode":   "SW1A 1AA",
          "delivery_postcode": "EC2A 3LT",
          "price":             variable_price
        }
      }

The price we charge depends on the distance between two postcodes. We won't implement postcode geocoding here, so instead let's use a basic formula for working out the price for a quote between two postcodes. The process is to take the base-36 integer of each postcode, substract the delivery postcode from the pickup postcode and then divide by 1000. If the result is negative, turn it into a positive.

Hint: in ruby, this would be:

    ("SW1A 1AA".to_i(36) - "EC2A 3LT".to_i(36)) / 1000



### Simple Variable Prices By Vehicle

Our price changes based upon the vehicle. Each type of vehicle has an appropriate markup:

* bicycle: 10%
* motorbike: 15%
* parcel_car: 20%
* small_van: 30%
* large_van: 40%

Build a service that responds to a POST to '/quotes/price_by_vehicle', with the following request structure:

      {
        "quote": {
          "pickup_postcode":   "SW1A 1AA",
          "delivery_postcode": "EC2A 3LT",
          "vehicle": "bicycle"
        }
      }

and responds with the following variable price:

      {
        "quote": {
          "pickup_postcode":   "SW1A 1AA",
          "delivery_postcode": "EC2A 3LT",
          "vehicle":           "bicycle",
          "price":             basic_price + vehicle_markup
        }
      }

### Vehicle Price Limits

Each vehicle has a limit in the distance it can travel, which is reflected in the price. So, each vehicle has an upper price limit, after which the next vehicle is selected:

* bicycle: 500
* motorbike: 750
* parcel_car: 1000
* small_van: 1500
* large_van: no limit

Build a service that responds to a POST to '/quotes/vehicle_by_price_limit'', with the following request structure :

      {
        "quote": {
          "pickup_postcode":   "SW1A 1AA",
          "delivery_postcode": "EC2A 3LT",
        }
      }

OR with the following request structure :

      {
        "quote": {
          "pickup_postcode":   "SW1A 1AA",
          "delivery_postcode": "EC2A 3LT",
          "vehicle": "bicycle"
        }
      }



The vehicle attribute can be specified or NOT in the request.
- If it is Not Specified , the response specifies the smallest appropriate vehicle and the price
- If it is specified :
    - if the price limit of provided vehicle is greater or equal than the price , the response specifies the _same_ vehicle and the price
    - if the price limit of provided vehicle is less than the price , the response specifies the smallest appropriate vehicle and the price

### Volumetrics

Another feature of Shutl is that if the vehicle is not specifed, we calculate what vehicle is required based upon the volumetrics (weights and dimensions) of the product(s).

__NB__: In this feature , the service just calculate the required vehicle ( and price ) based _ONLY_ on volumetrics. It doesn't take into consideration the limit distance of the vehicle.

Build a service that responds to a POST to '/quotes/vehicle_by_volumetrics', with the following request structure :

    {
      "quote": {
        "pickup_postcode":   "SW1A 1AA",
        "delivery_postcode": "EC2A 3LT",
        "products" : [
          {
            weight: 10,
            width: 50,
            height: 50,
            length: 50
          }
        ]
      }
    }

and responds with appropriate vehicle and price .


Weight is specified in kilograms, dimensions in centimetres.

The service should then calculate the smallest possible vehicle which could be used for this job. The vehicle capacities are:

* bicycle: Weight 3kg, Capacity: L30 x W25 x H10 cm
* motorbike: Weight: 6kg Max. Capacity: L35 x W25 x H25 cm
* parcel_car: Weight: 50kg Max. Capacity: L100 x W100 x H75 cm
* small_van: Weight: 400kg Max. Capacity: L133 x W133 x H133 cm
* large_van: unlimited


## A Completed Service :

Build a completed service that takes into consideration __all__ the previous features and responds to a POST to '/quotes', with the following request structure:

          {
            "quote": {
              "pickup_postcode":   "SW1A 1AA",
              "delivery_postcode": "EC2A 3LT",
              "products" : [
                {
                  weight: 10,
                  width: 50,
                  height: 50,
                  length: 50
                }
              ]
            }
          }


 and responds with the smallest required vehicle and price:

           {
             "quote": {
               "pickup_postcode":   "SW1A 1AA",
               "delivery_postcode": "EC2A 3LT",
               "vehicle": "parcel_car",
               "price": 814.8
             }
           }


## TODO : Icebox

### Vehicle Becomes Vehicle_Id

A change in requirements has come up - that vehicle is renamed vehicle_id.

In order to not break existing clients, you and the team have decided to add a header which will allow the client to specify the version of the API they want to use. Update your service to allow a header to be passed in, and to accept/show different the correct attribute depending on the version.
