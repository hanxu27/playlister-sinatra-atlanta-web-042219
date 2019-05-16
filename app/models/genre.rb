class Genre < ActiveRecord::Base
    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artists, through: :songs

    def self.find_by_slug(slug)
        Genre.all.find { |o| slug == Slug.slugify(o.name) }
    end
end