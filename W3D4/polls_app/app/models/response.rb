# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ApplicationRecord
  validates :user_id, :answer_choice_id, presence: true
  validate :not_duplicate_responseif, :author_answer_question



  belongs_to(:answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice
  )
  
  belongs_to(:respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
  )

  has_one :question,
    through: :answer_choice,
    source: :question

  def self.record_response(user, answer_choice)
    Response.create!(user_id: user.id, answer_choice_id: answer_choice.id)
  end


  def respondent_already_answered?
    sibling_responses.exists?(user_id: self.user_id)
  end

  def not_duplicate_response
    errors[:base] << 'Invalid response. User has already answered the question' if respondent_already_answered?
  end

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  
  def author_answer_question
    author = self.question.poll.author
    if author.id == self.user_id
      errors[:base] << "Can't answer your own poll"
    end
  end


  
end
