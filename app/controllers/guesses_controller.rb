class GuessesController < ApplicationController

  attr_accessor :game_id

  def show
    @guess = Guess.find(params[:id])
  end

  def new
    @guess = Guess.new
  end

  def create
    @guess = Guess.new(guess_params)

    if @guess.save
      redirect_to @guess
    end
  end

  def guess_params
    params.require(:guess).permit(:body, :game_id)
  end
end
