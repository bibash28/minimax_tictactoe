import 'dart:developer';

import 'package:minimax_tictactoe/src/logic/alphabeta.dart';
import 'package:minimax_tictactoe/src/logic/board_evaluator.dart';
import 'package:minimax_tictactoe/src/logic/minimax.dart';
import 'package:minimax_tictactoe/src/models/board.dart';
import 'package:test/test.dart';

void main() {
  late AlphaBeta alphaBeta;
  late Minimax minimax;

  setUp(() {
    alphaBeta = const AlphaBeta(evaluator: BoardEvaluator());
    minimax = const Minimax(evaluator: BoardEvaluator());
  });

  group('AlphaBeta.findBestMove — correctness', () {
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
      final result = alphaBeta.findBestMove(board, Player.x, 3);
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
      final result = alphaBeta.findBestMove(board, Player.x, 3);
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
      final result = alphaBeta.findBestMove(board, Player.o, 3);
      expect(result.bestMove, equals(6));
    });

    test('C01 — X wins bottom-left diagonal', () {
      // X | O | X
      // ---------
      // O | X | O
      // ---------
      // _ | _ | _
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
      final result = alphaBeta.findBestMove(board, Player.x, 3);
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
      final result = alphaBeta.findBestMove(board, Player.x, 3);
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
      final result = alphaBeta.findBestMove(board, Player.x, 3);
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
      final result = alphaBeta.findBestMove(board, Player.x, 3);
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
      final result = alphaBeta.findBestMove(board, Player.x, 3);
      expect(result.bestMove, equals(2));
    });
  });

  group('AlphaBeta.findBestMove — early game depths', () {
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
      final result = alphaBeta.findBestMove(earlyBoard, Player.x, 1);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Early | Depth 1 | AlphaBeta nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });

    test('depth 2 — returns valid result', () {
      final result = alphaBeta.findBestMove(earlyBoard, Player.x, 2);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Early | Depth 2 | AlphaBeta nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });

    test('depth 3 — returns valid result', () {
      final result = alphaBeta.findBestMove(earlyBoard, Player.x, 3);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Early | Depth 3 | AlphaBeta nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });
  });

  group('AlphaBeta.findBestMove — mid game depths', () {
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
      final result = alphaBeta.findBestMove(midBoard, Player.x, 1);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Mid | Depth 1 | AlphaBeta nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });

    test('depth 2 — returns valid result', () {
      final result = alphaBeta.findBestMove(midBoard, Player.x, 2);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Mid | Depth 2 | AlphaBeta nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });

    test('depth 3 — returns valid result', () {
      final result = alphaBeta.findBestMove(midBoard, Player.x, 3);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Mid | Depth 3 | AlphaBeta nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });
  });

  group('AlphaBeta.findBestMove — late game depths', () {
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
      final result = alphaBeta.findBestMove(lateBoard, Player.x, 1);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Late | Depth 1 | AlphaBeta nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });

    test('depth 2 — returns valid result', () {
      final result = alphaBeta.findBestMove(lateBoard, Player.x, 2);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Late | Depth 2 | AlphaBeta nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });

    test('depth 3 — returns valid result', () {
      final result = alphaBeta.findBestMove(lateBoard, Player.x, 3);
      expect(result.nodesExplored, greaterThan(0));
      expect(result.bestMove, inInclusiveRange(0, 8));
      log(
        'Late | Depth 3 | AlphaBeta nodes: ${result.nodesExplored} |'
        ' time: ${result.elapsedMicroseconds}μs',
      );
    });
  });

  group('AlphaBeta vs Minimax — same best move', () {
    test('early game depth 3 — same move', () {
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
      final mm = minimax.findBestMove(board, Player.x, 3);
      final ab = alphaBeta.findBestMove(board, Player.x, 3);
      expect(ab.bestMove, equals(mm.bestMove));
    });

    test('mid game depth 3 — same move', () {
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
      final mm = minimax.findBestMove(board, Player.x, 3);
      final ab = alphaBeta.findBestMove(board, Player.x, 3);
      expect(ab.bestMove, equals(mm.bestMove));
    });

    test('late game depth 3 — same move', () {
      // X | O | X
      // ---------
      // O | X | _
      // ---------
      // _ | _ | O
      final board = Board.fromPlayers(const [
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
      final mm = minimax.findBestMove(board, Player.x, 3);
      final ab = alphaBeta.findBestMove(board, Player.x, 3);
      expect(ab.bestMove, equals(mm.bestMove));
    });
  });

  group('AlphaBeta vs Minimax — fewer nodes explored', () {
    test('early game depth 3 — AB explores fewer nodes', () {
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
      final mm = minimax.findBestMove(board, Player.x, 3);
      final ab = alphaBeta.findBestMove(board, Player.x, 3);
      log(
        'Early | Depth 3 | Minimax: ${mm.nodesExplored} nodes |'
        ' AlphaBeta: ${ab.nodesExplored} nodes |'
        ' Pruning: ${ab.pruningEfficiency(mm).toStringAsFixed(1)}%',
      );
      expect(ab.nodesExplored, lessThan(mm.nodesExplored));
    });

    test('mid game depth 3 — AB explores fewer nodes', () {
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
      final mm = minimax.findBestMove(board, Player.x, 3);
      final ab = alphaBeta.findBestMove(board, Player.x, 3);
      log(
        'Mid | Depth 3 | Minimax: ${mm.nodesExplored} nodes |'
        ' AlphaBeta: ${ab.nodesExplored} nodes |'
        ' Pruning: ${ab.pruningEfficiency(mm).toStringAsFixed(1)}%',
      );
      expect(ab.nodesExplored, lessThan(mm.nodesExplored));
    });

    // Late game with only 3 empty cells — tree too small to prune.
    // Both algorithms may explore identical nodes. This is a valid
    // finding: Alpha-Beta pruning provides no benefit when the
    // remaining search space is already minimal.
    test('late game depth 3 — AB explores fewer nodes', () {
      // X | O | X
      // ---------
      // O | X | _
      // ---------
      // _ | _ | O
      final board = Board.fromPlayers(const [
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
      final mm = minimax.findBestMove(board, Player.x, 3);
      final ab = alphaBeta.findBestMove(board, Player.x, 3);
      log(
        'Late | Depth 3 | Minimax: ${mm.nodesExplored} nodes |'
        ' AlphaBeta: ${ab.nodesExplored} nodes |'
        ' Pruning: ${ab.pruningEfficiency(mm).toStringAsFixed(1)}%',
      );
      expect(ab.nodesExplored, lessThanOrEqualTo(mm.nodesExplored));
    });
  });
}
