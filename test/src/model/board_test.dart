import 'package:minimax_tictactoe/src/models/board.dart';
import 'package:test/test.dart';

void main() {
  group('Player', () {
    test('x symbol is X', () {
      expect(Player.x.symbol, equals('X'));
    });

    test('o symbol is O', () {
      expect(Player.o.symbol, equals('O'));
    });

    test('opponent of x is o', () {
      expect(Player.x.opponent, equals(Player.o));
    });

    test('opponent of o is x', () {
      expect(Player.o.opponent, equals(Player.x));
    });
  });

  group('Cell', () {
    test('empty cell is empty', () {
      const cell = Cell.empty();
      expect(cell.isEmpty, isTrue);
      expect(cell.isOccupied, isFalse);
      expect(cell.symbol, equals('.'));
    });

    test('occupied cell is occupied', () {
      const cell = Cell.occupied(Player.x);
      expect(cell.isOccupied, isTrue);
      expect(cell.isEmpty, isFalse);
      expect(cell.symbol, equals('X'));
    });

    test('two empty cells are equal', () {
      expect(const Cell.empty(), equals(const Cell.empty()));
    });

    test('two cells with same player are equal', () {
      expect(
        const Cell.occupied(Player.x),
        equals(const Cell.occupied(Player.x)),
      );
    });

    test('cells with different players are not equal', () {
      expect(
        const Cell.occupied(Player.x),
        isNot(equals(const Cell.occupied(Player.o))),
      );
    });

    test('toString returns symbol', () {
      expect(const Cell.empty().toString(), equals('.'));
      expect(const Cell.occupied(Player.x).toString(), equals('X'));
      expect(const Cell.occupied(Player.o).toString(), equals('O'));
    });

    test('hashCode is consistent', () {
      const cell1 = Cell.empty();
      const cell2 = Cell.empty();
      expect(cell1.hashCode, equals(cell2.hashCode));

      const cell3 = Cell.occupied(Player.x);
      const cell4 = Cell.occupied(Player.x);
      expect(cell3.hashCode, equals(cell4.hashCode));
    });
  });

  group('Board', () {
    test('empty board has 9 empty cells', () {
      final board = Board.empty();
      expect(board.cells.length, equals(9));
      expect(board.cells.every((c) => c.isEmpty), isTrue);
    });

    test('empty board is not full', () {
      expect(Board.empty().isFull, isFalse);
    });

    test('full board is full', () {
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
      expect(board.isFull, isTrue);
    });

    test('emptyCellIndices returns all 9 on empty board', () {
      final board = Board.empty();
      expect(board.emptyCellIndices, equals([0, 1, 2, 3, 4, 5, 6, 7, 8]));
    });

    test('emptyCellIndices excludes occupied cells', () {
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
      expect(board.emptyCellIndices, equals([1, 2, 3, 5, 6, 7, 8]));
    });

    test('place returns new board with player at index', () {
      final board = Board.empty();
      final updated = board.place(4, Player.x);
      expect(updated.cellAt(4).player, equals(Player.x));
      expect(board.cellAt(4).isEmpty, isTrue);
    });

    test('clear returns new board with cell emptied', () {
      final board = Board.fromPlayers(const [
        Player.x,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
      ]);
      final cleared = board.clear(0);
      expect(cleared.cellAt(0).isEmpty, isTrue);
      expect(board.cellAt(0).isOccupied, isTrue);
    });

    test('fromPlayers creates correct board', () {
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
      expect(board.cellAt(0).player, equals(Player.x));
      expect(board.cellAt(4).player, equals(Player.o));
      expect(board.cellAt(1).isEmpty, isTrue);
    });

    test('toString returns joined cell symbols', () {
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
      expect(board.toString(), equals('X...O....'));
    });

    test('toString on empty board returns all dots', () {
      expect(Board.empty().toString(), equals('.........'));
    });
  });
}
