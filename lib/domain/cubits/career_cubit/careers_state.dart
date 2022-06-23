part of 'careers_cubit.dart';

@immutable
abstract class CareersState extends Equatable {}

class CareersInitial extends CareersState {
  @override
  List<Object?> get props => [];
}

class Loading extends CareersState {
  @override
  List<Object?> get props => [];
}

class LoadError extends CareersState {
  final String error;

  LoadError(this.error);

  @override
  List<Object?> get props => [error];
}

class VideosFetched extends CareersState {
  final List<Video> videos;

  VideosFetched(this.videos);

  @override
  List<Object?> get props => [videos];
}

class CareersFetched extends CareersState{
  final List<Career> careers;

  CareersFetched(this.careers);
  @override
  List<Object?> get props => [careers];
}
