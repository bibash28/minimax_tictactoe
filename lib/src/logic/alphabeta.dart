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

/// Implements the Alpha-Beta Pruning algorithm for Tic-Tac-Toe.
///
/// An optimized version of Minimax that prunes branches which
/// cannot possibly affect the final decision, reducing nodes explored
/// without changing the result.
///
/// Best case time complexity: O(b^(d/2))
/// Average case time complexity: O(b^(3d/4))
/// Worst case time complexity: O(b^d) — same as Minimax
class AlphaBeta {
  /// Creates an [AlphaBeta] instance with the given [evaluator].
  const AlphaBeta({required this.evaluator});

  /// The board evaluator used to detect wins and score terminal states.
  final BoardEvaluator evaluator;

  /// Finds the best move for [player] on [board] at the given [depth].
  ///
  /// Uses Alpha-Beta Pruning to skip branches that cannot affect
  /// the final result. Always returns the same [SearchResult.bestMove]
  /// as Minimax.findBestMove but with fewer [SearchResult.nodesExplored].
  SearchResult findBestMove(Board board, Player player, int depth) {
    final counter = _NodeCounter();
    final stopwatch = Stopwatch()..start();

    var bestScore = player == Player.x
        ? double.negativeInfinity
        : double.infinity;
    var bestMove = -1;

    var alpha = double.negativeInfinity;
    var beta = double.infinity;

    for (final index in board.emptyCellIndices) {
      final newBoard = board.place(index, player);
      final score = _alphaBeta(
        newBoard,
        depth - 1,
        alpha,
        beta,
        player != Player.x,
        counter,
      );

      if (player == Player.x && score > bestScore) {
        bestScore = score.toDouble();
        bestMove = index;
        alpha = bestScore;
      } else if (player == Player.o && score < bestScore) {
        bestScore = score.toDouble();
        bestMove = index;
        beta = bestScore;
      }
    }

    stopwatch.stop();

    return SearchResult(
      bestMove: bestMove,
      nodesExplored: counter.value,
      elapsedMicroseconds: stopwatch.elapsedMicroseconds,
    );
  }

  /// Recursively searches the game tree with Alpha-Beta Pruning.
  ///
  /// [board] — current board state
  /// [depth] — remaining search depth
  /// [alpha] — best score the maximizer can guarantee so far
  /// [beta] — best score the minimizer can guarantee so far
  /// [isMaximizing] — true when it is X's turn (maximizing player)
  /// [counter] — mutable node counter incremented on every call
  ///
  /// When [beta] <= [alpha], the current branch is pruned (cutoff).
  int _alphaBeta(
    Board board,
    int depth,
    double alpha,
    double beta,
    bool isMaximizing,
    _NodeCounter counter,
  ) {
    counter.increment();

    if (evaluator.isTerminal(board) || depth == 0) {
      return evaluator.evaluate(board, depth);
    }

    if (isMaximizing) {
      var best = -1000;
      var localAlpha = alpha;
      for (final index in board.emptyCellIndices) {
        final newBoard = board.place(index, Player.x);
        final score = _alphaBeta(
          newBoard,
          depth - 1,
          alpha,
          beta,
          false,
          counter,
        );
        if (score > best) best = score;
        if (best > localAlpha) localAlpha = best.toDouble();

        // Beta cutoff — minimizer would never allow this branch
        if (beta <= localAlpha) break;
      }
      return best;
    } else {
      var best = 1000;

      var localBeta = beta;
      for (final index in board.emptyCellIndices) {
        final newBoard = board.place(index, Player.o);
        final score = _alphaBeta(
          newBoard,
          depth - 1,
          alpha,
          beta,
          true,
          counter,
        );
        if (score < best) best = score;
        if (best < localBeta) localBeta = best.toDouble();

        // Alpha cutoff — maximizer would never allow this branch
        if (localBeta <= alpha) break;
      }
      return best;
    }
  }
}
