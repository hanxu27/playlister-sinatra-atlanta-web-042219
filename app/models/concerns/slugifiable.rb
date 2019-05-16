require 'pry'

class Slug
    def self.slugify(string)
        string.gsub(" ", "-").gsub(/[^0-9A-Za-z\-]/, "")

    end
end