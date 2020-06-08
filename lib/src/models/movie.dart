class Movie {
  final String Title;
  final String Year;
  final String imdbID;
  final String Type;
  final String Poster;

  Movie({this.Title, this.Year, this.imdbID, this.Type, this.Poster});

  factory Movie.fromJson(Map<String, dynamic> parsedJson) {
    return Movie(
      Title: parsedJson['Title'],
      Year: parsedJson['Year'],
      imdbID: parsedJson['imdbID'],
      Type: parsedJson['Type'],
      Poster: parsedJson['Poster'],
    );
  }
}

class MovieResult {
  final List<Movie> Search;
  final int totalResults;
  final bool Response;

  MovieResult({this.Search, this.totalResults, this.Response});

  factory MovieResult.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['Search'] as List;

    if (list == null) {
      return new MovieResult(
        Response: false,
        Search: new List<Movie>(),
        totalResults: 0,
      );
    }
    // print(parsedJson['Search']);
    return MovieResult(
      Search: list.map((e) => Movie.fromJson(e)).toList(),
      totalResults: int.parse(parsedJson['totalResults']),
      Response: true,
    );
  }
}

class MovieDetail {
  final String Title;
  final String Year;
  final String Rated;
  final String Released;
  final String Runtime;
  final String Genre;
  final String Director;
  final String Writer;
  final String Actors;
  final String Plot;
  final String Language;
  final String Country;
  final String Awards;
  final String Poster;
  final List<RatingMovie> Ratings;
  final String Metascore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbID;
  final String Type;
  final String DVD;
  final String BoxOffice;
  final String Production;
  final String Website;
  final String Response;

  MovieDetail(
      {this.Title,
      this.Year,
      this.Rated,
      this.Released,
      this.Runtime,
      this.Genre,
      this.Director,
      this.Writer,
      this.Actors,
      this.Plot,
      this.Language,
      this.Country,
      this.Awards,
      this.Poster,
      this.Ratings,
      this.Metascore,
      this.imdbRating,
      this.imdbVotes,
      this.imdbID,
      this.Type,
      this.DVD,
      this.BoxOffice,
      this.Production,
      this.Website,
      this.Response});

  factory MovieDetail.fromJson(Map<String, dynamic> parsedJson) {
    return MovieDetail(
      Title: parsedJson['Title'],
      Year: parsedJson['Year'],
      Rated: parsedJson['Rated'],
      Released: parsedJson['Released'],
      Runtime: parsedJson['Runtime'],
      Genre: parsedJson['Genre'],
      Director: parsedJson['Director'],
      Writer: parsedJson['Writer'],
      Actors: parsedJson['Actors'],
      Plot: parsedJson['Plot'],
      Language: parsedJson['Language'],
      Country: parsedJson['Country'],
      Awards: parsedJson['Awards'],
      Poster: parsedJson['Poster'],
      Ratings: (parsedJson['Ratings'] as List)
          .map((e) => RatingMovie.fromJson(e))
          .toList(),
      Metascore: parsedJson['Metascore'],
      imdbRating: parsedJson['imdbRating'],
      imdbVotes: parsedJson['imdbVotes'],
      imdbID: parsedJson['imdbID'],
      Type: parsedJson['Type'],
      DVD: parsedJson['DVD'],
      BoxOffice: parsedJson['BoxOffice'],
      Production: parsedJson['Production'],
      Website: parsedJson['Website'],
      Response: parsedJson['Response'],
    );
  }
}

class RatingMovie {
  final String Source;
  final String Value;

  RatingMovie({this.Source, this.Value});

  factory RatingMovie.fromJson(Map<String, dynamic> parsedJson) {
    return RatingMovie(
        Source: parsedJson['Source'], Value: parsedJson['Value']);
  }
}
