FactoryGirl.define do

  factory :game do | g |
    g.name "default_game"
    g.scoring_points 2
    g.description "default"
  end

  factory :cricket, class: Game do | g |
    g.name "cricket"
    g.scoring_points 10
    g.description "cricket"
  end

  factory :tennis, class: Game, parent: :game do | g |
    g.name "tennis"
    g.description "tennis"
  end

  factory :football, class: Game, parent: :game do | g |
    g.name "football"
    g.description "football"
  end

  factory :basketball, class: Game, parent: :game do | g |
    g.name "basketball"
    g.scoring_points 10
    g.description "basketball"
  end

  factory :game_invalid_name,parent: :game do | g |
    g.name ""
  end

  factory :game_invalid_scoring_points, parent: :game do | g |
    g.scoring_points "abcd"
  end

end
