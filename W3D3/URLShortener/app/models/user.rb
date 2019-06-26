class User < ApplicationRecord                          # defines a new model object (called User) that will inherit a bunch of methods
  validates :email, uniqueness: true, presence: true    # means that someone can't create user account without an email? and no two accounts w/ same email

  has_many :shortened_urls,   # :shortened_urls is the name of the method!, returns array of all shortened_url objs that match with user
    primary_key: :id,
    foreign_key: 

end