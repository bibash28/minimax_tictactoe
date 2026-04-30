import 'package:minimax_tictactoe/src/models/board.dart';
import 'package:minimax_tictactoe/src/models/test_case.dart';

/// All 20 predefined test cases for the benchmark.
///
/// Organized into four categories:
/// - Early game (E01–E05): 2 cells filled
/// - Mid game (M01–M05): 4 cells filled
/// - Late game (L01–L05): 6 cells filled
/// - Correctness (C01–C05): known expected best move
class TestCases {
  // ── Early game boards ────────────────────────────────────────
  // 2 cells filled — large search tree, minimal pruning expected

  /// E01
  /// X | _ | _
  /// ---------
  /// _ | O | _
  /// ---------
  /// _ | _ | _
  static final e01 = TestCase(
    id: 'E01',
    stage: GameStage.early,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      null,
      null,
      null,
      Player.o,
      null,
      null,
      null,
      null,
    ]),
  );

  /// E02
  /// _ | X | _
  /// ---------
  /// _ | _ | O
  /// ---------
  /// _ | _ | _
  static final e02 = TestCase(
    id: 'E02',
    stage: GameStage.early,
    player: Player.x,
    board: Board.fromPlayers(const [
      null,
      Player.x,
      null,
      null,
      null,
      Player.o,
      null,
      null,
      null,
    ]),
  );

  /// E03
  /// _ | _ | X
  /// ---------
  /// _ | O | _
  /// ---------
  /// _ | _ | _
  static final e03 = TestCase(
    id: 'E03',
    stage: GameStage.early,
    player: Player.x,
    board: Board.fromPlayers(const [
      null,
      null,
      Player.x,
      null,
      Player.o,
      null,
      null,
      null,
      null,
    ]),
  );

  /// E04
  /// O | _ | _
  /// ---------
  /// _ | X | _
  /// ---------
  /// _ | _ | _
  static final e04 = TestCase(
    id: 'E04',
    stage: GameStage.early,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.o,
      null,
      null,
      null,
      Player.x,
      null,
      null,
      null,
      null,
    ]),
  );

  /// E05
  /// _ | _ | _
  /// ---------
  /// X | _ | _
  /// ---------
  /// _ | O | _
  static final e05 = TestCase(
    id: 'E05',
    stage: GameStage.early,
    player: Player.x,
    board: Board.fromPlayers(const [
      null,
      null,
      null,
      Player.x,
      null,
      null,
      null,
      Player.o,
      null,
    ]),
  );

  // ── Mid game boards ──────────────────────────────────────────
  // 4 cells filled — moderate search tree, some forced moves

  /// M01
  /// X | O | _
  /// ---------
  /// _ | X | _
  /// ---------
  /// O | _ | _
  static final m01 = TestCase(
    id: 'M01',
    stage: GameStage.mid,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      Player.o,
      null,
      null,
      Player.x,
      null,
      Player.o,
      null,
      null,
    ]),
  );

  /// M02
  /// X | _ | O
  /// ---------
  /// _ | O | _
  /// ---------
  /// X | _ | _
  static final m02 = TestCase(
    id: 'M02',
    stage: GameStage.mid,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      null,
      Player.o,
      null,
      Player.o,
      null,
      Player.x,
      null,
      null,
    ]),
  );

  /// M03
  /// _ | O | X
  /// ---------
  /// X | _ | _
  /// ---------
  /// _ | O | _
  static final m03 = TestCase(
    id: 'M03',
    stage: GameStage.mid,
    player: Player.x,
    board: Board.fromPlayers(const [
      null,
      Player.o,
      Player.x,
      Player.x,
      null,
      null,
      null,
      Player.o,
      null,
    ]),
  );

  /// M04
  /// O | X | _
  /// ---------
  /// _ | _ | O
  /// ---------
  /// _ | X | _
  static final m04 = TestCase(
    id: 'M04',
    stage: GameStage.mid,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.o,
      Player.x,
      null,
      null,
      null,
      Player.o,
      null,
      Player.x,
      null,
    ]),
  );

  /// M05
  /// X | _ | _
  /// ---------
  /// O | X | _
  /// ---------
  /// _ | _ | O
  static final m05 = TestCase(
    id: 'M05',
    stage: GameStage.mid,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      null,
      null,
      Player.o,
      Player.x,
      null,
      null,
      null,
      Player.o,
    ]),
  );

  // ── Late game boards ─────────────────────────────────────────
  // 6 cells filled — small search tree, maximum pruning expected

  /// L01
  /// X | O | X
  /// ---------
  /// O | X | _
  /// ---------
  /// _ | _ | O
  static final l01 = TestCase(
    id: 'L01',
    stage: GameStage.late,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      Player.o,
      Player.x,
      Player.o,
      Player.x,
      null,
      null,
      null,
      Player.o,
    ]),
  );

  /// L02
  /// O | X | O
  /// ---------
  /// X | _ | X
  /// ---------
  /// O | _ | _
  static final l02 = TestCase(
    id: 'L02',
    stage: GameStage.late,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.o,
      Player.x,
      Player.o,
      Player.x,
      null,
      Player.x,
      Player.o,
      null,
      null,
    ]),
  );

  /// L03
  /// X | O | _
  /// ---------
  /// O | X | O
  /// ---------
  /// X | _ | _
  static final l03 = TestCase(
    id: 'L03',
    stage: GameStage.late,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      Player.o,
      null,
      Player.o,
      Player.x,
      Player.o,
      Player.x,
      null,
      null,
    ]),
  );

  /// L04
  /// _ | O | X
  /// ---------
  /// O | X | _
  /// ---------
  /// X | _ | O
  static final l04 = TestCase(
    id: 'L04',
    stage: GameStage.late,
    player: Player.x,
    board: Board.fromPlayers(const [
      null,
      Player.o,
      Player.x,
      Player.o,
      Player.x,
      null,
      Player.x,
      null,
      Player.o,
    ]),
  );

  /// L05
  /// X | _ | O
  /// ---------
  /// _ | O | X
  /// ---------
  /// X | O | _
  static final l05 = TestCase(
    id: 'L05',
    stage: GameStage.late,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      null,
      Player.o,
      null,
      Player.o,
      Player.x,
      Player.x,
      Player.o,
      null,
    ]),
  );

  // ── Correctness boards ───────────────────────────────────────
  // Known expected best move — both algorithms must agree

  /// C01
  /// X | O | X
  /// ---------
  /// O | X | O
  /// ---------
  /// _ | _ | _
  /// X wins bottom-left diagonal — expected move: 6
  static final c01 = TestCase(
    id: 'C01',
    stage: GameStage.correctness,
    player: Player.x,
    expectedMove: 7,
    board: Board.fromPlayers(const [
      Player.x,
      Player.o,
      Player.x,
      Player.o,
      Player.x,
      Player.o,
      null,
      null,
      null,
    ]),
  );

  /// C02
  /// X | _ | _
  /// ---------
  /// O | O | _
  /// ---------
  /// X | _ | _
  /// X must block O from winning row 1 — expected move: 5
  static final c02 = TestCase(
    id: 'C02',
    stage: GameStage.correctness,
    player: Player.x,
    expectedMove: 5,
    board: Board.fromPlayers(const [
      Player.x,
      null,
      null,
      Player.o,
      Player.o,
      null,
      Player.x,
      null,
      null,
    ]),
  );

  /// C03
  /// X | O | _
  /// ---------
  /// X | O | _
  /// ---------
  /// _ | _ | _
  /// X wins column 0 — expected move: 6
  static final c03 = TestCase(
    id: 'C03',
    stage: GameStage.correctness,
    player: Player.x,
    expectedMove: 6,
    board: Board.fromPlayers(const [
      Player.x,
      Player.o,
      null,
      Player.x,
      Player.o,
      null,
      null,
      null,
      null,
    ]),
  );

  /// C04
  /// O | X | _
  /// ---------
  /// _ | O | _
  /// ---------
  /// X | _ | _
  /// X must block O diagonal — expected move: 8
  static final c04 = TestCase(
    id: 'C04',
    stage: GameStage.correctness,
    player: Player.x,
    expectedMove: 8,
    board: Board.fromPlayers(const [
      Player.o,
      Player.x,
      null,
      null,
      Player.o,
      null,
      Player.x,
      null,
      null,
    ]),
  );

  /// C05
  /// X | X | _
  /// ---------
  /// O | O | _
  /// ---------
  /// _ | _ | X
  /// X wins row 0 — expected move: 2
  static final c05 = TestCase(
    id: 'C05',
    stage: GameStage.correctness,
    player: Player.x,
    expectedMove: 2,
    board: Board.fromPlayers(const [
      Player.x,
      Player.x,
      null,
      Player.o,
      Player.o,
      null,
      null,
      null,
      Player.x,
    ]),
  );

  /// All early game test cases.
  static final List<TestCase> earlyGame = [e01, e02, e03, e04, e05];

  /// All mid game test cases.
  static final List<TestCase> midGame = [m01, m02, m03, m04, m05];

  /// All late game test cases.
  static final List<TestCase> lateGame = [l01, l02, l03, l04, l05];

  /// All correctness test cases.
  static final List<TestCase> correctness = [c01, c02, c03, c04, c05];

  /// All 20 test cases combined.
  static final List<TestCase> all = [
    ...earlyGame,
    ...midGame,
    ...lateGame,
    ...correctness,
  ];
}
