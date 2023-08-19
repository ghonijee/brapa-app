import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../domain/transfer_log.dart';
import '../models/transfer_log_model.dart';
import '../source/transfer_log_local_source.dart';

@injectable
class TransferLogRepository {
  final TransferLogLocalSource localSource;
  TransferLogRepository(this.localSource);

  Future<Either<String, TransferLog>> findByTransactionId({required int id}) async {
    try {
      // localSource.clearAll();
      var result = await localSource.find(id: id);

      if (result == null) {
        return const Left("Data not found!");
      }

      return Right(result.toDomain());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<TransferLog>>> getAll() async {
    try {
      // localSource.clearAll();
      var result = await localSource.getAll();

      return Right(result.toDomaiList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> update(TransferLog data) async {
    try {
      await localSource.update(TransferLogModel.fromDomain(data));
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, TransferLog>> store(TransferLog data) async {
    try {
      var result = await localSource.store(TransferLogModel.fromDomain(data));
      return Right(result!.toDomain());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> destroy(TransferLog data) async {
    try {
      await localSource.delete(TransferLogModel.fromDomain(data));
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
