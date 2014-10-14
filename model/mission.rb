require 'mongoid'

class Mission
  include Mongoid::Document

  field :title, type: String
  field :current, type: Integer
  field :total, type: Integer
  field :completed, type: Boolean
  field :category, type: String
  field :type, type: String
  field :description, type: String
  field :createdAt, type: DateTime
end