# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "/Users/aa/Desktop/W3D4/polls_app/app/models/poll.rb"


User.destroy_all
Poll.destroy_all
Question.destroy_all
AnswerChoice.destroy_all
Response.destroy_all

u1 = User.create!(username: "william311")
u2 = User.create!(username: "abc1233233")
u3 = User.create!(username: "max2019")
u4 = User.create!(username: "fatthor")
u5 = User.create!(username: "pikachu")



poll1 = u1.authored_polls.create!(title: "AO3 Practice tips")
poll2 = u2.authored_polls.create!(title: "Good food places")
poll3 = u3.authored_polls.create!(title: "Best water")
poll4 = u4.authored_polls.create!(title: "Best bootcamp")
poll5 = u5.authored_polls.create!(title: "Best TA")


q1 = poll1.questions.create!(text: "how to ace exam?")
q2 = poll1.questions.create!(text: "what is on exam?")
q3 = poll2.questions.create!(text: "whats for lunch?")
q4 = poll3.questions.create!(text: "is chipotle safe to eat?")
q5 = poll4.questions.create!(text: "why does will drink alot of water?")
q6 = poll5.questions.create!(text: "what does best mean?")


answer1 = q1.answer_choices.create!(text: 'study')
answer2 = q1.answer_choices.create!(text: 'do practice test 5 times')
answer3 = q1.answer_choices.create!(text: 'get sleep')

answer4 = q2.answer_choices.create!(text: 'sql')
answer5 = q2.answer_choices.create!(text: 'associations')

answer7 = q3.answer_choices.create!(text: 'sandwhich')
answer8 = q3.answer_choices.create!(text: 'pizza')

answer9 = q4.answer_choices.create!(text: 'yes')
answer10 = q4.answer_choices.create!(text: 'maybe')

answer11 = q5.answer_choices.create!(text: 'thristy')
answer12 = q5.answer_choices.create!(text: 'throat itchy')

answer13 = q6.answer_choices.create!(text: 'idk')
answer14 = q6.answer_choices.create!(text: '?')

Response.record_response(u1, answer11)
Response.record_response(u2, answer7)
Response.record_response(u1, answer2)
Response.record_response(u3, answer10)
Response.record_response(u4, answer8)
Response.record_response(u4, answer9)
Response.record_response(u5, answer11)
Response.record_response(u1, answer2)
Response.record_response(u3, answer3)
Response.record_response(u4, answer2)
Response.record_response(u2, answer11)
Response.record_response(u2, answer5)
Response.record_response(u3, answer5)
Response.record_response(u1, answer4)









