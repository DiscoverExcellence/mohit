class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.to = ['mohit@joshsoftware.com', 'mohitpawar88@gmail.com']
  end
end
