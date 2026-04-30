import 'package:minimax_tictactoe/src/models/board.dart';
import 'package:minimax_tictactoe/src/models/test_case.dart';
import 'package:test/test.dart';

void main() {
  group('GameStage', () {
    test('label is capitalized', () {
      expect(GameStage.early.label, equals('Early'));
      expect(GameStage.mid.label, equals('Mid'));
      expect(GameStage.late.label, equals('Late'));
      expect(GameStage.correctness.label, equals('Correctness'));
    });
  });

  group('TestCase', () {
    test('creates with correct values', () {
      final testCase = TestCase(
        id: 'E01',
        board: Board.empty(),
        player: Player.x,
        stage: GameStage.early,
      );
      expect(testCase.id, equals('E01'));
      expect(testCase.player, equals(Player.x));
      expect(testCase.stage, equals(GameStage.early));
      expect(testCase.expectedMove, isNull);
    });

    test('isCorrectnessTest is false when expectedMove is null', () {
      final testCase = TestCase(
        id: 'E01',
        board: Board.empty(),
        player: Player.x,
        stage: GameStage.early,
      );
      expect(testCase.isCorrectnessTest, isFalse);
    });

    test('isCorrectnessTest is true when expectedMove is set', () {
      final testCase = TestCase(
        id: 'C01',
        board: Board.empty(),
        player: Player.x,
        stage: GameStage.correctness,
        expectedMove: 6,
      );
      expect(testCase.isCorrectnessTest, isTrue);
      expect(testCase.expectedMove, equals(6));
    });

    test('toString returns correct format', () {
      final testCase = TestCase(
        id: 'M03',
        board: Board.empty(),
        player: Player.x,
        stage: GameStage.mid,
      );
      expect(testCase.toString(), equals('TestCase(id: M03, stage: Mid)'));
    });
  });
}
