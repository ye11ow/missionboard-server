require 'mongoid'

class Category
  include Mongoid::Document

  field :title, type: String
  field :filter, type: String
  field :order, type: Integer
  embeds_one :orderby

end

class Orderby
  include Mongoid::Document

  field :by, type: String
  field :type, type: String

  embedded_in :category
end