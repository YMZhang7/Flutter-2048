import 'dart:async';


import 'blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import '../models/board.dart';


class PlayBloc extends Bloc<PlayEvent, PlayState> {
  PlayBloc() : super(PlayInitial(new Board([0,0,0,0,0,0,0,0,0], -1)));

  @override
  Stream<PlayState> mapEventToState(
    PlayEvent event,
  ) async* {
    var ran = new Random();

    if (event is GameBegins){
      List<int> numbers = [0, 0, 0, 0, 0, 0, 0, 0, 0];
      var position = ran.nextInt(9);
      numbers[position] = 2;
      yield PlayStart(new Board(numbers, position));
    } else if (event is SwipeLeft){
      yield* _mapSwipeLeftToState(event);
    } else if (event is SwipeRight){
      yield* _mapSwipeRightToState(event);
    } else if (event is SwipeUp){
      yield* _mapSwipeUpToState(event);
    } else if (event is SwipeDown){
      yield* _mapSwipeDownToState(event);
    }
  }

  // whether the game is over
  bool isFull(List<int> numbers){
    // whether there are empty slots
    for (int i = 0; i < numbers.length; i++){
      if (numbers[i] == 0){
        return false;
      }
    }
    // whether there are vertical moves
    for (int i = 0; i <= 5; i++){
      if (numbers[i] == numbers[i+3]){
        return false;
      }
    }
    // whether there are horizontal moves
    for (int i = 0; i < numbers.length; i++){
      if (i == 2 || i == 5 || i == 8){
        continue;
      } else {
        if (numbers[i] == numbers[i+1]){
          return false;
        }
      }
    }
    return true;
  }

  // Can be directly used if swipeup; 
  // need to transform matrix before using for other gestures
  Board processMatrix (List<int> currentBoard){
    bool isChanged = false;
    for (int i = currentBoard.length - 1; i >= 3; i--){
      if (currentBoard[i] == currentBoard[i-3]){
        currentBoard[i-3] += currentBoard[i];
        currentBoard[i] = 0;
        isChanged = true;
      } else if (currentBoard[i-3] == 0){
        // shift
        currentBoard[i-3] = currentBoard[i];
        currentBoard[i] = 0;
        isChanged = true;
      }
    }
    for (int i = 0; i <= 2; i++){
      if (currentBoard[i] == 0){
        currentBoard[i] = currentBoard[i+3];
        currentBoard[i+3] = currentBoard[i+6];
        isChanged = true;
      }
    }
    // randomly choose a slot to add new number
    if (isChanged){
      // var result = addNewNumber(currentBoard);
      var random = new Random();
      var emptySlots = [];
      var options = [2, 4];
      for (int i = 0; i < currentBoard.length; i++){
        if (currentBoard[i] == 0){
          emptySlots.add(i);
        }
      }
      var position = emptySlots[random.nextInt(emptySlots.length)];
      var number = options[random.nextInt(2)];
      currentBoard[position] = number;
      // return numbers;
      // return result;
      var result = new Board(currentBoard, position);
      return result;
    }
    var result = new Board(currentBoard, -1);
    return result;
  }

  Stream<PlayState> _mapSwipeUpToState (SwipeUp event) async*{
    List<int> currentBoard = state.board.numbers;
    Board result = processMatrix(currentBoard);
    if (isFull(result.numbers)){
      yield PlayFailed(result);
    } else if (isSuccessful(result.numbers)){
      yield PlaySuccess(result);
    } else {
      if (state is PlayInProcess1){
        yield PlayInProcess2(result);
      } else {
        yield PlayInProcess1(result);
      }
    }
  }

  Stream<PlayState> _mapSwipeDownToState (SwipeDown event) async*{
    List<int> currentBoard = state.board.numbers;
    List<int> transformedBoard = [currentBoard[6], currentBoard[7], currentBoard[8], currentBoard[3], currentBoard[4], currentBoard[5], currentBoard[0], currentBoard[1], currentBoard[2]];
    Board processed = processMatrix(transformedBoard);
    List<int> temp = processed.numbers;
    List<int> result = [temp[6], temp[7],temp[8],temp[3],temp[4],temp[5],temp[0],temp[1],temp[2]];
    if (isFull(result)){
      yield PlayFailed(new Board(result, -1));
    } else if (isSuccessful(result)){
      yield PlaySuccess(new Board(result, -1));
    } else {
      if (state is PlayInProcess1){
        yield PlayInProcess2(new Board(result, processed.newNumberIndex));
      } else {
        yield PlayInProcess1(new Board(result, processed.newNumberIndex));
      }
    }
  }

  Stream<PlayState> _mapSwipeLeftToState(SwipeLeft event) async*{
    List<int> currentBoard = state.board.numbers;
    List<int> transformedBoard = [currentBoard[6], currentBoard[3], currentBoard[0], currentBoard[7], currentBoard[4], currentBoard[1], currentBoard[8], currentBoard[5], currentBoard[2]];
    Board processed = processMatrix(transformedBoard);
    List<int> temp = processed.numbers;
    List<int> result = [temp[2], temp[5],temp[8],temp[1],temp[4],temp[7],temp[0],temp[3],temp[6]];
    if (isFull(result)){
      yield PlayFailed(new Board(result, -1));
    } else if (isSuccessful(result)){
      yield PlaySuccess(new Board(result, -1));
    } else {
      if (state is PlayInProcess1){
        yield PlayInProcess2(new Board(result, processed.newNumberIndex));
      } else {
        yield PlayInProcess1(new Board(result, processed.newNumberIndex));
      }
    }
  }

  Stream<PlayState> _mapSwipeRightToState(SwipeRight event) async*{
    List<int> currentBoard = state.board.numbers;
    List<int> transformedBoard = [currentBoard[2], currentBoard[5], currentBoard[8], currentBoard[1], currentBoard[4], currentBoard[7], currentBoard[0], currentBoard[3], currentBoard[6]];
    Board processed = processMatrix(transformedBoard);
    List<int> temp = processed.numbers;
    List<int> result = [temp[6], temp[3],temp[0],temp[7],temp[4],temp[1],temp[8],temp[5],temp[2]];
    if (isFull(result)){
      yield PlayFailed(new Board(result, -1));
    } else if (isSuccessful(result)){
      yield PlaySuccess(new Board(result, -1));
    } else {
      if (state is PlayInProcess1){
        yield PlayInProcess2(new Board(result, processed.newNumberIndex));
      } else {
        yield PlayInProcess1(new Board(result, processed.newNumberIndex));
      }
    }
  }

  bool isSuccessful(List<int> numbers){
    for (int i = 0; i < numbers.length; i++){
      if (numbers[i] == 2048){
        return true;
      }
    }
    return false;
  }

  List<int> addNewNumber(List<int> numbers){
    var random = new Random();
    var emptySlots = [];
    var options = [2, 4];
    for (int i = 0; i < numbers.length; i++){
      if (numbers[i] == 0){
        emptySlots.add(i);
      }
    }
    var position = emptySlots[random.nextInt(emptySlots.length)];
    print(position);
    var number = options[random.nextInt(2)];
    numbers[position] = number;
    return numbers;
  }
}
