class TweetsController < ApplicationController
  def index
    @tweets = Tweets.all
  end
end
