import 'dart:async';


import 'blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import '../models/board.dart';
// import '../models/cube.dart';


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
    List<int> numbers = state.board.numbers;
    List<bool> isEditted = [false, false, false, false, false, false, false, false, false];
    // 2nd row
    for (int i = 3; i <= 5; i++){
      if (numbers[i] == numbers[i-3]){
        numbers[i-3] *= 2;
        numbers[i] = 0;
        isEditted[i-3] = true;
      } else if (numbers[i-3] == 0){
        numbers[i-3] = numbers[i];
        numbers[i] = 0;
      }
    }
    // 3rd row
    for (int i = 6; i <= 8; i++){
      if (numbers[i-3] != 0){
        if (numbers[i-3] == numbers[i]){
          numbers[i-3] *= 2;
          numbers[i] = 0;
        }
      } else {
        if (numbers[i-6] != 0){
          if (numbers[i-6] == numbers[i]){
            if (!isEditted[i-6]){
              numbers[i-6] *= 2;
              numbers[i] = 0;
            } else {
              numbers[i-3] = numbers[i];
              numbers[i] = 0;
            }
          } else {
            numbers[i-3] = numbers[i];
            numbers[i] = 0;
          }
        } else {
          numbers[i-6] = numbers[i];
          numbers[i] = 0;
        }
      }
    }
    Board result = addNewNumber(numbers);
    if (isFull(result.numbers)){
      yield PlayFailed(new Board(result.numbers, -1));
    } else if (isSuccessful(numbers)){
      yield PlaySuccess(new Board(result.numbers, -1));
    } else {
      if (state is PlayInProcess1){
        yield PlayInProcess2(result);
      } else {
        yield PlayInProcess1(result);
      }
    }
  }

  Stream<PlayState> _mapSwipeDownToState (SwipeDown event) async*{
    List<int> numbers = state.board.numbers;
    List<bool> isEditted = [false, false, false, false, false, false, false, false, false];
    // process row/col next to the fixed one
    for (int i = 3; i < 6; i++){
      // same number -> merge
      if (numbers[i] == numbers[i+3]){
        numbers[i+3] *= 2;
        numbers[i] = 0;
        isEditted[i+3] = true;
      } else if(numbers[i+3] == 0){
        // empty -> shift
        numbers[i+3] = numbers[i];
        numbers[i] = 0;
      }
    }
    for (int i = 0; i < 3; i++){
      if (numbers[i+3] != 0){
        if (numbers[i] == numbers[i+3]){
          numbers[i+3] *= 2;
          numbers[i] = 0;
        }
      } else {
        if (numbers[i+6] != 0){
          if (numbers[i+6] == numbers[i]){
            if (isEditted[i+6]){
              numbers[i+3] = numbers[i];
              numbers[i] = 0;
            } else {
              numbers[i+6] *= 2;
              numbers[i] = 0;
            }
          } else {
            numbers[i+3] = numbers[i];
            numbers[i] = 0;
          }
        } else {
          numbers[i+6] = numbers[i];
          numbers[i] = 0;
        }
      }
    }
    Board result = addNewNumber(numbers);
    if (isFull(result.numbers)){
      yield PlayFailed(new Board(result.numbers, -1));
    } else if (isSuccessful(numbers)){
      yield PlaySuccess(new Board(result.numbers, -1));
    } else {
      if (state is PlayInProcess1){
        yield PlayInProcess2(result);
      } else {
        yield PlayInProcess1(result);
      }
    }
  }

  Stream<PlayState> _mapSwipeLeftToState(SwipeLeft event) async*{
    List<int> numbers = state.board.numbers;
    List<bool> isEditted = [false, false, false, false, false, false, false, false, false];
    for (int i = 0; i < numbers.length; i++){
      // process row/col next to the fixed one
      if (i == 1 || i == 4 || i == 7){
        // same number -> merge
        if (numbers[i] == numbers[i-1]){
          numbers[i-1] *= 2;
          numbers[i] = 0;
          isEditted[i-1] = true;
        } else if(numbers[i-1] == 0){
          // empty -> shift
          numbers[i-1] = numbers[i];
          numbers[i] = 0;
        }
      }
      // third col
      if (i == 2 || i == 5 || i == 8){
        if (numbers[i-1] != 0){
          if (numbers[i] == numbers[i-1]){
            numbers[i-1] *= 2;
            numbers[i] = 0;
          }
        } else {
          if (numbers[i-2] != 0){
            if (numbers[i-2] == numbers[i]){
              if (isEditted[i-2]){
                numbers[i-1] = numbers[i];
                numbers[i] = 0;
              } else {
                numbers[i-2] *= 2;
                numbers[i] = 0;
              }
            } else {
              numbers[i-1] = numbers[i];
              numbers[i] = 0;
            }
          } else {
            numbers[i-2] = numbers[i];
            numbers[i] = 0;
          }
        }
      }
    }
    Board result = addNewNumber(numbers);
    if (isFull(result.numbers)){
      yield PlayFailed(new Board(result.numbers, -1));
    } else if (isSuccessful(numbers)){
      yield PlaySuccess(new Board(result.numbers, -1));
    } else {
      if (state is PlayInProcess1){
        yield PlayInProcess2(result);
      } else {
        yield PlayInProcess1(result);
      }
    }
  }

  Stream<PlayState> _mapSwipeRightToState(SwipeRight event) async*{
    List<int> numbers = state.board.numbers;
    List<bool> isEditted = [false, false, false, false, false, false, false, false, false];
    for (int i = 0; i < numbers.length; i++){
      // process row/col next to the fixed one
      if (i == 1 || i == 4 || i == 7){
        // same number -> merge
        if (numbers[i] == numbers[i+1]){
          numbers[i+1] *= 2;
          numbers[i] = 0;
          isEditted[i+1] = true;
        } else if(numbers[i+1] == 0){
          // empty -> shift
          numbers[i+1] = numbers[i];
          numbers[i] = 0;
        }
      }
      // third col
      if (i == 0 || i == 3 || i == 6){
        if (numbers[i+1] != 0){
          if (numbers[i] == numbers[i+1]){
            numbers[i+1] *= 2;
            numbers[i] = 0;
          }
        } else {
          if (numbers[i+2] != 0){
            if (numbers[i+2] == numbers[i]){
              if (isEditted[i+2]){
                numbers[i+1] = numbers[i];
                numbers[i] = 0;
              } else {
                numbers[i+2] *= 2;
                numbers[i] = 0;
              }
            } else {
              numbers[i+1] = numbers[i];
              numbers[i] = 0;
            }
          } else {
            numbers[i+2] = numbers[i];
            numbers[i] = 0;
          }
        }
      }
    }
    Board result = addNewNumber(numbers);
    if (isFull(result.numbers)){
      yield PlayFailed(new Board(result.numbers, -1));
    } else if (isSuccessful(numbers)){
      yield PlaySuccess(new Board(result.numbers, -1));
    } else {
      if (state is PlayInProcess1){
        yield PlayInProcess2(result);
      } else {
        yield PlayInProcess1(result);
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

  Board addNewNumber(List<int> numbers){
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
    Board result = new Board(numbers, position);
    return result;
  }

}
