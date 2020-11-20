import 'package:equatable/equatable.dart';
import '../models/board.dart';


abstract class PlayState extends Equatable{
  final Board board;
  final List<int> previousBoard;
  const PlayState(this.board, this.previousBoard);

  @override
  List<Object> get props => [board];
}

class PlayInitial extends PlayState {
  const PlayInitial(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlayStart extends PlayState {
  const PlayStart(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlayInProcess1 extends PlayState {
  const PlayInProcess1(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlayInProcess2 extends PlayState {
  const PlayInProcess2(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlaySuccess extends PlayState {
  const PlaySuccess(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlayFailed extends PlayState {
  const PlayFailed(Board board, List<int>previousBoard):super(board, previousBoard);
  @override
  String toString() => 'PlayInitial {board: $board}';
}
