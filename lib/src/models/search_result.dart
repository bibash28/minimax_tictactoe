import 'package:meta/meta.dart';

/// Holds the result of a single algorithm run.
///
/// Contains the best move index, number of nodes explored,
/// and execution time in microseconds.
@immutable
class SearchResult {
  /// Creates a [SearchResult] with the given values.
  const SearchResult({
    required this.bestMove,
    required this.nodesExplored,
    required this.elapsedMicroseconds,
  });

  /// The index (0–8) of the best move found by the algorithm.
  final int bestMove;

  /// Total number of recursive calls made during the search.
  final int nodesExplored;

  /// Total execution time in microseconds.
  final int elapsedMicroseconds;

  /// Pruning efficiency percentage compared to a reference result.
  ///
  /// Typically used to compare Alpha-Beta against Minimax:
  /// ```dart
  /// final efficiency = alphaBetaResult.pruningEfficiency(minimaxResult);
  /// ```
  double pruningEfficiency(SearchResult reference) {
    if (reference.nodesExplored == 0) return 0;
    return ((reference.nodesExplored - nodesExplored) /
            reference.nodesExplored) *
        100;
  }

  @override
  String toString() {
    return 'SearchResult(bestMove: $bestMove, '
        'nodesExplored: $nodesExplored, '
        'elapsedMicroseconds: $elapsedMicroseconds)';
  }

  @override
  bool operator ==(Object other) =>
      other is SearchResult &&
      other.bestMove == bestMove &&
      other.nodesExplored == nodesExplored &&
      other.elapsedMicroseconds == elapsedMicroseconds;

  @override
  int get hashCode => Object.hash(
    bestMove,
    nodesExplored,
    elapsedMicroseconds,
  );
}
