class GameReviews::GameScraper
    
    def self.scrape_games_index
        games = Nokogiri::HTML(open("https://www.gamespot.com/games/reviews/"))
        # binding.pry
        games.css(".horizontal-card-item").each do |game|
            game_system = game.css(".horizontal-card-item__label")[0].text
            title = game.css("h4.horizontal-card-item__title").text
            review = game.css(".review-ring-score__score")[0].text.to_i
            review_text = game.css("span.review-ring-score__text").text
            url = "https://www.gamespot.com" + game.css("a.horizontal-card-item__link").attribute("href").value
            new_game = GameReviews::Games.new(game_system, title, review, review_text, url)
            # binding.pry
            scrape_game_info(new_game)
        end
    end

    def self.scrape_game_info(new_game)
        game_information = Nokogiri::HTML(open(new_game.url))
        game_information.css("article.content-body").each do |game_info|
            new_game.game_mini_description = game_info.css("h2.news-deck").text.strip
            new_game.game_review_author = game_info.css("span.byline-author").text.strip
            new_game.game_description = game_info.css("p[dir]")[0].text
            new_game.game_description_2 = game_info.css("p[dir]")[1].text
            # binding.pry
        end
    end
end