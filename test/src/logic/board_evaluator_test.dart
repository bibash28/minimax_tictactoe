import 'package:minimax_tictactoe/src/logic/board_evaluator.dart';
import 'package:minimax_tictactoe/src/models/board.dart';
import 'package:test/test.dart';

void main() {
  late BoardEvaluator evaluator;

  setUp(() {
    evaluator = const BoardEvaluator();
  });

  group('BoardEvaluator.hasWon', () {
    test('returns true for X winning top row', () {
      final board = Board.fromPlayers(const [
        Player.x,
        Player.x,
        Player.x,
        null,
        Player.o,
        null,
        null,
        null,
        Player.o,
      ]);
      expect(evaluator.hasWon(board, Player.x), isTrue);
    });

    test('returns true for O winning left column', () {
      final board = Board.fromPlayers(const [
        Player.o,
        Player.x,
        null,
        Player.o,
        Player.x,
        null,
        Player.o,
        null,
        null,
      ]);
      expect(evaluator.hasWon(board, Player.o), isTrue);
    });

    test('returns true for X winning main diagonal', () {
      final board = Board.fromPlayers(const [
        Player.x,
        null,
        null,
        null,
        Player.x,
        null,
        null,
        null,
        Player.x,
      ]);
      expect(evaluator.hasWon(board, Player.x), isTrue);
    });

    test('returns true for O winning anti diagonal', () {
      final board = Board.fromPlayers(const [
        null,
        null,
        Player.o,
        null,
        Player.o,
        null,
        Player.o,
        null,
        null,
      ]);
      expect(evaluator.hasWon(board, Player.o), isTrue);
    });

    test('returns false when no winner', () {
      final board = Board.fromPlayers(const [
        Player.x,
        Player.o,
        null,
        null,
        Player.x,
        null,
        null,
        null,
        null,
      ]);
      expect(evaluator.hasWon(board, Player.x), isFalse);
      expect(evaluator.hasWon(board, Player.o), isFalse);
    });

    test('returns false on empty board', () {
      expect(evaluator.hasWon(Board.empty(), Player.x), isFalse);
      expect(evaluator.hasWon(Board.empty(), Player.o), isFalse);
    });
  });

  group('BoardEvaluator.isTerminal', () {
    test('returns true when X has won', () {
      final board = Board.fromPlayers(const [
        Player.x,
        Player.x,
        Player.x,
        null,
        Player.o,
        null,
        null,
        null,
        Player.o,
      ]);
      expect(evaluator.isTerminal(board), isTrue);
    });

    test('returns true when board is full', () {
      final board = Board.fromPlayers(const [
        Player.x,
        Player.o,
        Player.x,
        Player.o,
        Player.x,
        Player.o,
        Player.o,
        Player.x,
        Player.o,
      ]);
      expect(evaluator.isTerminal(board), isTrue);
    });

    test('returns false on empty board', () {
      expect(evaluator.isTerminal(Board.empty()), isFalse);
    });

    test('returns false on partial board with no winner', () {
      final board = Board.fromPlayers(const [
        Player.x,
        null,
        null,
        null,
        Player.o,
        null,
        null,
        null,
        null,
      ]);
      expect(evaluator.isTerminal(board), isFalse);
    });
  });

  group('BoardEvaluator.evaluate', () {
    test('returns +10 - depth when X wins', () {
      final board = Board.fromPlayers(const [
        Player.x,
        Player.x,
        Player.x,
        null,
        Player.o,
        null,
        null,
        null,
        Player.o,
      ]);
      expect(evaluator.evaluate(board, 0), equals(10));
      expect(evaluator.evaluate(board, 3), equals(7));
    });

    test('returns -10 + depth when O wins', () {
      final board = Board.fromPlayers(const [
        Player.o,
        Player.o,
        Player.o,
        null,
        Player.x,
        null,
        null,
        null,
        Player.x,
      ]);
      expect(evaluator.evaluate(board, 0), equals(-10));
      expect(evaluator.evaluate(board, 3), equals(-7));
    });

    test('returns 0 for draw', () {
      final board = Board.fromPlayers(const [
        Player.x,
        Player.o,
        Player.x,
        Player.o,
        Player.x,
        Player.o,
        Player.o,
        Player.x,
        Player.o,
      ]);
      expect(evaluator.evaluate(board, 0), equals(0));
    });

    test('returns 0 for non-terminal board', () {
      final board = Board.fromPlayers(const [
        Player.x,
        null,
        null,
        null,
        Player.o,
        null,
        null,
        null,
        null,
      ]);
      expect(evaluator.evaluate(board, 0), equals(0));
    });
  });
}
