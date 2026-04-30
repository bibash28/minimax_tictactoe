import 'package:minimax_tictactoe/src/logic/board_evaluator.dart';
import 'package:minimax_tictactoe/src/models/board.dart';
import 'package:minimax_tictactoe/src/models/search_result.dart';

/// A simple mutable counter for tracking nodes explored during search.
class _NodeCounter {
  /// The current count of nodes explored.
  int value = 0;

  /// Increments the counter by one.
  void increment() => value++;
}

/// Implements the Minimax algorithm for Tic-Tac-Toe.
///
/// Exhaustively searches the game tree up to the given depth
/// and returns the best move for the current player.
/// Time complexity: O(b^d) where b is branching factor and d is depth.
class Minimax {
  /// Creates a [Minimax] instance with the given [evaluator].
  const Minimax({required this.evaluator});

  /// The board evaluator used to detect wins and score terminal states.
  final BoardEvaluator evaluator;

  /// Finds the best move for [player] on [board] at the given [depth].
  ///
  /// Searches the game tree exhaustively up to [depth] levels.
  /// Returns a [SearchResult] containing:
  /// - [SearchResult.bestMove] — the index (0–8) of the best move
  /// - [SearchResult.nodesExplored] — total recursive calls made
  /// - [SearchResult.elapsedMicroseconds] — total search time
  SearchResult findBestMove(Board board, Player player, int depth) {
    final counter = _NodeCounter();
    final stopwatch = Stopwatch()..start();

    var bestScore = player == Player.x
        ? double.negativeInfinity
        : double.infinity;
    var bestMove = -1;

    for (final index in board.emptyCellIndices) {
      final newBoard = board.place(index, player);
      final score = _minimax(
        newBoard,
        depth - 1,
        player != Player.x,
        counter,
      );

      if (player == Player.x && score > bestScore) {
        bestScore = score.toDouble();
        bestMove = index;
      } else if (player == Player.o && score < bestScore) {
        bestScore = score.toDouble();
        bestMove = index;
      }
    }

    stopwatch.stop();

    return SearchResult(
      bestMove: bestMove,
      nodesExplored: counter.value,
      elapsedMicroseconds: stopwatch.elapsedMicroseconds,
    );
  }

  /// Recursively searches the game tree and returns the best score.
  ///
  /// [board] — current board state
  /// [depth] — remaining search depth
  /// [isMaximizing] — true when it is X's turn (maximizing player)
  /// [counter] — mutable node counter incremented on every call
  int _minimax(
    Board board,
    int depth,
    bool isMaximizing,
    _NodeCounter counter,
  ) {
    counter.increment();

    if (evaluator.isTerminal(board) || depth == 0) {
      return evaluator.evaluate(board, depth);
    }

    if (isMaximizing) {
      var best = -1000;
      for (final index in board.emptyCellIndices) {
        final newBoard = board.place(index, Player.x);
        final score = _minimax(newBoard, depth - 1, false, counter);
        if (score > best) best = score;
      }
      return best;
    } else {
      var best = 1000;
      for (final index in board.emptyCellIndices) {
        final newBoard = board.place(index, Player.o);
        final score = _minimax(newBoard, depth - 1, true, counter);
        if (score < best) best = score;
      }
      return best;
    }
  }
}
