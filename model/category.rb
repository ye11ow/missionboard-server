require 'mongoid'

class Category
  include Mongoid::Document

  field :title, type: String
  field :filter, type: String
  field :orderby, type: String
  field :order, type: Integer
end