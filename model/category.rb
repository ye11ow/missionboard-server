require 'mongoid'

class Category
  include Mongoid::Document
  field :_id, type: String
  field :title, type: String
  field :order, type: Integer
  field :system, type: Boolean
  embeds_one :orderby

end

class Orderby
  include Mongoid::Document

  field :by, type: String
  field :type, type: String

  embedded_in :category
end