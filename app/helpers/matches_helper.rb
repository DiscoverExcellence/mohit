module MatchesHelper
  def match_date(match)
    (match.created_at != nil) ? match.created_at : "Not Available"
  end
end
