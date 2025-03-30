class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!, except: [:create]

  private
  
  def unauthorized_response
    render json: { error: "Invalid token" }, status: :unauthorized
  end

  # def authenticate_user!
  #   token = request.headers["Authorization"]
  #   return render json: { error: "Unauhorrized" }, status: :unauthorized if token.blank?

  #   begin
  #     payload = JWT.decode(token, Rails.application.credentials.secret_key_base, true, alogorithm: "Hs256")[0]
  #     @current_user = User.find(payload["user_id"])
      
  #   rescue JWT::DecodeError
  #     render json: { error: "invalid token" }, status: :unauthorized
  #   end
    
  # end

end
