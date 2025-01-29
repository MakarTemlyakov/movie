class MovieDetail {
  final bool? adult;
  final String? backdropPath;
  final BelongsToCollection? belongsToCollection;
  final num? budget;
  final List<Genres?>? genres;
  final String? homepage;
  final num? id;
  final String? imdbId;
  final List<String?>? originCountry;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final num? popularity;
  final String? posterPath;
  final List<ProductionCompanies?>? productionCompanies;
  final List<ProductionCountries?>? productionCountries;
  final String releaseDate;
  final num? revenue;
  final String runtime;
  final List<SpokenLanguages?>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String title;
  final bool? video;
  final String voteAverage;
  final num? voteCount;

  MovieDetail({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originCountry,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    required this.releaseDate,
    this.revenue,
    required this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    required this.title,
    this.video,
    required this.voteAverage,
    this.voteCount,
  });

  factory MovieDetail.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return MovieDetail(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      belongsToCollection: json['belongs_to_collection'] != null
          ? BelongsToCollection.fromJson(json['belongs_to_collection'])
          : null,
      budget: json['budget'],
      genres: json['genres'] != null
          ? List<Genres>.from(
              json['genres'].map((item) => Genres.fromJson(item)))
          : null,
      homepage: json['homepage'],
      id: json['id'],
      imdbId: json['imdb_id'],
      originCountry: json['origin_country'] != null
          ? List<String>.from(json['origin_country'].map((item) => item))
          : null,
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      productionCompanies: json['production_companies'] != null
          ? List<ProductionCompanies>.from(json['production_companies']
              .map((item) => ProductionCompanies.fromJson(item)))
          : null,
      productionCountries: json['production_countries'] != null
          ? List<ProductionCountries>.from(json['production_countries']
              .map((item) => ProductionCountries.fromJson(item)))
          : null,
      releaseDate: DateTime.parse(json['release_date']).year.toString(),
      revenue: json['revenue'],
      runtime: json['runtime'].toString(),
      spokenLanguages: json['spoken_languages'] != null
          ? List<SpokenLanguages>.from(json['spoken_languages']
              .map((item) => SpokenLanguages.fromJson(item)))
          : null,
      status: json['status'],
      tagline: json['tagline'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'].toStringAsFixed(1),
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'belongs_to_collection': belongsToCollection?.toJson(),
      'budget': budget,
      'genres': genres?.map((item) => item?.toJson()).toList(),
      'homepage': homepage,
      'id': id,
      'imdb_id': imdbId,
      'origin_country': originCountry?.map((item) => item).toList(),
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'production_companies':
          productionCompanies?.map((item) => item?.toJson()).toList(),
      'production_countries':
          productionCountries?.map((item) => item?.toJson()).toList(),
      'release_date': releaseDate,
      'revenue': revenue,
      'runtime': runtime,
      'spoken_languages':
          spokenLanguages?.map((item) => item?.toJson()).toList(),
      'status': status,
      'tagline': tagline,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}

class SpokenLanguages {
  final String? englishName;
  final String? iso6391;
  final String? name;

  SpokenLanguages({
    this.englishName,
    this.iso6391,
    this.name,
  });

  factory SpokenLanguages.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return SpokenLanguages(
      englishName: json['english_name'],
      iso6391: json['iso_639_1'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'english_name': englishName,
      'iso_639_1': iso6391,
      'name': name,
    };
  }
}

class ProductionCountries {
  final String? iso31661;
  final String? name;

  ProductionCountries({
    this.iso31661,
    this.name,
  });

  factory ProductionCountries.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ProductionCountries(
      iso31661: json['iso_3166_1'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso_3166_1': iso31661,
      'name': name,
    };
  }
}

class ProductionCompanies {
  final num? id;
  final dynamic logoPath;
  final String? name;
  final String? originCountry;

  ProductionCompanies({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  factory ProductionCompanies.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ProductionCompanies(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['name'],
      originCountry: json['origin_country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo_path': logoPath,
      'name': name,
      'origin_country': originCountry,
    };
  }
}

class Genres {
  final num? id;
  final String? name;

  Genres({
    this.id,
    this.name,
  });

  factory Genres.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Genres(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class BelongsToCollection {
  final num? id;
  final String? name;
  final dynamic posterPath;
  final dynamic backdropPath;

  BelongsToCollection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  factory BelongsToCollection.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return BelongsToCollection(
      id: json['id'],
      name: json['name'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
    };
  }
}
