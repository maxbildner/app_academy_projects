 class ShortenedUrl < ApplicationRecord
  validates :short_url, uniqueness: true
  validates :short_url, :long_url, :user_id, presence: true

  # class method that generates a random 16byte string
  def self.random_code
    rand_str = SecureRandom.urlsafe_base64        # what is this secure random obj? returns 22 char long str?
    
    # keep making random strs until we get a unique random str that doesn't exist in shortened_urls database as a short_url
    until !ShortenedUrl.exists?(:short_url => rand_str)
      rand_str = rand_str = SecureRandom.urlsafe_base64
    end

    rand_str
  end

  # factory method, creates a new ShortenedUrl object
  # why factory method?
  def self.create_new_shortened_url(user_obj, long_url)   # takes in user obj, and string
    short_url = ShortenedUrl.random_code
    user_id = user_obj.user_id
    ShortenedUrl.create!({short_url: short_url, long_url: long_url, user_id: user_id})    # will datetime be automatically passed in?/created?
  end

  belongs_to :users,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :user

 end