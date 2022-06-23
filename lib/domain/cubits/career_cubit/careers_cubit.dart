import 'package:bloc/bloc.dart';
import 'package:career_path/domain/models/career.dart';
import 'package:career_path/domain/repository/youtube_repo_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

part 'careers_state.dart';

class CareersCubit extends Cubit<CareersState> {
  CareersCubit() : super(CareersInitial());

  final YoutubeRepo repo = YoutubeRepo();

  void fetchCareerVideos(String id) async {
    emit(Loading());
    try {
      var value = await repo.getCareerPathVideos(id);
      if (value.isLeft) {
        emit(LoadError(value.left));
      } else {
        emit(VideosFetched(value.right));
      }
    } catch (e) {
      emit(LoadError("Unable to fetch videos"));
    }
  }

  void get  getCareerList async {
    emit(Loading());
    try {
      var value = await repo.getCareerList;
      emit(CareersFetched(value));
    } catch (e) {
      emit(LoadError("Unable to fetch videos"));
    }
  }

  void searchCareer(String query) async {
    emit(Loading());
    try {
      var value = await repo.searchCareer(query);
      emit(CareersFetched(value));
    } catch (e) {
      emit(LoadError("Unable to fetch videos"));
    }
  }
}
