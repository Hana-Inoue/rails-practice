class StaticPagesController < ApplicationController
  def logs
    @logs = File.open('/app/log/development.log', 'r').read
  end
end
