import 'package:minimax_tictactoe/src/models/test_case.dart';
import 'package:minimax_tictactoe/src/runner/test_cases.dart';
import 'package:test/test.dart';

void main() {
  group('TestCases', () {
    test('has 5 early game cases', () {
      expect(TestCases.earlyGame.length, equals(5));
    });

    test('has 8 mid game cases', () {
      expect(TestCases.midGame.length, equals(8));
    });

    test('has 8 late game cases', () {
      expect(TestCases.lateGame.length, equals(8));
    });

    test('has 21 total cases', () {
      expect(TestCases.all.length, equals(21));
    });

    test('21 cases × 3 depths = 63 runs', () {
      expect(TestCases.all.length * 3, equals(63));
    });

    test('all early game cases have 2 cells filled', () {
      for (final tc in TestCases.earlyGame) {
        final filled = tc.board.cells.where((c) => c.isOccupied).length;
        expect(
          filled,
          equals(2),
          reason: '${tc.id} should have 2 cells filled',
        );
      }
    });

    test('all mid game cases have 4 cells filled', () {
      for (final tc in TestCases.midGame) {
        final filled = tc.board.cells.where((c) => c.isOccupied).length;
        expect(
          filled,
          equals(4),
          reason: '${tc.id} should have 4 cells filled',
        );
      }
    });

    test('all late game cases have 6 cells filled', () {
      for (final tc in TestCases.lateGame) {
        final filled = tc.board.cells.where((c) => c.isOccupied).length;
        expect(
          filled,
          equals(6), // ← make sure this says 6, not 5
          reason: '${tc.id} should have 6 cells filled',
        );
      }
    });

    test('all cases have unique ids', () {
      final ids = TestCases.all.map((tc) => tc.id).toList();
      expect(ids.toSet().length, equals(ids.length));
    });

    test('all stages are correctly assigned', () {
      for (final tc in TestCases.earlyGame) {
        expect(tc.stage, equals(GameStage.early));
      }
      for (final tc in TestCases.midGame) {
        expect(tc.stage, equals(GameStage.mid));
      }
      for (final tc in TestCases.lateGame) {
        expect(tc.stage, equals(GameStage.late));
      }
    });
  });
}
