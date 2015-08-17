FactoryGirl.define do 
  
  factory :admin, class: User do | user |
    name "mohit"
    email "mohitpawar@joshsoftware.com"
    password "mohit12345"
    role "admin"
  end

  factory :tournament_manager, class: User do | user |
    name "mohit"
    email "mohitpawar88@gmail.com"
    password "mohit12345"
    role "tournament_manager"
  end

end
