require 'rest-client'
require 'json'
require 'pry'

def json_request(link)
  all_characters = RestClient.get(link)
  new_hash = JSON.parse(all_characters)
end

def get_character_movies_from_api(character)
    #binding.pry
  all_movie_urls = []
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  while all_movie_urls == []
    character_hash["results"].find do |info|
      if info["name"] == character
        info.each do |x, y|
          if x == "films"
            y.each do |value|
              all_movie_urls.push(JSON.parse(RestClient.get(value)))
            end
          end
        end
      end
    end
    character_hash = json_request(character_hash["next"])
  end
    all_movie_urls
  end

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.


def parse_character_movies(films_hash)
  films_hash.each_with_index do |element, index|
    puts "#{index + 1}. #{element["title"]}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
