import 'package:meta/meta.dart';

/// Represents the two players in the game.
enum Player {
  /// The X player — always the maximizing player.
  x,

  /// The O player — always the minimizing player.
  o
  ;

  /// Returns the string symbol for this player.
  String get symbol => name.toUpperCase();

  /// Returns the opposing player.
  Player get opponent => this == Player.x ? Player.o : Player.x;
}

/// Represents a single cell on the board.
///
/// A cell is either occupied by a [Player] or empty.
@immutable
class Cell {
  /// Creates an empty cell.
  const Cell.empty() : player = null;

  /// Creates a cell occupied by [player].
  const Cell.occupied(this.player);

  /// The player occupying this cell, or null if empty.
  final Player? player;

  /// Returns true if this cell is not occupied.
  bool get isEmpty => player == null;

  /// Returns true if this cell is occupied.
  bool get isOccupied => player != null;

  /// Returns the display symbol for this cell.
  String get symbol => player?.symbol ?? '.';

  @override
  String toString() => symbol;

  @override
  bool operator ==(Object other) => other is Cell && other.player == player;

  @override
  int get hashCode => player.hashCode;
}

/// Represents the 3x3 Tic-Tac-Toe board.
///
/// The board is indexed as follows:
///
/// 0 | 1 | 2
/// ---------
/// 3 | 4 | 5
/// ---------
/// 6 | 7 | 8
///
@immutable
class Board {
  /// Creates a board from a list of 9 [Cell] values.
  const Board(this.cells);

  /// Creates an empty board with all cells unoccupied.
  factory Board.empty() {
    return Board(List.filled(9, const Cell.empty()));
  }

  /// Creates a board from a list of nullable [Player] values.
  ///
  /// Useful for constructing test boards quickly.
  /// Example:
  /// ```dart
  /// Board.fromPlayers([Player.x, null, null, null, Player.o, ...])
  /// ```
  factory Board.fromPlayers(List<Player?> players) {
    return Board(
      players
          .map((p) => p == null ? const Cell.empty() : Cell.occupied(p))
          .toList(growable: false),
    );
  }

  /// The 9 cells of this board.
  final List<Cell> cells;

  /// All winning line index combinations.
  static const List<List<int>> winLines = [
    [0, 1, 2], // top row
    [3, 4, 5], // mid row
    [6, 7, 8], // bot row
    [0, 3, 6], // left col
    [1, 4, 7], // mid col
    [2, 5, 8], // right col
    [0, 4, 8], // main diagonal
    [2, 4, 6], // anti diagonal
  ];

  /// Returns the cell at [index].
  Cell cellAt(int index) => cells[index];

  /// Returns the indices of all empty cells.
  List<int> get emptyCellIndices {
    return [
      for (int i = 0; i < cells.length; i++)
        if (cells[i].isEmpty) i,
    ];
  }

  /// Returns true if there are no empty cells.
  bool get isFull => cells.every((c) => c.isOccupied);

  /// Returns a new board with [player] placed at [index].
  ///
  /// Does not modify the original board.
  Board place(int index, Player player) {
    final updated = List<Cell>.of(cells);
    updated[index] = Cell.occupied(player);
    return Board(updated);
  }

  /// Returns a new board with the cell at [index] cleared.
  ///
  /// Does not modify the original board.
  Board clear(int index) {
    final updated = List<Cell>.of(cells);
    updated[index] = const Cell.empty();
    return Board(updated);
  }

  @override
  String toString() {
    return cells.map((c) => c.symbol).join();
  }
}
