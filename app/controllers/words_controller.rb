class WordsController < ApplicationController
  def index
    @words = Word.all.shuffle
  end
end
