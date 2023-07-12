import 'package:flutter/cupertino.dart';
import 'package:image_search_9day/data/repository/photo_repository.dart';
import 'package:image_search_9day/ui/main/main_state.dart';

class MainViewModel with ChangeNotifier {
  final PhotoRepository _repository;

  MainViewModel(this._repository);

  MainState _state = const MainState();

  MainState get state => _state;

  void fetchImages(String query) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    _state = state.copyWith(
      photos: await _repository.getPhotos(query),
      isLoading: false,
    );
    notifyListeners();
  }
}
