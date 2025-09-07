import 'package:dartz/dartz.dart';

import '../../data/network/api_failure.dart';

typedef Params = Map<String, dynamic>;

typedef Result<T> = Future<Either<ApiFailure, T>>;
