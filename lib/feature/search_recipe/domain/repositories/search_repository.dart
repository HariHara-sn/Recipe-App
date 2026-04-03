import 'package:recepieapp/feature/search_recipe/domain/model/match_result_model.dart';

abstract class SearchRepository {
  List<MatchResult> findMatches(List<String> pantry);
}