class Song < ActiveRecord::Base
    belongs_to :artist
    has_many :song_genres
    has_many :genres, through: :song_genres
    
    validates :name, length: { minimum: 2 }

    def self.find_by_slug(slug)
        Song.all.find { |o| slug == Slug.slugify(o.name) }
    end
end