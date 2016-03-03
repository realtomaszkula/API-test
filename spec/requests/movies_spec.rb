require "spec_helper"

describe "movies API" do
  describe "GET /movies" do
    it "returns all the movies" do
      FactoryGirl.create :movie, title: "The Hobbit"
      FactoryGirl.create :movie, title: "The Fellowship of the Ring"

      get "/movies", {}, { "Accept" => "application/json" }

      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      movie_titles = body.map { |m| m["title"] }

      expect(movie_titles).to match_array(["The Hobbit",
                                           "The Fellowship of the Ring"])
    end
  end


  describe 'GET /movies/:id' do
    it 'returns a requested movie' do
      m = FactoryGirl.create :movie, title: "2001: A Space Odyssey"

      get "/movies/#{m.id}", {}, { "Accept" => "application/json" }

      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      expect(body["title"]).to eq "2001: A Space Odyssey"
    end
  end

 describe "POST /movies" do
    it "creates a movie" do
      movie_params = {
        "movie" => {
          "title" => "Indiana Jones and the Temple of Doom"
        }
      }.to_json

      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }

      post "/movies", movie_params, request_headers

      expect(response.status).to eq 201 # created
      expect(Movie.first.title).to eq "Indiana Jones and the Temple of Doom"
    end
  end

  describe "PATCH /movies" do
    it "edits a movie" do
      m = FactoryGirl.create :movie, title: "Matrix Reloaded"

      movie_params = {
        "movie" => {
          "title" => "Matrix Revolutions"
        }
      }.to_json

      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }

      patch "/movies/#{m.id}", movie_params, request_headers

      expect(response.status).to eq 200
      expect(Movie.first.title).to eq "Matrix Revolutions"
    end
  end

  describe "DELETE /movie/:id" do
    it "destroys a movie" do
      m = FactoryGirl.create :movie, title: "Nightmare on Elm Street"

      delete "/movies/#{m.id}", {}, { "Accept" => "application/json"}

      expect(response.status).to eq 200
      expect(Movie.all.empty?).to be true
    end
  end



end