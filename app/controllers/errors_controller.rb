class ErrorsController < ApplicationController
  def not_found
    @glip_count = Glip.count
    render(:status => 404)
  end

  def internal_server_error
    @glip_count = Glip.count
    render(:status => 500)
  end
end
