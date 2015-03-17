module SessionHelper

def log_in(user)
  session[:user_id] = user.id
end

def remember(user)
	user.remember
    cookie.permanent.signed[:user.id] = user_id
    cookie.permanent[:remember_token] = remember_token
end

def current_user
	if (user_id = session[:user_id])
		@current_user ||= User.find_by(id: session[:user_id])
	elsif (user_id = cookie[:user_id])
       user = User.find_by(id :user_id)
    	   if user && user.authenticated?(cookie[:remember_token]) 
 			 log_in
 		 	 @current_user = user
       	   end
   end
		
end

def logged_in?
	!current_user.nil?
end

def forget
  current_user.forget
  cookie.delete(:user_id)
  cookie.delete(:remember_token)
end

def log_out
	forget(current_user)
    session.delete(:user_id)
    @current_user = nil	
end

end
