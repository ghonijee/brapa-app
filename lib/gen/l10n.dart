// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Record`
  String get menuRecord {
    return Intl.message(
      'Record',
      name: 'menuRecord',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get menuHistory {
    return Intl.message(
      'History',
      name: 'menuHistory',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get menuAccount {
    return Intl.message(
      'Account',
      name: 'menuAccount',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get menuSetting {
    return Intl.message(
      'Settings',
      name: 'menuSetting',
      desc: '',
      args: [],
    );
  }

  /// `Expense`
  String get expense {
    return Intl.message(
      'Expense',
      name: 'expense',
      desc: '',
      args: [],
    );
  }

  /// `Income`
  String get income {
    return Intl.message(
      'Income',
      name: 'income',
      desc: '',
      args: [],
    );
  }

  /// `Write a memo`
  String get noteHint {
    return Intl.message(
      'Write a memo',
      name: 'noteHint',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `All Category`
  String get allCategory {
    return Intl.message(
      'All Category',
      name: 'allCategory',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `All Account`
  String get allAccount {
    return Intl.message(
      'All Account',
      name: 'allAccount',
      desc: '',
      args: [],
    );
  }

  /// `Show more`
  String get showMore {
    return Intl.message(
      'Show more',
      name: 'showMore',
      desc: '',
      args: [],
    );
  }

  /// `Histories`
  String get histories {
    return Intl.message(
      'Histories',
      name: 'histories',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get daily {
    return Intl.message(
      'Daily',
      name: 'daily',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `Other Actions`
  String get otherMenu {
    return Intl.message(
      'Other Actions',
      name: 'otherMenu',
      desc: '',
      args: [],
    );
  }

  /// `Create Transaction`
  String get createTransactionTitle {
    return Intl.message(
      'Create Transaction',
      name: 'createTransactionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Record new transaction with form`
  String get createTransactionSubtitle {
    return Intl.message(
      'Record new transaction with form',
      name: 'createTransactionSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Create Transfer`
  String get createTransferitle {
    return Intl.message(
      'Create Transfer',
      name: 'createTransferitle',
      desc: '',
      args: [],
    );
  }

  /// `Send to other account with form`
  String get createTransferSubtitle {
    return Intl.message(
      'Send to other account with form',
      name: 'createTransferSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Amount Value`
  String get amountValue {
    return Intl.message(
      'Amount Value',
      name: 'amountValue',
      desc: '',
      args: [],
    );
  }

  /// `Memo`
  String get memo {
    return Intl.message(
      'Memo',
      name: 'memo',
      desc: '',
      args: [],
    );
  }

  /// `Description memo for transaction`
  String get memoHint {
    return Intl.message(
      'Description memo for transaction',
      name: 'memoHint',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Account Source`
  String get accountSource {
    return Intl.message(
      'Account Source',
      name: 'accountSource',
      desc: '',
      args: [],
    );
  }

  /// `Account Target`
  String get accountTarget {
    return Intl.message(
      'Account Target',
      name: 'accountTarget',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Detail`
  String get transferDetail {
    return Intl.message(
      'Transfer Detail',
      name: 'transferDetail',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Detail`
  String get transactionDetail {
    return Intl.message(
      'Transaction Detail',
      name: 'transactionDetail',
      desc: '',
      args: [],
    );
  }

  /// `Remove Data`
  String get removeData {
    return Intl.message(
      'Remove Data',
      name: 'removeData',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure want to remove this?`
  String get removeDataDesc {
    return Intl.message(
      'Are you sure want to remove this?',
      name: 'removeDataDesc',
      desc: '',
      args: [],
    );
  }

  /// `Yes, sure`
  String get yesSure {
    return Intl.message(
      'Yes, sure',
      name: 'yesSure',
      desc: '',
      args: [],
    );
  }

  /// `No, Cancel`
  String get noCancel {
    return Intl.message(
      'No, Cancel',
      name: 'noCancel',
      desc: '',
      args: [],
    );
  }

  /// `Accounts`
  String get accounts {
    return Intl.message(
      'Accounts',
      name: 'accounts',
      desc: '',
      args: [],
    );
  }

  /// `My Balance`
  String get myBalance {
    return Intl.message(
      'My Balance',
      name: 'myBalance',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get transfer {
    return Intl.message(
      'Transfer',
      name: 'transfer',
      desc: '',
      args: [],
    );
  }

  /// `Transfer to`
  String get transferTo {
    return Intl.message(
      'Transfer to',
      name: 'transferTo',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `When set to inactive,\n it will not appear on the list.`
  String get activeDesc {
    return Intl.message(
      'When set to inactive,\n it will not appear on the list.',
      name: 'activeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Icon Image`
  String get iconImage {
    return Intl.message(
      'Icon Image',
      name: 'iconImage',
      desc: '',
      args: [],
    );
  }

  /// `This image will show on list and chips`
  String get iconImageDesc {
    return Intl.message(
      'This image will show on list and chips',
      name: 'iconImageDesc',
      desc: '',
      args: [],
    );
  }

  /// `Manage Tips`
  String get manageTips {
    return Intl.message(
      'Manage Tips',
      name: 'manageTips',
      desc: '',
      args: [],
    );
  }

  /// `Press and hold the item to active reoder list feature`
  String get manageTipsDesc {
    return Intl.message(
      'Press and hold the item to active reoder list feature',
      name: 'manageTipsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Reorder`
  String get reorder {
    return Intl.message(
      'Reorder',
      name: 'reorder',
      desc: '',
      args: [],
    );
  }

  /// `Expense Categories`
  String get expenseCategories {
    return Intl.message(
      'Expense Categories',
      name: 'expenseCategories',
      desc: '',
      args: [],
    );
  }

  /// `Create Category`
  String get createCategory {
    return Intl.message(
      'Create Category',
      name: 'createCategory',
      desc: '',
      args: [],
    );
  }

  /// `Income Categories`
  String get incomeCategories {
    return Intl.message(
      'Income Categories',
      name: 'incomeCategories',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get security {
    return Intl.message(
      'Security',
      name: 'security',
      desc: '',
      args: [],
    );
  }

  /// `Secure App`
  String get secureApp {
    return Intl.message(
      'Secure App',
      name: 'secureApp',
      desc: '',
      args: [],
    );
  }

  /// `Change PIN`
  String get changePIN {
    return Intl.message(
      'Change PIN',
      name: 'changePIN',
      desc: '',
      args: [],
    );
  }

  /// `Biometric Lock`
  String get biometric {
    return Intl.message(
      'Biometric Lock',
      name: 'biometric',
      desc: '',
      args: [],
    );
  }

  /// `Set PIN to secure your data`
  String get setPinDesc {
    return Intl.message(
      'Set PIN to secure your data',
      name: 'setPinDesc',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Scan for enable biometric`
  String get hintBiometric {
    return Intl.message(
      'Scan for enable biometric',
      name: 'hintBiometric',
      desc: '',
      args: [],
    );
  }

  /// `Enter your PIN`
  String get enterYourPin {
    return Intl.message(
      'Enter your PIN',
      name: 'enterYourPin',
      desc: '',
      args: [],
    );
  }

  /// `PIN is incorect`
  String get pinIsIncorrect {
    return Intl.message(
      'PIN is incorect',
      name: 'pinIsIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Save record success`
  String get saveRecordSuccess {
    return Intl.message(
      'Save record success',
      name: 'saveRecordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Update record success`
  String get updateRecordSuccess {
    return Intl.message(
      'Update record success',
      name: 'updateRecordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Transfer success`
  String get transferSuccess {
    return Intl.message(
      'Transfer success',
      name: 'transferSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Update transfer success`
  String get transferUpdateSuccess {
    return Intl.message(
      'Update transfer success',
      name: 'transferUpdateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'id'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
