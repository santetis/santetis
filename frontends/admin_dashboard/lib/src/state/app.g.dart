// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppState on AppStateBase, Store {
  final _$isAppInitializedAtom = Atom(name: 'AppStateBase.isAppInitialized');

  @override
  bool get isAppInitialized {
    _$isAppInitializedAtom.context.enforceReadPolicy(_$isAppInitializedAtom);
    _$isAppInitializedAtom.reportObserved();
    return super.isAppInitialized;
  }

  @override
  set isAppInitialized(bool value) {
    _$isAppInitializedAtom.context.conditionallyRunInAction(() {
      super.isAppInitialized = value;
      _$isAppInitializedAtom.reportChanged();
    }, _$isAppInitializedAtom, name: '${_$isAppInitializedAtom.name}_set');
  }

  final _$userAtom = Atom(name: 'AppStateBase.user');

  @override
  UserState get user {
    _$userAtom.context.enforceReadPolicy(_$userAtom);
    _$userAtom.reportObserved();
    return super.user;
  }

  @override
  set user(UserState value) {
    _$userAtom.context.conditionallyRunInAction(() {
      super.user = value;
      _$userAtom.reportChanged();
    }, _$userAtom, name: '${_$userAtom.name}_set');
  }

  final _$initAsyncAction = AsyncAction('init');

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }
}
