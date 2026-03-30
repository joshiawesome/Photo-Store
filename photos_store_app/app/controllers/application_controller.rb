class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  def current_user
    # Rails automatically sets session[:user_id] when session is created
    # This is done with the help of Rack
    # session = a Hash-like object - comes from Rack::Session
    # Browser → Puma (web server) → Rack → Rails → Controller
    # Browser sends request with cookies (including session cookie)
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
