#CLI controller
class GameReviews::CLI

    def run
        system("clear")
        GameReviews::Display.loading
        GameReviews::GameScraper.scrape_games_index
        welcome
    end

    def welcome
        system("clear")
        GameReviews::Display.welcome_message
        input = gets.strip.downcase
        system("clear")
            list_options(input)
            sleep(1)
            welcome_and_list_games 
    end

    def list_games
        system("clear")
            GameReviews::Display.game_list_title
            games = GameReviews::Games.all
            games.each.with_index(1) do |game, index|
                GameReviews::Display.game_index_and_title(game, index)
            end
                GameReviews::Display.more_info
            input = nil
            input = gets.strip.downcase
            if input.to_i > 0
                game_menu(input)
            else
            list_options(input, display_list = false)
            end
    end

    def game_menu(input)
            system("clear")
            if input.to_i > 0
                game_selection = GameReviews::Games.find_by_index(input.to_i - 1)
                GameReviews::Display.game_menu_title(game_selection)
                input = gets.strip.downcase
                list_options(input)
            end
    end

    def list_options(input, display_list = true)
        if display_list == true && input.downcase == "list"
            list_games
        elsif input.downcase == "exit"
            system("clear")
            GameReviews::Display.goodbye
            exit
        else
            GameReviews::Display.invalid_input
            input = gets.strip.downcase
            list_options(input)
            system("clear")
        end
    end

end