import 'dart:async';


import '../blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import '../../models/board.dart';


class Play3Bloc extends Bloc<Play3Event, Play3State> {
  Play3Bloc() : super(PlayInitial3(new Board([0,0,0,0,0,0,0,0,0], -1), [0,0,0,0,0,0,0,0,0]));

  @override
  Stream<Play3State> mapEventToState(
    Play3Event event,
  ) async* {
    var ran = new Random();

    if (event is GameBegins3){
      List<int> numbers = [0, 0, 0, 0, 0, 0, 0, 0, 0];
      var position = ran.nextInt(9);
      numbers[position] = 2;
      yield PlayStart3(new Board(numbers, position), numbers);
    } else if (event is SwipeLeft3){
      yield* _mapSwipeLeftToState(event);
    } else if (event is SwipeRight3){
      yield* _mapSwipeRightToState(event);
    } else if (event is SwipeUp3){
      yield* _mapSwipeUpToState(event);
    } else if (event is SwipeDown3){
      yield* _mapSwipeDownToState(event);
    } else if (event is QuitGame){
      yield PlayInitial3(new Board([0,0,0,0,0,0,0,0,0], -1), [0,0,0,0,0,0,0,0,0]);
    } else if (event is GetPreviousState3){
      yield* _mapGetPreviousStateToState(event);
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

  Stream<Play3State> _mapSwipeUpToState (SwipeUp3 event) async*{
    List<int> numbers = state.board.numbers;
    List<int> previous = List.from(numbers);
    
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
      yield PlayFailed3(new Board(result.numbers, -1), [0,0,0,0,0,0,0,0,0]);
    } else if (isSuccessful(numbers)){
      yield PlaySuccess3(new Board(result.numbers, -1), [0,0,0,0,0,0,0,0,0]);
    } else {
      if (state is PlayInProcess13){
        yield PlayInProcess23(result, previous);
      } else {
        yield PlayInProcess13(result, previous);
      }
    }
  }

  Stream<Play3State> _mapSwipeDownToState (SwipeDown3 event) async*{
    List<int> numbers = state.board.numbers;
    List<int> previous = List.from(numbers);
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
      yield PlayFailed3(new Board(result.numbers, -1), [0,0,0,0,0,0,0,0,0]);
    } else if (isSuccessful(numbers)){
      yield PlaySuccess3(new Board(result.numbers, -1), [0,0,0,0,0,0,0,0,0]);
    } else {
      if (state is PlayInProcess13){
        yield PlayInProcess23(result, previous);
      } else {
        yield PlayInProcess13(result, previous);
      }
    }
  }

  Stream<Play3State> _mapSwipeLeftToState(SwipeLeft3 event) async*{
    List<int> numbers = state.board.numbers;
    List<int> previous = List.from(numbers);
    List<bool> isEditted = [false, false, false, false, false, false, false, false, false];

    // process row/col next to the fixed one
    for (int i = 1; i <= 7; i += 3){
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
    for (int i = 2; i <= 8; i += 3){
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
    Board result = addNewNumber(numbers);
    if (isFull(result.numbers)){
      yield PlayFailed3(new Board(result.numbers, -1), [0,0,0,0,0,0,0,0,0]);
    } else if (isSuccessful(numbers)){
      yield PlaySuccess3(new Board(result.numbers, -1), [0,0,0,0,0,0,0,0,0]);
    } else {
      if (state is PlayInProcess13){
        yield PlayInProcess23(result, previous);
      } else {
        yield PlayInProcess13(result, previous);
      }
    }
  }

  Stream<Play3State> _mapSwipeRightToState(SwipeRight3 event) async*{
    List<int> numbers = state.board.numbers;
    List<int> previous = List.from(numbers);
    print('previous: ');
    print(previous);
    List<bool> isEditted = [false, false, false, false, false, false, false, false, false];
    // process row/col next to the fixed one
    for (int i = 1; i <= 7; i += 3){
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
    for (int i = 0; i <= 6; i += 3){
      // third col
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
    Board result = addNewNumber(numbers);
    if (isFull(result.numbers)){
      yield PlayFailed3(new Board(result.numbers, -1), [0,0,0,0,0,0,0,0,0]);
    } else if (isSuccessful(numbers)){
      yield PlaySuccess3(new Board(result.numbers, -1), [0,0,0,0,0,0,0,0,0]);
    } else {
      if (state is PlayInProcess13){
        yield PlayInProcess23(result, previous);
      } else {
        yield PlayInProcess13(result, previous);
      }
    }
  }

  Stream<Play3State> _mapGetPreviousStateToState(GetPreviousState3 event) async*{
    if (state is PlayInProcess13){
      yield PlayInProcess23(new Board(state.previousBoard, -1), state.previousBoard);
    } else {
      yield PlayInProcess13(new Board(state.previousBoard, -1), state.previousBoard);
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
