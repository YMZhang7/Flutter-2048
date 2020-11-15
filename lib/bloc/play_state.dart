import 'package:equatable/equatable.dart';
import '../models/board.dart';


abstract class PlayState extends Equatable{
  final Board board;
  const PlayState(this.board);

  @override
  List<Object> get props => [board];
}

class PlayInitial extends PlayState {
  const PlayInitial(Board board):super(board);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlayStart extends PlayState {
  const PlayStart(Board board):super(board);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlayInProcess1 extends PlayState {
  const PlayInProcess1(Board board):super(board);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlayInProcess2 extends PlayState {
  const PlayInProcess2(Board board):super(board);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlaySuccess extends PlayState {
  const PlaySuccess(Board board):super(board);
  @override
  String toString() => 'PlayInitial {board: $board}';
}

class PlayFailed extends PlayState {
  const PlayFailed(Board board):super(board);
  @override
  String toString() => 'PlayInitial {board: $board}';
}
