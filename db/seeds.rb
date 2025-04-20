require 'json'

file = File.read('db/top250.json')
movies = JSON.parse(file)

movies.each do |movie|
  Movie.create!(
    title: movie['name'],
    description: movie['description'].squish,
    released_on: movie['datePublished'],
    rating: movie['contentRating'],
    total_gross: 1_000_000,
    director: movie['director'][0]['name'],
    duration: movie['duration'],
    image_file_name: movie['image']
  )
end

Genre.create(name: "Action")
Genre.create(name: "Comedy")
Genre.create(name: "Drama")
Genre.create(name: "Romance")
Genre.create(name: "Thriller")
Genre.create(name: "Fantasy")
Genre.create(name: "Documentary")
Genre.create(name: "Adventure")
Genre.create(name: "Animation")
Genre.create(name: "Sci-Fi")

User.create(name: "Tester McTesterson", email: 'test@example.com', password: 'Secret1234')
