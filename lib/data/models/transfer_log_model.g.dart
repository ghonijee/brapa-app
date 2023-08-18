// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_log_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTransferLogModelCollection on Isar {
  IsarCollection<TransferLogModel> get transferLogModels => this.collection();
}

const TransferLogModelSchema = CollectionSchema(
  name: r'TransferLogModel',
  id: 3718568558899053774,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'fromId': PropertySchema(
      id: 2,
      name: r'fromId',
      type: IsarType.long,
    ),
    r'toId': PropertySchema(
      id: 3,
      name: r'toId',
      type: IsarType.long,
    )
  },
  estimateSize: _transferLogModelEstimateSize,
  serialize: _transferLogModelSerialize,
  deserialize: _transferLogModelDeserialize,
  deserializeProp: _transferLogModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'fromAccount': LinkSchema(
      id: 1625370844985425375,
      name: r'fromAccount',
      target: r'AccountModel',
      single: true,
    ),
    r'toAccount': LinkSchema(
      id: -1667412053571654784,
      name: r'toAccount',
      target: r'AccountModel',
      single: true,
    ),
    r'transactionFrom': LinkSchema(
      id: -3848113089539896379,
      name: r'transactionFrom',
      target: r'TransactionModel',
      single: true,
    ),
    r'transactionTo': LinkSchema(
      id: 4683073130935025558,
      name: r'transactionTo',
      target: r'TransactionModel',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _transferLogModelGetId,
  getLinks: _transferLogModelGetLinks,
  attach: _transferLogModelAttach,
  version: '3.1.0+1',
);

int _transferLogModelEstimateSize(
  TransferLogModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _transferLogModelSerialize(
  TransferLogModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.amount);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeLong(offsets[2], object.fromId);
  writer.writeLong(offsets[3], object.toId);
}

TransferLogModel _transferLogModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TransferLogModel();
  object.amount = reader.readLongOrNull(offsets[0]);
  object.createdAt = reader.readDateTimeOrNull(offsets[1]);
  object.fromId = reader.readLongOrNull(offsets[2]);
  object.id = id;
  object.toId = reader.readLongOrNull(offsets[3]);
  return object;
}

P _transferLogModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _transferLogModelGetId(TransferLogModel object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _transferLogModelGetLinks(TransferLogModel object) {
  return [
    object.fromAccount,
    object.toAccount,
    object.transactionFrom,
    object.transactionTo
  ];
}

void _transferLogModelAttach(
    IsarCollection<dynamic> col, Id id, TransferLogModel object) {
  object.id = id;
  object.fromAccount
      .attach(col, col.isar.collection<AccountModel>(), r'fromAccount', id);
  object.toAccount
      .attach(col, col.isar.collection<AccountModel>(), r'toAccount', id);
  object.transactionFrom.attach(
      col, col.isar.collection<TransactionModel>(), r'transactionFrom', id);
  object.transactionTo.attach(
      col, col.isar.collection<TransactionModel>(), r'transactionTo', id);
}

extension TransferLogModelQueryWhereSort
    on QueryBuilder<TransferLogModel, TransferLogModel, QWhere> {
  QueryBuilder<TransferLogModel, TransferLogModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TransferLogModelQueryWhere
    on QueryBuilder<TransferLogModel, TransferLogModel, QWhereClause> {
  QueryBuilder<TransferLogModel, TransferLogModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TransferLogModelQueryFilter
    on QueryBuilder<TransferLogModel, TransferLogModel, QFilterCondition> {
  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      amountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'amount',
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      amountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'amount',
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      amountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      amountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      amountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      amountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      fromIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fromId',
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      fromIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fromId',
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      fromIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      fromIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fromId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      fromIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fromId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      fromIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fromId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      toIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'toId',
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      toIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'toId',
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      toIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      toIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      toIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      toIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TransferLogModelQueryObject
    on QueryBuilder<TransferLogModel, TransferLogModel, QFilterCondition> {}

extension TransferLogModelQueryLinks
    on QueryBuilder<TransferLogModel, TransferLogModel, QFilterCondition> {
  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      fromAccount(FilterQuery<AccountModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'fromAccount');
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      fromAccountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'fromAccount', 0, true, 0, true);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      toAccount(FilterQuery<AccountModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'toAccount');
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      toAccountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'toAccount', 0, true, 0, true);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      transactionFrom(FilterQuery<TransactionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'transactionFrom');
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      transactionFromIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'transactionFrom', 0, true, 0, true);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      transactionTo(FilterQuery<TransactionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'transactionTo');
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterFilterCondition>
      transactionToIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'transactionTo', 0, true, 0, true);
    });
  }
}

extension TransferLogModelQuerySortBy
    on QueryBuilder<TransferLogModel, TransferLogModel, QSortBy> {
  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy>
      sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy>
      sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy>
      sortByFromId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromId', Sort.asc);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy>
      sortByFromIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromId', Sort.desc);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy> sortByToId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toId', Sort.asc);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy>
      sortByToIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toId', Sort.desc);
    });
  }
}

extension TransferLogModelQuerySortThenBy
    on QueryBuilder<TransferLogModel, TransferLogModel, QSortThenBy> {
  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy>
      thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy>
      thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy>
      thenByFromId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromId', Sort.asc);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy>
      thenByFromIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromId', Sort.desc);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy> thenByToId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toId', Sort.asc);
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QAfterSortBy>
      thenByToIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toId', Sort.desc);
    });
  }
}

extension TransferLogModelQueryWhereDistinct
    on QueryBuilder<TransferLogModel, TransferLogModel, QDistinct> {
  QueryBuilder<TransferLogModel, TransferLogModel, QDistinct>
      distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QDistinct>
      distinctByFromId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromId');
    });
  }

  QueryBuilder<TransferLogModel, TransferLogModel, QDistinct> distinctByToId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toId');
    });
  }
}

extension TransferLogModelQueryProperty
    on QueryBuilder<TransferLogModel, TransferLogModel, QQueryProperty> {
  QueryBuilder<TransferLogModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TransferLogModel, int?, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<TransferLogModel, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<TransferLogModel, int?, QQueryOperations> fromIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromId');
    });
  }

  QueryBuilder<TransferLogModel, int?, QQueryOperations> toIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toId');
    });
  }
}
