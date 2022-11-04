class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :photo, :email
end
