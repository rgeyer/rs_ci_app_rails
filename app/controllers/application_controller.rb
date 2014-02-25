class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :get_commit

  def get_commit
    @commit = %x{git show --pretty=%H}.lines.first.chomp
  end
end
