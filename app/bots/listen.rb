require 'facebook/messenger'

include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :postback do |postback|
  Postback.new(postback).reply
end

Bot.on :message do |message|
  message.type
  # extract club from message.text
  club = InputParser.new(message.text).club
  # Fetch API to get next game
  next_game = FootballData.new(club: club).next_game

  message.reply(text: next_game)
end