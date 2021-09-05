class ItemList {
  int? page;
  int? total_results;
  int? total_pages;
  List<Result> results = [];

  ItemList.fromJson(Map<String, dynamic> parsedJson) {
    page = parsedJson['page'];
    total_results = parsedJson['total_results'];
    total_pages = parsedJson['total_pages'];
    List<Result> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      Result result = Result(parsedJson['results'][i]);
      temp.add(result);
    }
    results = temp;
  }

  List<Result> get result => results;

  int? get total_page => total_pages;

  int? get total_result => total_results;

  int? get pages => page;
}

class Result {
  int? vote_count;
  int? id;
  bool? video;
  String? vote_average;
  String? title;
  double? _popularity;
  String? poster_path;
  String? original_language;
  String? original_title;
  List<int?> _genre_ids = [];
  String? backdrop_path;
  bool? _adult;
  String? _overview;
  String? release_date;

  Result(result) {
    vote_count = result['vote_count'];
    id = result['id'];
    video = result['video'];
    vote_average = result['vote_average'].toString();
    title = result['title'];
    _popularity = result['popularity'];
    poster_path = result['poster_path'];
    original_language = result['original_language'];
    original_title = result['original_title'];
    for (int i = 0; i < result['genre_ids'].length; i++) {
      _genre_ids.add(result['genre_ids'][i]);
    }
    backdrop_path = result['backdrop_path'];
    _adult = result['adult'];
    _overview = result['overview'];
    release_date = result['release_date'];
  }

  String? get releaseResultdate => release_date;

  String? get overview => _overview;

  bool? get adult => _adult;

  String? get backdrop_paths => backdrop_path;

  List<int> get genre_ids => genre_ids;

  String? get original_titles => original_title;

  String? get original_languages => original_language;

  String? get poster_paths => poster_path;

  double get popularity => popularity;

  String? get titles => title;

  String? get vote_averages => vote_average;

  bool? get videos => video;

  int? get ids => id;

  int? get vote_counts => vote_count;
}
