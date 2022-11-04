class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :text
  has_many :comments
  belongs_to :author, class_name: 'User'
end
