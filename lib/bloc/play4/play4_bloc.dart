import 'dart:async';


import '../blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import '../../models/board.dart';


class Play4Bloc extends Bloc<Play4Event, Play4State> {
  Play4Bloc() : super(PlayInitial4(new Board([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], -1), [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]));

  @override
  Stream<Play4State> mapEventToState(
    Play4Event event,
  ) async* {
    var ran = new Random();

    if (event is GameBegins4){
      List<int> numbers = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
      var position = ran.nextInt(16);
      numbers[position] = 2;
      yield PlayStart4(new Board(numbers, position), numbers);
    } else if (event is SwipeLeft4){
      yield* _mapSwipeLeftToState(event);
    } else if (event is SwipeRight4){
      yield* _mapSwipeRightToState(event);
    } else if (event is SwipeUp4){
      yield* _mapSwipeUpToState(event);
    } else if (event is SwipeDown4){
      yield* _mapSwipeDownToState(event);
    } else if (event is QuitGame){
      yield PlayInitial4(new Board([0,0,0,0,0,0,0,0,0], -1), [0,0,0,0,0,0,0,0,0]);
    } else if (event is GetPreviousState4){
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
    for (int i = 0; i <= 7; i++){
      if (numbers[i] == numbers[i+3]){
        return false;
      }
    }
    // whether there are horizontal moves
    for (int i = 0; i < numbers.length; i++){
      if (i == 3 || i == 7 || i == 11){
        continue;
      } else {
        if (numbers[i] == numbers[i+1]){
          return false;
        }
      }
    }
    return true;
  }

  Stream<Play4State> _mapSwipeUpToState (SwipeUp4 event) async*{
    List<int> numbers = state.board.numbers;
    List<int> previous = List.from(numbers);
    List<bool> isEditted = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
    // second row
    for (int i = 4; i < 8; i++){
      if (numbers[i-4] == 0){
        numbers[i-4] = numbers[i];
        numbers[i] = 0;
      } else if (numbers[i-4] == numbers[i]){
        numbers[i-4] *= 2;
        numbers[i] = 0;
        isEditted[i-4] = true;
      }
    }
    // third row
    for (int i = 8; i < 12; i++){
      if (numbers[i-4] != 0){
        if (numbers[i-4] == numbers[i]){
          numbers[i-4] *= 2;
          numbers[i] = 0;
          isEditted[i-4] = true;
        }
      } else {
        if (numbers[i-8] == 0){
          numbers[i-8] = numbers[i];
          numbers[i] = 0;
        } else {
          if (numbers[i-8] == numbers[i]){
            if (isEditted[i-8]){
              numbers[i-4] = numbers[i];
              numbers[i] = 0;
            } else {
              numbers[i-8] *= 2;
              numbers[i] = 0;
              isEditted[i-8] = true;
            }
          } else {
            numbers[i-4] = numbers[i];
            numbers[i] = 0;
          }
        }
      }
    }
    // fourth row
    for (int i = 12; i < 16; i++){
      if (numbers[i-4] != 0){
        if (numbers[i-4] == numbers[i]){
          numbers[i-4] *= 2;
          numbers[i] = 0;
        }
      } else {
        if (numbers[i-8] != 0){
          if (numbers[i-8] == numbers[i]){
            if (isEditted[i-8]){
              numbers[i-4] = numbers[i];
              numbers[i] = 0;
            } else {
              numbers[i-8] *= 2;
              numbers[i] = 0;
            }
          } else {
            numbers[i-8] = numbers[i];
            numbers[i] = 0;
          }
        } else {
          if (numbers[i-12] != 0){
            if (numbers[i] == numbers[i-12]){
              if (isEditted[numbers[i-12]]){
                numbers[i-8] = numbers[i];
                numbers[i] = 0;
              } else {
                numbers[i-12] *= 2;
                numbers[i] = 0;
              }
            } else {
              numbers[i-8] = numbers[i];
              numbers[i] = 0;
            }
          } else {
            numbers[i-12] = numbers[i];
            numbers[i] = 0;
          }
        }
      }
    }
    Board result = addNewNumber(numbers);
    if (isFull(result.numbers)){
      yield PlayFailed4(new Board(result.numbers, -1), [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
    } else if (isSuccessful(numbers)){
      yield PlaySuccess4(new Board(result.numbers, -1), [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
    } else {
      if (state is PlayInProcess14){
        yield PlayInProcess24(result, previous);
      } else {
        yield PlayInProcess14(result, previous);
      }
    }
  }

  Stream<Play4State> _mapSwipeDownToState (SwipeDown4 event) async*{
    List<int> numbers = state.board.numbers;
    List<int> previous = List.from(numbers);
    List<bool> isEditted = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
    // third row
    for (int i = 8; i < 12; i++){
      if (numbers[i+4] == 0){
        numbers[i+4] = numbers[i];
        numbers[i] = 0;
      } else if (numbers[i+4] == numbers[i]){
        numbers[i+4] *= 2;
        numbers[i] = 0;
        isEditted[i+4] = true;
      }
    }
    // second row
    for (int i = 4; i < 8; i++){
      if (numbers[i+4] != 0){
        if (numbers[i+4] == numbers[i]){
          numbers[i+4] *= 2;
          numbers[i] = 0;
          isEditted[i+4] = true;
        }
      } else {
        if (numbers[i+8] == 0){
          numbers[i+8] = numbers[i];
          numbers[i] = 0;
        } else {
          if (numbers[i+8] == numbers[i]){
            if (isEditted[i+8]){
              numbers[i+4] = numbers[i];
              numbers[i] = 0;
            } else {
              numbers[i+8] *= 2;
              numbers[i] = 0;
              isEditted[i+8] = true;
            }
          } else {
            numbers[i+4] = numbers[i];
            numbers[i] = 0;
          }
        }
      }
    }
    // first row
    for (int i = 0; i < 4; i++){
      if (numbers[i+4] != 0){
        if (numbers[i+4] == numbers[i]){
          numbers[i+4] *= 2;
          numbers[i] = 0;
        }
      } else {
        if (numbers[i+8] != 0){
          if (numbers[i+8] == numbers[i]){
            if (isEditted[i+8]){
              numbers[i+4] = numbers[i];
              numbers[i] = 0;
            } else {
              numbers[i+8] *= 2;
              numbers[i] = 0;
            }
          } else {
            numbers[i+8] = numbers[i];
            numbers[i] = 0;
          }
        } else {
          if (numbers[i+12] != 0){
            if (numbers[i] == numbers[i+12]){
              if (isEditted[numbers[i+12]]){
                numbers[i+8] = numbers[i];
                numbers[i] = 0;
              } else {
                numbers[i+12] *= 2;
                numbers[i] = 0;
              }
            } else {
              numbers[i+8] = numbers[i];
              numbers[i] = 0;
            }
          } else {
            numbers[i+12] = numbers[i];
            numbers[i] = 0;
          }
        }
      }
    }
    Board result = addNewNumber(numbers);
    if (isFull(result.numbers)){
      yield PlayFailed4(new Board(result.numbers, -1), [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
    } else if (isSuccessful(numbers)){
      yield PlaySuccess4(new Board(result.numbers, -1), [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
    } else {
      if (state is PlayInProcess14){
        yield PlayInProcess24(result, previous);
      } else {
        yield PlayInProcess14(result, previous);
      }
    }
  }

  Stream<Play4State> _mapSwipeLeftToState(SwipeLeft4 event) async*{
    List<int> numbers = state.board.numbers;
    List<int> previous = List.from(numbers);
    List<bool> isEditted = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
    // second col
    for (int i = 1; i <= 13; i+=4){
      if (numbers[i-1] == 0){
        numbers[i-1] = numbers[i];
        numbers[i] = 0;
      } else if (numbers[i-1] == numbers[i]){
        numbers[i-1] *= 2;
        numbers[i] = 0;
        isEditted[i-1] = true;
      }
    }
    // third col
    for (int i = 2; i <= 14; i+=4){
      if (numbers[i-1] != 0){
        if (numbers[i-1] == numbers[i]){
          numbers[i-1] *= 2;
          numbers[i] = 0;
          isEditted[i-1] = true;
        }
      } else {
        if (numbers[i-2] == 0){
          numbers[i-2] = numbers[i];
          numbers[i] = 0;
        } else {
          if (numbers[i-2] == numbers[i]){
            if (isEditted[i-2]){
              numbers[i-1] = numbers[i];
              numbers[i] = 0;
            } else {
              numbers[i-2] *= 2;
              numbers[i] = 0;
              isEditted[i-2] = true;
            }
          } else {
            numbers[i-1] = numbers[i];
            numbers[i] = 0;
          }
        }
      }
    }
    // fourth col
    for (int i = 3; i <= 15; i+=4){
      if (numbers[i-1] != 0){
        if (numbers[i-1] == numbers[i]){
          numbers[i-1] *= 2;
          numbers[i] = 0;
        }
      } else {
        if (numbers[i-2] != 0){
          if (numbers[i-2] == numbers[i]){
            if (isEditted[i-2]){
              numbers[i-2] = numbers[i];
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
          if (numbers[i-3] != 0){
            if (numbers[i] == numbers[i-3]){
              if (isEditted[numbers[i-3]]){
                numbers[i-2] = numbers[i];
                numbers[i] = 0;
              } else {
                numbers[i-3] *= 2;
                numbers[i] = 0;
              }
            } else {
              numbers[i-2] = numbers[i];
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
      yield PlayFailed4(new Board(result.numbers, -1), [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
    } else if (isSuccessful(numbers)){
      yield PlaySuccess4(new Board(result.numbers, -1), [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
    } else {
      if (state is PlayInProcess14){
        yield PlayInProcess24(result, previous);
      } else {
        yield PlayInProcess14(result, previous);
      }
    }
  }

  Stream<Play4State> _mapSwipeRightToState(SwipeRight4 event) async*{
    List<int> numbers = state.board.numbers;
    List<int> previous = List.from(numbers);
    List<bool> isEditted = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
    // third col
    for (int i = 2; i <= 14; i+=4){
      if (numbers[i+1] == 0){
        numbers[i+1] = numbers[i];
        numbers[i] = 0;
      } else if (numbers[i+1] == numbers[i]){
        numbers[i+1] *= 2;
        numbers[i] = 0;
        isEditted[i+1] = true;
      }
    }
    // second col
    for (int i = 1; i <= 13; i+=4){
      if (numbers[i+1] != 0){
        if (numbers[i+1] == numbers[i]){
          numbers[i+1] *= 2;
          numbers[i] = 0;
          isEditted[i+1] = true;
        }
      } else {
        if (numbers[i+2] == 0){
          numbers[i+2] = numbers[i];
          numbers[i] = 0;
        } else {
          if (numbers[i+2] == numbers[i]){
            if (isEditted[i+2]){
              numbers[i+1] = numbers[i];
              numbers[i] = 0;
            } else {
              numbers[i+2] *= 2;
              numbers[i] = 0;
              isEditted[i+2] = true;
            }
          } else {
            numbers[i+1] = numbers[i];
            numbers[i] = 0;
          }
        }
      }
    }
    // fourth col
    for (int i = 3; i <= 15; i+=4){
      if (numbers[i+1] != 0){
        if (numbers[i+1] == numbers[i]){
          numbers[i+1] *= 2;
          numbers[i] = 0;
        }
      } else {
        if (numbers[i+2] != 0){
          if (numbers[i+2] == numbers[i]){
            if (isEditted[i+2]){
              numbers[i+2] = numbers[i];
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
          if (numbers[i+3] != 0){
            if (numbers[i] == numbers[i+3]){
              if (isEditted[numbers[i+3]]){
                numbers[i+2] = numbers[i];
                numbers[i] = 0;
              } else {
                numbers[i+3] *= 2;
                numbers[i] = 0;
              }
            } else {
              numbers[i+2] = numbers[i];
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
      yield PlayFailed4(new Board(result.numbers, -1), [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
    } else if (isSuccessful(numbers)){
      yield PlaySuccess4(new Board(result.numbers, -1), [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
    } else {
      if (state is PlayInProcess14){
        yield PlayInProcess24(result, previous);
      } else {
        yield PlayInProcess14(result, previous);
      }
    }
  }

  Stream<Play4State> _mapGetPreviousStateToState(GetPreviousState4 event) async*{
    if (state is PlayInProcess14){
      yield PlayInProcess24(new Board(state.previousBoard, -1), state.previousBoard);
    } else {
      yield PlayInProcess14(new Board(state.previousBoard, -1), state.previousBoard);
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
