require 'httparty'

class FootballData
  attr_reader :club

  def initialize(args = {})
    @club = args[:club]
  end

  def next_game
    next_fixture = next_fixture_from(schedule_for(club))
    "#{next_fixture['homeTeamName']} - #{next_fixture['awayTeamName']} le #{next_fixture['date'].to_date.strftime('%d/%m')}"
  end

  private

  def next_fixture_from(schedule)
    schedule["fixtures"].select {|fixture| fixture['date'].to_datetime >= DateTime.current }.first
  end

  def schedule_for(team)
    all_teams_from(434)["teams"].each do |team|
      if team["shortName"].include?(club)
        return all_fixtures_from(team["_links"]["fixtures"]["href"])
      end
    end

    return "No team found"
  end

  def all_teams_from(competition_id)
    url = "http://api.football-data.org/v1/competitions/#{competition_id}/teams"
    response = HTTParty.get(url, headers: {"X-Auth-Token" => ENV['FOOTBALL_DATA_TOKEN']})
    response.parsed_response
  end

  def all_fixtures_from(team_fixtures_url)
    url = team_fixtures_url
    response = HTTParty.get(url, headers: {"X-Auth-Token" => ENV['FOOTBALL_DATA_TOKEN']})
    response.parsed_response
  end
end



# All teams for Ligue 1 => http://api.football-data.org/v1/competitions/434/teams

# All Fixtures for Team with ID = 524 => http://api.football-data.org/v1/teams/524/fixtures