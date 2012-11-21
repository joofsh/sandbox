require 'mongoid_id_fix'


class Question
  include Mongoid::Document

  field :title
  field :body
  field :answer
end

