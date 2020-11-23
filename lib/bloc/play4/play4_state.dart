import 'package:equatable/equatable.dart';
import 'package:game/models/board.dart';
import '../../models/board.dart';


abstract class Play4State extends Equatable{
  final Board board;
  final List<int> previousBoard;
  const Play4State(this.board, this.previousBoard);

  @override
  List<Object> get props => [board];
}

class PlayInitial4 extends Play4State {
  const PlayInitial4(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlayStart4 extends Play4State {
  const PlayStart4(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlayInProcess14 extends Play4State {
  const PlayInProcess14(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlayInProcess24 extends Play4State {
  const PlayInProcess24(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlaySuccess4 extends Play4State {
  const PlaySuccess4(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlayFailed4 extends Play4State {
  const PlayFailed4(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}
