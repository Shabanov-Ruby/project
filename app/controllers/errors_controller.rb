class ErrorsController < ApplicationController
  def internal_server_error
    render file: "#{Rails.root}/public/500.html", status: :internal_server_error, layout: false
  end
end
