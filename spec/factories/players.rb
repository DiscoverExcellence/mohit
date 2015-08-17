FactoryGirl.define do
  
  factory :player do
    name "player"
    info "player_info"
  end

  factory :player1, class: Player do
    name "player1"
    info "player1_info"
  end

  factory :player2, class: Player do
    name "player2"
    info "player2_info"
  end

  factory :invalid_player_name, class: Player, parent: :player do
    name ""
  end

end
