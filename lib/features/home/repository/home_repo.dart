import 'package:dartz/dartz.dart';
import 'package:readback/features/home/model/repository_list_model.dart';

import '../../../../data/network/api_failure.dart';

abstract class HomeRepository {
  Future<Either<ApiFailure, RepositoryListModel>> getRepoList(
      Map<String, dynamic> params);
}
