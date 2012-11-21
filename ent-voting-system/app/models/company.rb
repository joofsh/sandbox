class Company
  include Mongoid::Document
  field :name
  field :industry
  field :size
  field :address
  field :website
end
