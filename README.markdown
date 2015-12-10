# Donor Tools API Consumer (Rails 3)

This example uses Rails 3. For a Rails 2.x, see our [Rails 2 example app](https://github.com/mysmallidea/Donor-Tools-Consumer)

## Welcome to the Donor Tools Consumer example application. 

Before you get started, please have a look at our API documentation in our [User Guide](http://donortools.com/userguide/api) and on our [knowledge base](http://support.donortools.com/forums/47417/entries).

Please also join our [Donor Tools API group on Google Groups](http://groups.google.com/group/donor-tools-api)

## License

Donor Tools API is a beta product and is provided on a best-effort basis. Use of the Donor Tools API is subject to the API License Agreement: www.donortools.com/about/api_license

## Authentication

Donor Tools' API uses HTTP Basic authentication. You'll need to sign up for a Donor Tools account (if you don't have one already.)

## User Account

You'll need to sign up for a Donor Tools account in order to use the API. If you don't already have a Donor Tools account, you can get one by going to www.donortools.com/signup.

Donor Tools' auditing feature logs each and every action for your account. Thus, if you provide your own username and password for the API (not recommended), all actions through the API will appear as being committed by you. We recommend creating a separate API user to provide finer grained reporting detail. This technique also helps protect your personal authentication parameters, as you can provide a different username and password. 

## Pagination

Donor Tools returns all results with pagination. You can use the [pox_paginate](https://github.com/c42/pox_paginate) gem to easily parse and paginate result sets. [See this post for more info](http://groups.google.com/group/donor-tools-api/browse_thread/thread/8f9deb2a7ff12253).


## Example Usage

This example app uses ActiveResource to communicate with the Donor Tools API. Here's an example of the donation.rb file: 

    class Donation < ActiveResource::Base
      self.site = "http://youraccount.donortools.com"
      self.user = "your_donor_tools_username"
      self.password = "your_password"
    end

To get a list of donations, you'd open up ./script/console, and type: 

    Donation.all

### Finding a specific donation

    Donation.find(12345)

### Updating a donation

    d = Donation.find(12345)
    d.splits.first.amount_in_cents = 5001
    d.save
  
### Creating a donation

    persona = Persona.first
    fund = Fund.first
    source = Source.find(:first)
    donation = Donation.new(
      :persona_id => persona.id,
      :splits => [{:amount_in_cents => 1001, :fund_id => fund.id}],
      :donation_type_id => 1,
      :source_id => source.id
    )
    donation.save

### Finding a donor

    persona = Persona.find(12345)
    
### Searching for a Donor

To search across all fields, use the `search` param with the `find` method: 

    Persona.find(:all, :params => {:search => "henley.tim@gmail.com"})

... Or use the cleaner `where` syntax in Rails 4: 

    Persona.where(:search => "henley.tim@gmail.com")

  
### Creating a donor

Donor Tools uses Rails' concept of nested attributes (http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html). 
  
    persona = Persona.new(
      :names => [
        {
          :first_name => "John", 
          :last_name => "Rockefeller"
        }
      ], 
      :addresses => [
        {
          :street_address => "123 Fourth St.", 
          :city => "Miami", 
          :state => "FL",
          :postal_code => "12345",
          :country => "US"
        }
      ],
      :phone_numbers => [
        {
          :phone_number => "555-555-1234"
        }
      ],
      :email_addresses => [
        {
          :email_address => "test@example.com"
        }
      ]
    )
