class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include DeviseWhitelist
  include DefaultPageContent
  
  module Driftwood
    # FOR PULLING RANDOM RECORD FROM DB
    def driftwood(table, column)
      @model = table.capitalize
      @sum = User.count
      @number = rand(1...@sum)
      @final = User.limit(1).offset(@number)
    end
  end
end
