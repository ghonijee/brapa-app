import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../domain/transaction.dart';
import '../models/transaction_model.dart';
import '../source/transaction_local_source.dart';

@injectable
class TransactionRepository {
  final TransactionLocalSource localSource;
  TransactionRepository(this.localSource);

  Future<Either<String, List<Transaction>>> getAll() async {
    try {
      var result = await localSource.getAll();
      return Right(result.toDomaiList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> update(Transaction data) async {
    try {
      await localSource.update(TransactionModel.fromDomain(data));
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Transaction>> store(Transaction data) async {
    try {
      var result = await localSource.store(TransactionModel.fromDomain(data));
      return Right(result!.toDomain());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> destroy(Transaction data) async {
    try {
      await localSource.delete(TransactionModel.fromDomain(data));
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
