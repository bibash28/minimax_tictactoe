import 'dart:developer';
import 'package:minimax_tictactoe/src/logic/board_evaluator.dart';
import 'package:minimax_tictactoe/src/logic/minimax.dart';
import 'package:minimax_tictactoe/src/models/board.dart';
import 'package:test/test.dart';

void main() {
  late Minimax minimax;

  setUp(() {
    minimax = const Minimax(evaluator: BoardEvaluator());
  });

  group('Minimax.findBestMove — correctness', () {
    test('finds winning move for X — top row', () {
      // X | X | _
      // ---------
      // O | O | _
      // ---------
      // _ | _ | _
      // X must win at index 2
      final board = Board.fromPlayers(const [
        Player.x,
        Player.x,
        null,
        Player.o,
        Player.o,
        null,
        null,
        null,
        null,
      ]);
      final result = minimax.findBestMove(board, Player.x, 3);
      expect(result.bestMove, equals(2));
    });

    test('blocks O from winning — row 1', () {
      // X | _ | _
      // ---------
      // O | O | _
      // ---------
      // X | _ | _
      // X must block at index 5
      final board = Board.fromPlayers(const [
        Player.x,
        null,
        null,
        Player.o,
        Player.o,
        null,
        Player.x,
        null,
        null,
      ]);
      final result = minimax.findBestMove(board, Player.x, 3);
      expect(result.bestMove, equals(5));
    });

    test('finds winning move for O — left column', () {
      // O | X | _
      // ---------
      // O | X | _
      // ---------
      // _ | _ | _
      // O must win at index 6
      final board = Board.fromPlayers(const [
        Player.o,
        Player.x,
        null,
        Player.o,
        Player.x,
        null,
        null,
        null,
        null,
      ]);
      final result = minimax.findBestMove(board, Player.o, 3);
      expect(result.bestMove, equals(6));
    });

    test('C01 — X wins bottom-left diagonal', () {
      // X | O | X
      // ---------
      // O | X | O
      // ---------
      // _ | _ | _
      // X wins diagonal at index 7
      final board = Board.fromPlayers(const [
        Player.x,
        Player.o,
        Player.x,
        Player.o,
        Player.x,
        Player.o,
        null,
        null,
        null,
      ]);
      final result = minimax.findBestMove(board, Player.x, 3);
      expect(result.bestMove, equals(7));
    });

    test('C02 — X blocks O from winning row 1', () {
      // X | _ | _
      // ---------
      // O | O | _
      // ---------
      // X | _ | _
      // X must block at index 5
      final board = Board.fromPlayers(const [
        Player.x,
        null,
        null,
        Player.o,
        Player.o,
        null,
        Player.x,
        null,
        null,
      ]);
      final result = minimax.findBestMove(board, Player.x, 3);
      expect(result.bestMove, equals(5));
    });

    test('C03 — X wins column 0', () {
      // X | O | _
      // ---------
      // X | O | _
      // ---------
      // _ | _ | _
      // X wins column 0 at index 6
      final board = Board.fromPlayers(const [
        Player.x,
        Player.o,
        null,
        Player.x,
        Player.o,
        null,
        null,
        null,
        null,
      ]);
      final result = minimax.findBestMove(board, Player.x, 3);
      expect(result.bestMove, equals(6));
    });

    test('C04 — X blocks O diagonal win', () {
      // O | X | _
      // ---------
      // _ | O | _
      // ---------
      // X | _ | _
      // X must block O diagonal at index 8
      final board = Board.fromPlayers(const [
        Player.o,
        Player.x,
        null,
        null,
        Player.o,
        null,
        Player.x,
        null,
        null,
      ]);
      final result = minimax.findBestMove(board, Player.x, 3);
      expect(result.bestMove, equals(8));
    });

    test('C05 — X wins row 0', () {
      // X | X | _
      // ---------
      // O | O | _
      // ---------
      // _ | _ | X
      // X wins row 0 at index 2
      final board = Board.fromPlayers(const [
        Player.x,
        Player.x,
        null,
        Player.o,
        Player.o,
        null,
        null,
        null,
        Player.x,
      ]);
      final result = minimax.findBestMove(board, Player.x, 3);
      expect(result.bestMove, equals(2));
    });
  });

  group('Minimax.findBestMove — early game depths', () {
    // X | _ | _
    // ---------
    // _ | O | _
    // ---------
    // _ | _ | _
    final earlyBoard = Board.fromPlayers(const [
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

    test('depth 1 — returns valid result', () {
      final result = minimax.findBestMove(earlyBoard, Player.x, 1);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Early | Depth 1 | Minimax nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });

    test('depth 2 — returns valid result', () {
      final result = minimax.findBestMove(earlyBoard, Player.x, 2);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Early | Depth 2 | Minimax nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });

    test('depth 3 — returns valid result', () {
      final result = minimax.findBestMove(earlyBoard, Player.x, 3);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Early | Depth 3 | Minimax nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });
  });

  group('Minimax.findBestMove — mid game depths', () {
    // X | O | _
    // ---------
    // _ | X | _
    // ---------
    // O | _ | _
    final midBoard = Board.fromPlayers(const [
      Player.x,
      Player.o,
      null,
      null,
      Player.x,
      null,
      Player.o,
      null,
      null,
    ]);

    test('depth 1 — returns valid result', () {
      final result = minimax.findBestMove(midBoard, Player.x, 1);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Mid | Depth 1 | Minimax nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });

    test('depth 2 — returns valid result', () {
      final result = minimax.findBestMove(midBoard, Player.x, 2);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Mid | Depth 2 | Minimax nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });

    test('depth 3 — returns valid result', () {
      final result = minimax.findBestMove(midBoard, Player.x, 3);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Mid | Depth 3 | Minimax nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });
  });

  group('Minimax.findBestMove — late game depths', () {
    // X | O | X
    // ---------
    // O | X | _
    // ---------
    // _ | _ | O
    final lateBoard = Board.fromPlayers(const [
      Player.x,
      Player.o,
      Player.x,
      Player.o,
      Player.x,
      null,
      null,
      null,
      Player.o,
    ]);

    test('depth 1 — returns valid result', () {
      final result = minimax.findBestMove(lateBoard, Player.x, 1);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Late | Depth 1 | Minimax nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });

    test('depth 2 — returns valid result', () {
      final result = minimax.findBestMove(lateBoard, Player.x, 2);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Late | Depth 2 | Minimax nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });

    test('depth 3 — returns valid result', () {
      final result = minimax.findBestMove(lateBoard, Player.x, 3);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Late | Depth 3 | Minimax nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });
  });

  group('Minimax.findBestMove — node count increases with depth', () {
    test('early game: depth 1 < depth 2 < depth 3', () {
      // X | _ | _
      // ---------
      // _ | O | _
      // ---------
      // _ | _ | _
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
      final d1 = minimax.findBestMove(board, Player.x, 1);
      final d2 = minimax.findBestMove(board, Player.x, 2);
      final d3 = minimax.findBestMove(board, Player.x, 3);
      expect(d1.nodesExplored, lessThan(d2.nodesExplored));
      expect(d2.nodesExplored, lessThan(d3.nodesExplored));
    });

    test('mid game: depth 1 < depth 2 < depth 3', () {
      // X | O | _
      // ---------
      // _ | X | _
      // ---------
      // O | _ | _
      final board = Board.fromPlayers(const [
        Player.x,
        Player.o,
        null,
        null,
        Player.x,
        null,
        Player.o,
        null,
        null,
      ]);
      final d1 = minimax.findBestMove(board, Player.x, 1);
      final d2 = minimax.findBestMove(board, Player.x, 2);
      final d3 = minimax.findBestMove(board, Player.x, 3);
      expect(d1.nodesExplored, lessThan(d2.nodesExplored));
      expect(d2.nodesExplored, lessThan(d3.nodesExplored));
    });
  });
}
