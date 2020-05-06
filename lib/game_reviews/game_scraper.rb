class GameReviews::GameScraper
    
    def self.scrape_games_index
        base_url = "https://www.gamespot.com/games/reviews/"
        games = Nokogiri::HTML(open(base_url))
        # binding.pry
        games.css(".horizontal-card-item").each do |game|
            game_system = game.css(".horizontal-card-item__label")[0].text
            title = game.css("h4.horizontal-card-item__title").text
            review = game.css(".review-ring-score__score")[0].text.to_i
            review_text = game.css("span.review-ring-score__text").text
            url = "https://www.gamespot.com" + game.css("a.horizontal-card-item__link").attribute("href").value
            GameReviews::Games.new(game_system, title, review, review_text, url)
            # binding.pry
        end
    end

    # def self.scrape_second_layer(url)

    # end
end