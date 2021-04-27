require 'open-uri'
require 'nokogiri'

def fetch_top_movie_urls
  top_movies_url = 'https://www.imdb.com/chart/top'
  html_file = URI.open(top_movies_url).read
  html_doc = Nokogiri::HTML(html_file)

  # TODO: return top movies URLs
  array = []
  html_doc.search('.titleColumn a').first(5).each do |movie|
    array << "https://www.imdb.com" + movie.attribute('href').value
  end
  array
end

def scrape_movie(url)
  html_file = URI.open(url, 'Accept-Language' => 'en').read
  html_doc = Nokogiri::HTML(html_file)

  # TODO: return movie info hash
  title_and_year = html_doc.search('h1').text.strip
  regex = /(?<title>.*).\((?<year>\d{4})\)$/
  title = title_and_year.match(regex)[:title]
  year = title_and_year.match(regex)[:year].to_i
  {
    title: title,
    year: year,
    storyline: '',
    director: '',
    cast: ['', '', '']
  }
end
