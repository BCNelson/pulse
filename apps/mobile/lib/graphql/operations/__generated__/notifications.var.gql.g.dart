// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GNotificationsInboxVars> _$gNotificationsInboxVarsSerializer =
    _$GNotificationsInboxVarsSerializer();
Serializer<GMarkNotificationReadVars> _$gMarkNotificationReadVarsSerializer =
    _$GMarkNotificationReadVarsSerializer();
Serializer<GMarkAllNotificationsReadVars>
    _$gMarkAllNotificationsReadVarsSerializer =
    _$GMarkAllNotificationsReadVarsSerializer();
Serializer<GNotificationReceivedVars> _$gNotificationReceivedVarsSerializer =
    _$GNotificationReceivedVarsSerializer();
Serializer<GNotificationSummaryVars> _$gNotificationSummaryVarsSerializer =
    _$GNotificationSummaryVarsSerializer();

class _$GNotificationsInboxVarsSerializer
    implements StructuredSerializer<GNotificationsInboxVars> {
  @override
  final Iterable<Type> types = const [
    GNotificationsInboxVars,
    _$GNotificationsInboxVars
  ];
  @override
  final String wireName = 'GNotificationsInboxVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GNotificationsInboxVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.first;
    if (value != null) {
      result
        ..add('first')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.unreadOnly;
    if (value != null) {
      result
        ..add('unreadOnly')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  GNotificationsInboxVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationsInboxVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'first':
          result.first = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'unreadOnly':
          result.unreadOnly = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkNotificationReadVarsSerializer
    implements StructuredSerializer<GMarkNotificationReadVars> {
  @override
  final Iterable<Type> types = const [
    GMarkNotificationReadVars,
    _$GMarkNotificationReadVars
  ];
  @override
  final String wireName = 'GMarkNotificationReadVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMarkNotificationReadVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'ids',
      serializers.serialize(object.ids,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  GMarkNotificationReadVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMarkNotificationReadVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'ids':
          result.ids.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkAllNotificationsReadVarsSerializer
    implements StructuredSerializer<GMarkAllNotificationsReadVars> {
  @override
  final Iterable<Type> types = const [
    GMarkAllNotificationsReadVars,
    _$GMarkAllNotificationsReadVars
  ];
  @override
  final String wireName = 'GMarkAllNotificationsReadVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMarkAllNotificationsReadVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GMarkAllNotificationsReadVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GMarkAllNotificationsReadVarsBuilder().build();
  }
}

class _$GNotificationReceivedVarsSerializer
    implements StructuredSerializer<GNotificationReceivedVars> {
  @override
  final Iterable<Type> types = const [
    GNotificationReceivedVars,
    _$GNotificationReceivedVars
  ];
  @override
  final String wireName = 'GNotificationReceivedVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GNotificationReceivedVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GNotificationReceivedVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GNotificationReceivedVarsBuilder().build();
  }
}

class _$GNotificationSummaryVarsSerializer
    implements StructuredSerializer<GNotificationSummaryVars> {
  @override
  final Iterable<Type> types = const [
    GNotificationSummaryVars,
    _$GNotificationSummaryVars
  ];
  @override
  final String wireName = 'GNotificationSummaryVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GNotificationSummaryVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GNotificationSummaryVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GNotificationSummaryVarsBuilder().build();
  }
}

class _$GNotificationsInboxVars extends GNotificationsInboxVars {
  @override
  final int? first;
  @override
  final bool? unreadOnly;

  factory _$GNotificationsInboxVars(
          [void Function(GNotificationsInboxVarsBuilder)? updates]) =>
      (GNotificationsInboxVarsBuilder()..update(updates))._build();

  _$GNotificationsInboxVars._({this.first, this.unreadOnly}) : super._();
  @override
  GNotificationsInboxVars rebuild(
          void Function(GNotificationsInboxVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationsInboxVarsBuilder toBuilder() =>
      GNotificationsInboxVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationsInboxVars &&
        first == other.first &&
        unreadOnly == other.unreadOnly;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, first.hashCode);
    _$hash = $jc(_$hash, unreadOnly.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GNotificationsInboxVars')
          ..add('first', first)
          ..add('unreadOnly', unreadOnly))
        .toString();
  }
}

class GNotificationsInboxVarsBuilder
    implements
        Builder<GNotificationsInboxVars, GNotificationsInboxVarsBuilder> {
  _$GNotificationsInboxVars? _$v;

  int? _first;
  int? get first => _$this._first;
  set first(int? first) => _$this._first = first;

  bool? _unreadOnly;
  bool? get unreadOnly => _$this._unreadOnly;
  set unreadOnly(bool? unreadOnly) => _$this._unreadOnly = unreadOnly;

  GNotificationsInboxVarsBuilder();

  GNotificationsInboxVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _first = $v.first;
      _unreadOnly = $v.unreadOnly;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationsInboxVars other) {
    _$v = other as _$GNotificationsInboxVars;
  }

  @override
  void update(void Function(GNotificationsInboxVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationsInboxVars build() => _build();

  _$GNotificationsInboxVars _build() {
    final _$result = _$v ??
        _$GNotificationsInboxVars._(
          first: first,
          unreadOnly: unreadOnly,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMarkNotificationReadVars extends GMarkNotificationReadVars {
  @override
  final BuiltList<String> ids;

  factory _$GMarkNotificationReadVars(
          [void Function(GMarkNotificationReadVarsBuilder)? updates]) =>
      (GMarkNotificationReadVarsBuilder()..update(updates))._build();

  _$GMarkNotificationReadVars._({required this.ids}) : super._();
  @override
  GMarkNotificationReadVars rebuild(
          void Function(GMarkNotificationReadVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMarkNotificationReadVarsBuilder toBuilder() =>
      GMarkNotificationReadVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkNotificationReadVars && ids == other.ids;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, ids.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMarkNotificationReadVars')
          ..add('ids', ids))
        .toString();
  }
}

class GMarkNotificationReadVarsBuilder
    implements
        Builder<GMarkNotificationReadVars, GMarkNotificationReadVarsBuilder> {
  _$GMarkNotificationReadVars? _$v;

  ListBuilder<String>? _ids;
  ListBuilder<String> get ids => _$this._ids ??= ListBuilder<String>();
  set ids(ListBuilder<String>? ids) => _$this._ids = ids;

  GMarkNotificationReadVarsBuilder();

  GMarkNotificationReadVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _ids = $v.ids.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkNotificationReadVars other) {
    _$v = other as _$GMarkNotificationReadVars;
  }

  @override
  void update(void Function(GMarkNotificationReadVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkNotificationReadVars build() => _build();

  _$GMarkNotificationReadVars _build() {
    _$GMarkNotificationReadVars _$result;
    try {
      _$result = _$v ??
          _$GMarkNotificationReadVars._(
            ids: ids.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'ids';
        ids.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMarkNotificationReadVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMarkAllNotificationsReadVars extends GMarkAllNotificationsReadVars {
  factory _$GMarkAllNotificationsReadVars(
          [void Function(GMarkAllNotificationsReadVarsBuilder)? updates]) =>
      (GMarkAllNotificationsReadVarsBuilder()..update(updates))._build();

  _$GMarkAllNotificationsReadVars._() : super._();
  @override
  GMarkAllNotificationsReadVars rebuild(
          void Function(GMarkAllNotificationsReadVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMarkAllNotificationsReadVarsBuilder toBuilder() =>
      GMarkAllNotificationsReadVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkAllNotificationsReadVars;
  }

  @override
  int get hashCode {
    return 58144821;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GMarkAllNotificationsReadVars')
        .toString();
  }
}

class GMarkAllNotificationsReadVarsBuilder
    implements
        Builder<GMarkAllNotificationsReadVars,
            GMarkAllNotificationsReadVarsBuilder> {
  _$GMarkAllNotificationsReadVars? _$v;

  GMarkAllNotificationsReadVarsBuilder();

  @override
  void replace(GMarkAllNotificationsReadVars other) {
    _$v = other as _$GMarkAllNotificationsReadVars;
  }

  @override
  void update(void Function(GMarkAllNotificationsReadVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkAllNotificationsReadVars build() => _build();

  _$GMarkAllNotificationsReadVars _build() {
    final _$result = _$v ?? _$GMarkAllNotificationsReadVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationReceivedVars extends GNotificationReceivedVars {
  factory _$GNotificationReceivedVars(
          [void Function(GNotificationReceivedVarsBuilder)? updates]) =>
      (GNotificationReceivedVarsBuilder()..update(updates))._build();

  _$GNotificationReceivedVars._() : super._();
  @override
  GNotificationReceivedVars rebuild(
          void Function(GNotificationReceivedVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationReceivedVarsBuilder toBuilder() =>
      GNotificationReceivedVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationReceivedVars;
  }

  @override
  int get hashCode {
    return 17279227;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GNotificationReceivedVars').toString();
  }
}

class GNotificationReceivedVarsBuilder
    implements
        Builder<GNotificationReceivedVars, GNotificationReceivedVarsBuilder> {
  _$GNotificationReceivedVars? _$v;

  GNotificationReceivedVarsBuilder();

  @override
  void replace(GNotificationReceivedVars other) {
    _$v = other as _$GNotificationReceivedVars;
  }

  @override
  void update(void Function(GNotificationReceivedVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationReceivedVars build() => _build();

  _$GNotificationReceivedVars _build() {
    final _$result = _$v ?? _$GNotificationReceivedVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationSummaryVars extends GNotificationSummaryVars {
  factory _$GNotificationSummaryVars(
          [void Function(GNotificationSummaryVarsBuilder)? updates]) =>
      (GNotificationSummaryVarsBuilder()..update(updates))._build();

  _$GNotificationSummaryVars._() : super._();
  @override
  GNotificationSummaryVars rebuild(
          void Function(GNotificationSummaryVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationSummaryVarsBuilder toBuilder() =>
      GNotificationSummaryVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationSummaryVars;
  }

  @override
  int get hashCode {
    return 381360762;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GNotificationSummaryVars').toString();
  }
}

class GNotificationSummaryVarsBuilder
    implements
        Builder<GNotificationSummaryVars, GNotificationSummaryVarsBuilder> {
  _$GNotificationSummaryVars? _$v;

  GNotificationSummaryVarsBuilder();

  @override
  void replace(GNotificationSummaryVars other) {
    _$v = other as _$GNotificationSummaryVars;
  }

  @override
  void update(void Function(GNotificationSummaryVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationSummaryVars build() => _build();

  _$GNotificationSummaryVars _build() {
    final _$result = _$v ?? _$GNotificationSummaryVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
