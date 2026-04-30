import 'package:meta/meta.dart';
import 'package:minimax_tictactoe/src/models/board.dart';

/// Represents the game stage of a test case.
enum GameStage {
  /// Early game — 2 cells filled, large search tree.
  early,

  /// Mid game — 4 cells filled, moderate search tree.
  mid,

  /// Late game — 6 cells filled, small search tree.
  late,
  ;

  /// Returns a display label for this stage.
  String get label => name[0].toUpperCase() + name.substring(1);
}

/// Represents a single benchmark test case.
///
/// Contains the board configuration, the player to move,
/// the game stage, and an optional expected best move
/// for correctness verification.
@immutable
class TestCase {
  /// Creates a [TestCase] with the given values.
  const TestCase({
    required this.id,
    required this.board,
    required this.player,
    required this.stage,
  });

  /// Unique identifier for this test case (e.g. 'E01', 'M03', 'C01').
  final String id;

  /// The board configuration for this test case.
  final Board board;

  /// The player to move in this test case.
  final Player player;

  /// The game stage this test case represents.
  final GameStage stage;

  @override
  String toString() => 'TestCase(id: $id, stage: ${stage.label})';
}
