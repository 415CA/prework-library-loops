require 'pry'

library = [
  {title: "Dracula", author: "Bram Stoker", genres: ["Horror", "Gothic"], pages: 418, publication_year: 1897, completed: true},
  {title: "Slaughterhouse Five; or the Children's Crusade", author: "Kurt Vonnegut, Jr.", genres: ["Satire", "Science Fiction"], pages: 186, publication_year: 1969, completed: false},
  {title: "Frankenstein; or, the Modern Prometheus", author: "Mary Shelley", genres: ["Gothic", "Horror", "Science Fiction"], pages: 280, publication_year: 1818, completed: true},
  {title: "Circe", author: "Madeline Miller", genres: ["Historical Fiction", "Fantasy"], pages: 385, publication_year: 2018, completed: false},
  {title: "Inferno", author: "Dante Alighieri", genres: ["Epic"], pages: 261, publication_year: 1320, completed: true},
  {title: "Mastering the Art of French Cooking", author: "Simone Beck, Louisette Bertholie, Julia Child", genres: ["Cooking"], pages: 726, publication_year: 1961, completed: false},
  {title: "Animal Farm", author: "George Orwell", genres: ["Political Satire"], pages: 112, publication_year: 1945, completed: true},
  {title: "War and Peace", author: "Leo Tolstoy", genres: ["Historical Fiction"], pages: 1225, publication_year: 1869, completed: false},
  {title: "The Innovators: How a Group of Hackers, Geniuses, and Geeks Created the Digital Revolution", author: "Walter Isaacson", genres: ["Biography"], pages: 488, publication_year: 2014, completed: false},
  {title: "Twilight", author: "Stephanie Meyer", genres: ["Young Adult", "Fantasy", "Romance"], pages: 498, publication_year: 2005, completed: true},
  {title: "The Life of Washington", author: "Mason Weems", genres: ["Historical Fiction", "Biography"], pages: 264, publication_year: 1809, completed: false},
  {title: "The Travels of John Mandeville", author: "John Mandeville", genres: ["Historical Fiction", "Fantasy"], pages: 167, publication_year: 1371, completed: false},
  {title: "Gulliver's Travels; or, Travels into Several Remote Nations of the World. In Four Parts. By Kenuel Gulliverr, First a Sugeon, and tthen a Captain of Several Ships", author: "Jonathan Swift", genres: ["Political Satire", "Fantasy"], pages: 240, publication_year: 1726, completed: true}
]

# WRITE CODE BELOW HERE
def all_pages(library)
  library.reduce(0) {|sum, book| sum += book[:pages]}
end

puts all_pages(library)

def all_pages_read(library)
  library.reduce(0) { |sum, book| book[:completed] ? sum += book[:pages] : sum}
end

puts all_pages_read(library)

def all_genres(library)
  library.reduce([]) {|arr, book| arr += book[:genres]}.flatten.uniq
end

puts all_genres(library)

def books_read(library)
  library.reduce([]) { |arr, book| book[:completed] ? arr << book : arr }
end

puts books_read(library)

def completed_books_detail(library)
  puts "I've read #{books_read(library).length} books, totaling at #{all_pages_read(library)} pages."
end

puts completed_books_detail(library)

def books_in_library(library)
  library.reduce([]) { |arr, book| arr.push("#{book[:title]} by #{book[:author]}")}
end

puts books_in_library(library)

def books_by_year(library)
  library = library.sort do |book_a, book_b| book_a[:publication_year] - book_b[:publication_year]
  end
  books_in_library(library)
end

puts books_by_year(library)

def books_with_subtitles(library)
  library.reduce([]) { |arr, book| book[:title].include?((/;|:/) ? arr << book : arr }
end

puts books_with_subtitles(library)

def books_primary_title(library)
  books_with_subtitles(library).reduce([]) {|arr, book| arr << book[:title].split(/;|:/).first}
end

puts books_primary_title(library)

def highest_page_count(library)
  library.sort {|book_a, book_b| book_b[:pages] - book_a[:pages] }.first
end

puts highest_page_count(library)

def recommended_books(library, number)
  library = books_read(library).sort {|book_a, book_b| book_a[:pages] - book_b[:pages]}
  array = []
  index = 0
  while index < number do
    book = books_read(library)[index]
    array.push("You should read #{book[:title]} by #{book[:author]}; it's only #{book[:pages]} pages long!")
    index += 1
  end
  array
end

puts recommended_books(library, 3)

def recommended_books_by_genre(library, prefered_genres, rejected_genres)
  recommended = library.select { |book| book[:genres].include?(prefered_genres) }
  additional = library.select { |book|
    !book[:genres].include?(prefered_genres) && !book[:genres].include?(rejected_genres)
  }
  output = []
  index = 0
  while index < recommended.length
    book = recommended[index]
    output.push("Since you like #{prefered_genres}, you should read #{book[:title]} by #{book[:author]}!")
    index += 1
  end

  if index == recommended.length
    add_index = 0
    while add_index < additional.length
      book = additional[add_index]
      output.push("I also recommend #{book[:title]} by #{book[:author]}.")
      add_index += 1
      binding.pry
    end
  end
  output
end

puts recommended_books_by_genre(library, "Historical Fiction", "Science Fiction")

# WRITE CODE ABOVE HERE
puts "Books!"