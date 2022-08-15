class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    letter = ('A'..'Z').to_a
    @letters = []
    (1..10).to_a.each do
      @letters << letter[rand(0..25)]
    end
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params["attempt"]}"
    result = JSON.parse(URI.open(url).read)
    if result["found"] == false || in_the_grid(params["attempt"], params["grid"]) == false
      @score = 0
      @message = "Your word is not an english word or it's not in the grid"
    elsif in_the_grid(params["attempt"], params["grid"]) == true
      @score = result["length"]
      @message = "Well done!"
    end

  end

  def in_the_grid(try, grid)
    verif = 0
    (1..10).to_a.each do |number|
      try.upcase.include?(grid[(number - 1)]) ? verif += 1 : verif += 0
    end
    if verif >= try.length
      true
    else
      false
    end
  end
end
