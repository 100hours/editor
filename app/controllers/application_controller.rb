class ApplicationController < ActionController::Base
  http_basic_authenticate_with :name => ENV['EDITOR_USERNAME'], :password => ENV['EDITOR_PASSWORD']
  protect_from_forgery
end
