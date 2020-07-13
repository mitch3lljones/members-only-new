module SessionsHelper
    def login(user)
        user.set_new_remember_token
        session[:user_id] = user.id
        cookies.permanent.signed[:remember_token] = user.remember_token
        current_user
    end

    def logged_in?
        !current_user.nil?
    end

    def current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        elsif cookies.signed[:remember_token]
            @current_user = User.find_by(remember_digest: 
                                           User.digest(cookies.signed[:remember_token]))
            session[:user_id] = @current_user.id
        else
            nil
        end
    end

    def log_out(user)
        reset_session
        user.forget
        cookies.delete(:remember_token)
    end
end