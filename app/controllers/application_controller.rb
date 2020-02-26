class  ApplicationController  <  ActionController::Base
    #  Prevent  CSRF  attacks  by  raising  an  exception.
    #  For  APIs,  you  may  want  to  use  :null_session  instead.
    protect_from_forgery  with:  :exception

=begin
    def  authenticate_admin_user!  #use  predefined  method  name
            redirect_to  '/'  and  return  if  user_signed_in?  &&  !current_user.is_admin?
            authenticate_user!
    end

    def  current_admin_user  #use  predefined  method  name
        return  nil  if  user_signed_in?  &&  !current_user.is_admin?
        current_user
    end
=end

end
