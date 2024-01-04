import 'package:tree_view_desafio/app/modules/assets/data/local_repository.dart';

import '../../data/assets_repository.dart';
import '../../data/file_repository.dart';

abstract class IPopulateData {
  Future<void> call(String unit);
}

class PopulateData implements IPopulateData {
  final IFileRepository fileRepository;
  final IAssetsRepository assetsRepository;
  final ILocalRepository localRepository;

 

  PopulateData(
      this.fileRepository, this.assetsRepository, this.localRepository);

  @override
  Future<void> call(String unit) async {
    if (await localRepository.isDatabaseEmpty(unit)) {
      final locations = await fileRepository.getLocationsFromFile(unit);
      await localRepository.saveLocations(locations);
    }

    if (await assetsRepository.isDatabaseEmpty(unit)) {
      final assets = await fileRepository.getAssetsFromFile(unit);
      await assetsRepository.saveAssets(assets);
    }
  }
}
