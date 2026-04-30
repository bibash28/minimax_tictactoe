import 'package:minimax_tictactoe/src/logic/alphabeta.dart';
import 'package:minimax_tictactoe/src/logic/board_evaluator.dart';
import 'package:minimax_tictactoe/src/logic/minimax.dart';
import 'package:minimax_tictactoe/src/models/benchmark_result.dart';
import 'package:minimax_tictactoe/src/models/search_result.dart';
import 'package:minimax_tictactoe/src/models/test_case.dart';

/// The number of times each test case is run to compute the median.
const int kRunsPerCase = 5;

/// The search depths to test for each board configuration.
const List<int> kDepths = [1, 2, 3];

/// Runs the full benchmark across all test cases and depths.
///
/// For each [TestCase] and each depth in [kDepths], both
/// [Minimax] and [AlphaBeta] are run [kRunsPerCase] times.
/// The median node count and execution time are recorded.
class BenchmarkRunner {
  /// Creates a [BenchmarkRunner] with the given algorithms.
  BenchmarkRunner()
    : _minimax = const Minimax(evaluator: BoardEvaluator()),
      _alphaBeta = const AlphaBeta(evaluator: BoardEvaluator());

  final Minimax _minimax;
  final AlphaBeta _alphaBeta;

  /// Runs the benchmark for all [testCases] at all depths.
  ///
  /// Returns a list of [BenchmarkResult] — one per test case per depth.
  List<BenchmarkResult> run(List<TestCase> testCases) {
    final results = <BenchmarkResult>[];

    for (final testCase in testCases) {
      for (final depth in kDepths) {
        final result = _runSingle(testCase, depth);
        results.add(result);
      }
    }

    return results;
  }

  /// Runs a single test case at a specific depth [kRunsPerCase] times
  /// and returns the median result.
  BenchmarkResult _runSingle(TestCase testCase, int depth) {
    final mmResults = <SearchResult>[];
    final abResults = <SearchResult>[];

    for (var i = 0; i < kRunsPerCase; i++) {
      mmResults.add(
        _minimax.findBestMove(testCase.board, testCase.player, depth),
      );
      abResults.add(
        _alphaBeta.findBestMove(testCase.board, testCase.player, depth),
      );
    }

    return BenchmarkResult(
      testCase: testCase,
      depth: depth,
      minimaxResult: _median(mmResults),
      alphaBetaResult: _median(abResults),
    );
  }

  /// Returns the median [SearchResult] from a list of results.
  ///
  /// Sorts by nodes explored and picks the middle value.
  /// The best move is taken from the first result since it
  /// is always the same across runs.
  SearchResult _median(List<SearchResult> results) {
    final sorted = List<SearchResult>.of(results)
      ..sort((a, b) => a.nodesExplored.compareTo(b.nodesExplored));

    final mid = sorted[kRunsPerCase ~/ 2];

    // Sort by time and pick median time separately
    final sortedByTime = List<SearchResult>.of(results)
      ..sort(
        (a, b) => a.elapsedMicroseconds.compareTo(b.elapsedMicroseconds),
      );
    final medianTime = sortedByTime[kRunsPerCase ~/ 2].elapsedMicroseconds;

    return SearchResult(
      bestMove: mid.bestMove,
      nodesExplored: mid.nodesExplored,
      elapsedMicroseconds: medianTime,
    );
  }
}
