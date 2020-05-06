#CLI controller
class GameReviews::CLI

    def run
        GameReviews::GameScraper.scrape_games_index
        list_games
        game_menu
    end

    def list_games
        system("clear")
        puts ""
        puts "
                    ░██╗░░░░░░░██╗███████╗██╗░░░░░░█████╗░░█████╗░███╗░░░███╗███████╗  ████████╗░█████╗░  
                    ░██║░░██╗░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗████╗░████║██╔════╝  ╚══██╔══╝██╔══██╗  
                    ░╚██╗████╗██╔╝█████╗░░██║░░░░░██║░░╚═╝██║░░██║██╔████╔██║█████╗░░  ░░░██║░░░██║░░██║  
                    ░░████╔═████║░██╔══╝░░██║░░░░░██║░░██╗██║░░██║██║╚██╔╝██║██╔══╝░░  ░░░██║░░░██║░░██║  
                    ░░╚██╔╝░╚██╔╝░███████╗███████╗╚█████╔╝╚█████╔╝██║░╚═╝░██║███████╗  ░░░██║░░░╚█████╔╝  
                    ░░░╚═╝░░░╚═╝░░╚══════╝╚══════╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚══════╝  ░░░╚═╝░░░░╚════╝░  
                
                ░██████╗░░█████╗░███╗░░░███╗███████╗  ██████╗░███████╗██╗░░░██╗██╗███████╗░██╗░░░░░░░██╗░██████╗██╗
                ██╔════╝░██╔══██╗████╗░████║██╔════╝  ██╔══██╗██╔════╝██║░░░██║██║██╔════╝░██║░░██╗░░██║██╔════╝██║
                ██║░░██╗░███████║██╔████╔██║█████╗░░  ██████╔╝█████╗░░╚██╗░██╔╝██║█████╗░░░╚██╗████╗██╔╝╚█████╗░██║
                ██║░░╚██╗██╔══██║██║╚██╔╝██║██╔══╝░░  ██╔══██╗██╔══╝░░░╚████╔╝░██║██╔══╝░░░░████╔═████║░░╚═══██╗╚═╝
                ╚██████╔╝██║░░██║██║░╚═╝░██║███████╗  ██║░░██║███████╗░░╚██╔╝░░██║███████╗░░╚██╔╝░╚██╔╝░██████╔╝██╗
                ░╚═════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝  ╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═════╝░╚═╝ ".blue
        puts ""
        puts ""
        puts "                                      The place to view the your favorite game's review!                            "
        puts ""
        puts "                     Type the number for the game you want more information about or type exit to leave program.           "
        puts ""
        puts "                               --------------------------------------------------------------------                                                 "
        games = GameReviews::Games.all
        games.each.with_index(1) do |game, index|
            puts "                               --------------------------------------------------------------------                                                 "
            puts "                               #{index}. #{game.title}                                                      "
            puts "                               --------------------------------------------------------------------                                               "
        end
    end

    def game_menu
        input = nil
        # puts ""
        while input != "exit"
            input = gets.strip.downcase
            system("clear")

            if input.to_i > 0
                game_selection = GameReviews::Games.find_by_index(input.to_i - 1)
                puts "---------------------------------------------------------------------------------------------------------------------------       "
                puts " #{game_selection.title} - #{game_selection.game_system}                                   "
                puts " Rating Grade: #{game_selection.review}/10 - #{game_selection.review_text}                                  "
                puts " For information about this game's review,                          "
                puts " go to #{game_selection.url}"
                puts "---------------------------------------------------------------------------------------------------------------------------       "
                puts "                                     Type list to view menu again or type exit.                                                 "
            elsif input.downcase == "list"
                list_games
            elsif input.downcase == "exit"
                goodbye
            else
                puts "                                              Invalid input try again.                                            "
            end
        end
    end

    def goodbye
        puts "                                            Goodbye, see you next time for your favorite game's review!                        "
    end
end