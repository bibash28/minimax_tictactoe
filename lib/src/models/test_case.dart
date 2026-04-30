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

  /// Correctness verification — has a clear expected best move.
  correctness
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
    this.expectedMove,
  });

  /// Unique identifier for this test case (e.g. 'E01', 'M03', 'C01').
  final String id;

  /// The board configuration for this test case.
  final Board board;

  /// The player to move in this test case.
  final Player player;

  /// The game stage this test case represents.
  final GameStage stage;

  /// The expected best move index for correctness verification.
  ///
  /// Only set for [GameStage.correctness] test cases.
  /// Null for performance test cases.
  final int? expectedMove;

  /// Returns true if this is a correctness verification test case.
  bool get isCorrectnessTest => expectedMove != null;

  @override
  String toString() => 'TestCase(id: $id, stage: ${stage.label})';
}
