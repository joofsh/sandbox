class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  embeds_one :phone_number
  attr_accessible :name, :email, :phone_number
end

class PhoneNumber
  include Mongoid::Document
  field :cell, type: String, default: ''
  field :home, type: String, default: ''
  embedded_in :user
  attr_accessible :cell, :home
end
