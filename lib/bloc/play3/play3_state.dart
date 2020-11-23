import 'package:equatable/equatable.dart';
import '../../models/board.dart';


abstract class Play3State extends Equatable{
  final Board board;
  final List<int> previousBoard;
  const Play3State(this.board, this.previousBoard);

  @override
  List<Object> get props => [board];
}

class PlayInitial3 extends Play3State {
  const PlayInitial3(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlayStart3 extends Play3State {
  const PlayStart3(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

// class PlayStart4 extends PlayState {
//   const PlayStart4(Board board, List<int>previousBoard):super(board, previousBoard);
//   @override
//   String toString() => 'PlayInitial {board: $board}';
// }

class PlayInProcess13 extends Play3State {
  const PlayInProcess13(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlayInProcess23 extends Play3State {
  const PlayInProcess23(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlaySuccess3 extends Play3State {
  const PlaySuccess3(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlayFailed3 extends Play3State {
  const PlayFailed3(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}
