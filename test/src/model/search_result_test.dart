import 'package:minimax_tictactoe/src/models/search_result.dart';
import 'package:test/test.dart';

void main() {
  group('SearchResult', () {
    test('creates with correct values', () {
      const result = SearchResult(
        bestMove: 4,
        nodesExplored: 42,
        elapsedMicroseconds: 120,
      );
      expect(result.bestMove, equals(4));
      expect(result.nodesExplored, equals(42));
      expect(result.elapsedMicroseconds, equals(120));
    });

    test('two results with same values are equal', () {
      const r1 = SearchResult(
        bestMove: 4,
        nodesExplored: 42,
        elapsedMicroseconds: 120,
      );
      const r2 = SearchResult(
        bestMove: 4,
        nodesExplored: 42,
        elapsedMicroseconds: 120,
      );
      expect(r1, equals(r2));
    });

    test('two results with different values are not equal', () {
      const r1 = SearchResult(
        bestMove: 4,
        nodesExplored: 42,
        elapsedMicroseconds: 120,
      );
      const r2 = SearchResult(
        bestMove: 6,
        nodesExplored: 18,
        elapsedMicroseconds: 55,
      );
      expect(r1, isNot(equals(r2)));
    });

    test('hashCode is consistent', () {
      const r1 = SearchResult(
        bestMove: 4,
        nodesExplored: 42,
        elapsedMicroseconds: 120,
      );
      const r2 = SearchResult(
        bestMove: 4,
        nodesExplored: 42,
        elapsedMicroseconds: 120,
      );
      expect(r1.hashCode, equals(r2.hashCode));
    });

    test('toString returns correct format', () {
      const result = SearchResult(
        bestMove: 4,
        nodesExplored: 42,
        elapsedMicroseconds: 120,
      );
      expect(
        result.toString(),
        equals(
          'SearchResult(bestMove: 4, nodesExplored: 42,'
          ' elapsedMicroseconds: 120)',
        ),
      );
    });

    group('pruningEfficiency', () {
      test('returns correct percentage', () {
        const minimax = SearchResult(
          bestMove: 4,
          nodesExplored: 100,
          elapsedMicroseconds: 200,
        );
        const alphaBeta = SearchResult(
          bestMove: 4,
          nodesExplored: 40,
          elapsedMicroseconds: 80,
        );
        expect(alphaBeta.pruningEfficiency(minimax), equals(60.0));
      });

      test('returns 0 when reference has 0 nodes', () {
        const reference = SearchResult(
          bestMove: 4,
          nodesExplored: 0,
          elapsedMicroseconds: 0,
        );
        const result = SearchResult(
          bestMove: 4,
          nodesExplored: 10,
          elapsedMicroseconds: 50,
        );
        expect(result.pruningEfficiency(reference), equals(0));
      });

      test('returns 0 when both have same nodes', () {
        const result = SearchResult(
          bestMove: 4,
          nodesExplored: 42,
          elapsedMicroseconds: 120,
        );
        expect(result.pruningEfficiency(result), equals(0));
      });
    });
  });
}
