class GameReviews::Games
    attr_accessor :game_system, :title, :review, :review_text, :description, :url

    @@all = []

    def initialize(game_system, title, review, review_text, url)
        @game_system = game_system
        @title = title
        @review = review
        @review_text = review_text
        @url = url
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_by_index(index)
        @@all[index]
    end
end