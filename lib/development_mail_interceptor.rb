class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.to = ['mohit@joshsoftware.com']
  end
end
