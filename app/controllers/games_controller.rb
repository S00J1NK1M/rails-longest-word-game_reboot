require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('a'..'z').to_a.sample }
  end

  def score
    array_letters = params[:letters].split
    array_word = params[:word].chars
    @english_word = english_word?(params[:word])

    if array_word.all? { |element| array_letters.include?(element) }
      @result = "Good!"
    else
      @result = "Bad"
    end

    @result
  end

  private

  def english_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
