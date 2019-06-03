FactoryBot.define do
  factory :season do
    title {'First'}
    plot {'The first season of this lovable story'}

    factory :season_with_episodes do
      after :create do |season|
        create :episode, season: season, number: 1
        create :episode, season: season, number: 2
      end 
      
    end
  end
end
