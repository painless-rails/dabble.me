# Devise Override Controller
class SessionsController < Devise::SessionsController
  after_action :track_ga_event, only: :create
  prepend_before_action :check_captcha, only: [:create]

  def create
    super do |user|
      Sqreen.auth_track(user.persisted?, { id: user.id, email: user.email })
    end
  end  

  private

  def check_captcha
    if ENV['RECAPTCHA_SITE_KEY'].blank? || (verify_recaptcha || ENV['CI'] == "true")
      true
    else
      self.resource = resource_class.new sign_in_params
      Sqreen.auth_track(false, { email: sign_in_params[:email] })
      flash[:alert] = 'Bad recaptcha.'
      respond_with_navigational(resource) { render :new }
    end 
  end

  def track_ga_event
    return nil unless @user.id.present?
    if ENV['GOOGLE_ANALYTICS_ID'].present?
      tracker = Staccato.tracker(ENV['GOOGLE_ANALYTICS_ID'])
      tracker.event(category: 'User', action: 'Login', label: @user.user_key)
    end
  end

end
