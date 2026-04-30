import 'package:minimax_tictactoe/src/models/board.dart';

/// Evaluates the state of a [Board] to determine game outcome.
///
/// Responsible for win detection, draw detection, and
/// assigning numerical scores to terminal board states.
class BoardEvaluator {
  /// Creates a [BoardEvaluator].
  const BoardEvaluator();

  /// Returns true if [player] has won on [board].
  bool hasWon(Board board, Player player) {
    for (final line in Board.winLines) {
      if (board.cellAt(line[0]).player == player &&
          board.cellAt(line[1]).player == player &&
          board.cellAt(line[2]).player == player) {
        return true;
      }
    }
    return false;
  }

  /// Returns true if the game is over.
  ///
  /// The game is over when either player has won or the board is full.
  bool isTerminal(Board board) {
    return hasWon(board, Player.x) || hasWon(board, Player.o) || board.isFull;
  }

  /// Returns the score of a terminal board state at the given [depth].
  ///
  /// - Returns +10 - depth if X has won (faster wins score higher).
  /// - Returns -10 + depth if O has won (faster losses score lower).
  /// - Returns 0 for a draw or non-terminal state.
  int evaluate(Board board, int depth) {
    if (hasWon(board, Player.x)) return 10 - depth;
    if (hasWon(board, Player.o)) return -10 + depth;
    return 0;
  }
}
