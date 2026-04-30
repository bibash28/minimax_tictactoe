import 'package:minimax_tictactoe/src/models/benchmark_result.dart';
import 'package:minimax_tictactoe/src/models/board.dart';
import 'package:minimax_tictactoe/src/models/search_result.dart';
import 'package:minimax_tictactoe/src/models/test_case.dart';
import 'package:test/test.dart';

void main() {
  late TestCase perfTestCase;
  late TestCase correctnessTestCase;

  setUp(() {
    perfTestCase = TestCase(
      id: 'E01',
      board: Board.empty(),
      player: Player.x,
      stage: GameStage.early,
    );

    correctnessTestCase = TestCase(
      id: 'C01',
      board: Board.empty(),
      player: Player.x,
      stage: GameStage.correctness,
      expectedMove: 6,
    );
  });

  group('BenchmarkResult', () {
    test('creates with correct values', () {
      const mm = SearchResult(
        bestMove: 4,
        nodesExplored: 100,
        elapsedMicroseconds: 200,
      );
      const ab = SearchResult(
        bestMove: 4,
        nodesExplored: 40,
        elapsedMicroseconds: 80,
      );
      final result = BenchmarkResult(
        testCase: perfTestCase,
        depth: 3,
        minimaxResult: mm,
        alphaBetaResult: ab,
      );
      expect(result.depth, equals(3));
      expect(result.minimaxResult, equals(mm));
      expect(result.alphaBetaResult, equals(ab));
    });

    test('movesMatch is true when both algorithms agree', () {
      const mm = SearchResult(
        bestMove: 4,
        nodesExplored: 100,
        elapsedMicroseconds: 200,
      );
      const ab = SearchResult(
        bestMove: 4,
        nodesExplored: 40,
        elapsedMicroseconds: 80,
      );
      final result = BenchmarkResult(
        testCase: perfTestCase,
        depth: 3,
        minimaxResult: mm,
        alphaBetaResult: ab,
      );
      expect(result.movesMatch, isTrue);
    });

    test('movesMatch is false when algorithms disagree', () {
      const mm = SearchResult(
        bestMove: 4,
        nodesExplored: 100,
        elapsedMicroseconds: 200,
      );
      const ab = SearchResult(
        bestMove: 6,
        nodesExplored: 40,
        elapsedMicroseconds: 80,
      );
      final result = BenchmarkResult(
        testCase: perfTestCase,
        depth: 3,
        minimaxResult: mm,
        alphaBetaResult: ab,
      );
      expect(result.movesMatch, isFalse);
    });

    test('pruningEfficiency returns correct percentage', () {
      const mm = SearchResult(
        bestMove: 4,
        nodesExplored: 100,
        elapsedMicroseconds: 200,
      );
      const ab = SearchResult(
        bestMove: 4,
        nodesExplored: 40,
        elapsedMicroseconds: 80,
      );
      final result = BenchmarkResult(
        testCase: perfTestCase,
        depth: 3,
        minimaxResult: mm,
        alphaBetaResult: ab,
      );
      expect(result.pruningEfficiency, equals(60.0));
    });

    test('correctnessVerified is true for performance test cases', () {
      const mm = SearchResult(
        bestMove: 4,
        nodesExplored: 100,
        elapsedMicroseconds: 200,
      );
      const ab = SearchResult(
        bestMove: 4,
        nodesExplored: 40,
        elapsedMicroseconds: 80,
      );
      final result = BenchmarkResult(
        testCase: perfTestCase,
        depth: 3,
        minimaxResult: mm,
        alphaBetaResult: ab,
      );
      expect(result.correctnessVerified, isTrue);
    });

    test('correctnessVerified is true when moves match expected', () {
      const mm = SearchResult(
        bestMove: 6,
        nodesExplored: 100,
        elapsedMicroseconds: 200,
      );
      const ab = SearchResult(
        bestMove: 6,
        nodesExplored: 40,
        elapsedMicroseconds: 80,
      );
      final result = BenchmarkResult(
        testCase: correctnessTestCase,
        depth: 3,
        minimaxResult: mm,
        alphaBetaResult: ab,
      );
      expect(result.correctnessVerified, isTrue);
    });

    test('correctnessVerified is false when moves do not match expected', () {
      const mm = SearchResult(
        bestMove: 4,
        nodesExplored: 100,
        elapsedMicroseconds: 200,
      );
      const ab = SearchResult(
        bestMove: 4,
        nodesExplored: 40,
        elapsedMicroseconds: 80,
      );
      final result = BenchmarkResult(
        testCase: correctnessTestCase,
        depth: 3,
        minimaxResult: mm,
        alphaBetaResult: ab,
      );
      expect(result.correctnessVerified, isFalse);
    });

    test('toString returns correct format', () {
      const mm = SearchResult(
        bestMove: 4,
        nodesExplored: 100,
        elapsedMicroseconds: 200,
      );
      const ab = SearchResult(
        bestMove: 4,
        nodesExplored: 40,
        elapsedMicroseconds: 80,
      );
      final result = BenchmarkResult(
        testCase: perfTestCase,
        depth: 3,
        minimaxResult: mm,
        alphaBetaResult: ab,
      );
      expect(
        result.toString(),
        equals(
          'BenchmarkResult(id: E01, depth: 3, mmNodes: 100, abNodes: 40, '
          'pruning: 60.0%, match: true)',
        ),
      );
    });
  });
}
