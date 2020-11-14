import 'package:equatable/equatable.dart';


abstract class PlayState extends Equatable{
  final List<int> numbers;
  const PlayState(this.numbers);

  @override
  List<Object> get props => [numbers];
}

class PlayInitial extends PlayState {
  const PlayInitial(List<int> numbers):super(numbers);
  @override
  String toString() => 'PlayInitial {numbers: $numbers}';
}

class PlayStart extends PlayState {
  const PlayStart(List<int> numbers):super(numbers);
  @override
  String toString() => 'PlayStart {numbers: $numbers}';
}

class PlayInProcess1 extends PlayState {
  const PlayInProcess1(List<int> numbers):super(numbers);
  @override
  String toString() => 'PlayInProcess {numbers: $numbers}';
}

class PlayInProcess2 extends PlayState {
  const PlayInProcess2(List<int> numbers):super(numbers);
  @override
  String toString() => 'PlayInProcess {numbers: $numbers}';
}

class PlaySuccess extends PlayState {
  const PlaySuccess(List<int> numbers):super(numbers);
  @override
  String toString() => 'PlaySuccess {numbers: $numbers}';
}

class PlayFailed extends PlayState {
  const PlayFailed(List<int> numbers):super(numbers);
  @override
  String toString() => 'PlayFailed {numbers: $numbers}';
}
