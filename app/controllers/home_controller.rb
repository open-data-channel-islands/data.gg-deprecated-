class HomeController < ApplicationController
  #layout "front"

  layout "application", :only => [ :about, :help ]
  def index
  end
  
  def about
    
  end
  
  def help
    
  end
end
