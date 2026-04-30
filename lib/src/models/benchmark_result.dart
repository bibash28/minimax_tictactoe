import 'package:meta/meta.dart';
import 'package:minimax_tictactoe/src/models/search_result.dart';
import 'package:minimax_tictactoe/src/models/test_case.dart';

/// Represents the result of a single benchmark run.
///
/// Combines the test case metadata with the search results
/// from both Minimax and Alpha-Beta Pruning at a specific depth.
@immutable
class BenchmarkResult {
  /// Creates a [BenchmarkResult] with the given values.
  const BenchmarkResult({
    required this.testCase,
    required this.depth,
    required this.minimaxResult,
    required this.alphaBetaResult,
  });

  /// The test case that was benchmarked.
  final TestCase testCase;

  /// The search depth used for this benchmark run.
  final int depth;

  /// The result from the Minimax algorithm.
  final SearchResult minimaxResult;

  /// The result from the Alpha-Beta Pruning algorithm.
  final SearchResult alphaBetaResult;

  /// Returns true if both algorithms returned the same best move.
  bool get movesMatch => minimaxResult.bestMove == alphaBetaResult.bestMove;

  /// Returns the pruning efficiency percentage.
  ///
  /// How much fewer nodes Alpha-Beta explored compared to Minimax.
  double get pruningEfficiency =>
      alphaBetaResult.pruningEfficiency(minimaxResult);

  /// Returns true if this is a correctness test and both algorithms
  /// agree with the expected move.
  bool get correctnessVerified {
    if (!testCase.isCorrectnessTest) return true;
    return movesMatch && minimaxResult.bestMove == testCase.expectedMove;
  }

  @override
  String toString() {
    return 'BenchmarkResult(id: ${testCase.id}, depth: $depth, '
        'mmNodes: ${minimaxResult.nodesExplored}, '
        'abNodes: ${alphaBetaResult.nodesExplored}, '
        'pruning: ${pruningEfficiency.toStringAsFixed(1)}%, '
        'match: $movesMatch)';
  }
}
