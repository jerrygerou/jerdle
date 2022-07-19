class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(word: random_word)

    if @game.save
      redirect_to @game
    else
      render :show
    end
  end

  private

  def random_word
    Word.all.shuffle.last
  end
end
