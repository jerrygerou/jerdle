class GuessesController < ApplicationController

  attr_accessor :game_id

  def show
    @guess = Guess.find(params[:id])
  end

  def new
    @guess = Guess.new
  end

  def create
    @game = Game.find(guess_params[:game_id])
    @guess = Guess.new(guess_params)

    if @guess.save
      redirect_to game_path(@guess.game), notice: "Successfully added a new guess"
    else
      redirect_to game_path(@guess.game), notice: "Something went wrong" + "#{@guess.errors.messages}"
    end
  end

  def guess_params
    params.require(:guess).permit(:body, :game_id)
  end
end