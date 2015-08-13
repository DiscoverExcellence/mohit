if %w[staging development].include?(Rails.env)
  require "#{Rails.root.to_s}/lib/#{Rails.env}_mail_interceptor"
  ActionMailer::Base.register_interceptor("#{Rails.env.to_s.classify}MailInterceptor".constantize )
end
