import 'package:minimax_tictactoe/src/runner/benchmark_runner.dart';
import 'package:minimax_tictactoe/src/runner/test_cases.dart';
import 'package:test/test.dart';

void main() {
  late BenchmarkRunner runner;

  setUp(() {
    runner = BenchmarkRunner();
  });

  group('BenchmarkRunner.run', () {
    test('returns 3 results per test case (one per depth)', () {
      final results = runner.run([TestCases.e01]);
      expect(results.length, equals(3));
    });

    test('returns correct depths', () {
      final results = runner.run([TestCases.e01]);
      expect(results.map((r) => r.depth).toList(), equals([1, 2, 3]));
    });

    test('returns 63 results for 21 test cases', () {
      final results = runner.run(TestCases.all);
      expect(results.length, equals(63));
    });

    test('all results have nodesExplored greater than zero', () {
      final results = runner.run(TestCases.all);
      for (final r in results) {
        expect(
          r.minimaxResult.nodesExplored,
          greaterThan(0),
          reason: '${r.testCase.id} depth ${r.depth} minimax nodes should > 0',
        );
        expect(
          r.alphaBetaResult.nodesExplored,
          greaterThan(0),
          reason: '${r.testCase.id} depth ${r.depth} ab nodes should > 0',
        );
      }
    });

    test('all results have movesMatch true', () {
      final results = runner.run(TestCases.all);
      for (final r in results) {
        expect(
          r.movesMatch,
          isTrue,
          reason:
              '${r.testCase.id} depth ${r.depth} — Minimax and AlphaBeta must'
              ' agree on best move',
        );
      }
    });

    test('alpha-beta explores <= nodes compared to minimax', () {
      final results = runner.run(TestCases.all);
      for (final r in results) {
        expect(
          r.alphaBetaResult.nodesExplored,
          lessThanOrEqualTo(r.minimaxResult.nodesExplored),
          reason:
              '${r.testCase.id} depth ${r.depth} — AB should'
              ' never explore more nodes than Minimax',
        );
      }
    });
  });
}
