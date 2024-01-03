import 'package:tree_view_desafio/app/modules/assets/data/local_repository.dart';

import '../../data/assets_repository.dart';
import '../../data/file_repository.dart';

abstract class IPopulateData {
  Future<void> call();
}

class PopulateData implements IPopulateData {
  final IFileRepository fileRepository;
  final IAssetsRepository assetsRepository;
  final ILocalRepository localRepository;

  PopulateData(
      this.fileRepository, this.assetsRepository, this.localRepository);

  @override
  Future<void> call() async {
    if (await localRepository.isDatabaseEmpty()) {
      final locations = await fileRepository.getLocationsFromFile();
      await localRepository.saveLocations(locations);
    }

    if (await assetsRepository.isDatabaseEmpty()) {
      final assets = await fileRepository.getAssetsFromFile();
      await assetsRepository.saveAssets(assets);
    }
  }
}
