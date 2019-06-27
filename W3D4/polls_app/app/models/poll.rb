# == Schema Information
#
# Table name: polls
#
#  id        :bigint           not null, primary key
#  title     :string           not null
#  auther_id :integer
#

class Poll < ApplicationRecord
  validates :title, :author_id, presence: true


  belongs_to(:author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User
  )
  
  has_many :questions,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Question
end
