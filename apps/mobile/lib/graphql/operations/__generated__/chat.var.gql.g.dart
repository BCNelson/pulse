// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GChatRoomDetailVars> _$gChatRoomDetailVarsSerializer =
    _$GChatRoomDetailVarsSerializer();
Serializer<GSendMessageVars> _$gSendMessageVarsSerializer =
    _$GSendMessageVarsSerializer();
Serializer<GCreateChatRoomVars> _$gCreateChatRoomVarsSerializer =
    _$GCreateChatRoomVarsSerializer();
Serializer<GMessageAddedVars> _$gMessageAddedVarsSerializer =
    _$GMessageAddedVarsSerializer();
Serializer<GMessageSummaryVars> _$gMessageSummaryVarsSerializer =
    _$GMessageSummaryVarsSerializer();
Serializer<GChatRoomSummaryVars> _$gChatRoomSummaryVarsSerializer =
    _$GChatRoomSummaryVarsSerializer();

class _$GChatRoomDetailVarsSerializer
    implements StructuredSerializer<GChatRoomDetailVars> {
  @override
  final Iterable<Type> types = const [
    GChatRoomDetailVars,
    _$GChatRoomDetailVars
  ];
  @override
  final String wireName = 'GChatRoomDetailVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GChatRoomDetailVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GChatRoomDetailVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GChatRoomDetailVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GSendMessageVarsSerializer
    implements StructuredSerializer<GSendMessageVars> {
  @override
  final Iterable<Type> types = const [GSendMessageVars, _$GSendMessageVars];
  @override
  final String wireName = 'GSendMessageVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSendMessageVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i2.GSendMessageInput)),
    ];

    return result;
  }

  @override
  GSendMessageVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSendMessageVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GSendMessageInput))!
              as _i2.GSendMessageInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateChatRoomVarsSerializer
    implements StructuredSerializer<GCreateChatRoomVars> {
  @override
  final Iterable<Type> types = const [
    GCreateChatRoomVars,
    _$GCreateChatRoomVars
  ];
  @override
  final String wireName = 'GCreateChatRoomVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateChatRoomVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i2.GCreateChatRoomInput)),
    ];

    return result;
  }

  @override
  GCreateChatRoomVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreateChatRoomVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GCreateChatRoomInput))!
              as _i2.GCreateChatRoomInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GMessageAddedVarsSerializer
    implements StructuredSerializer<GMessageAddedVars> {
  @override
  final Iterable<Type> types = const [GMessageAddedVars, _$GMessageAddedVars];
  @override
  final String wireName = 'GMessageAddedVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GMessageAddedVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GMessageAddedVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMessageAddedVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'roomId':
          result.roomId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GMessageSummaryVarsSerializer
    implements StructuredSerializer<GMessageSummaryVars> {
  @override
  final Iterable<Type> types = const [
    GMessageSummaryVars,
    _$GMessageSummaryVars
  ];
  @override
  final String wireName = 'GMessageSummaryVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMessageSummaryVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GMessageSummaryVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GMessageSummaryVarsBuilder().build();
  }
}

class _$GChatRoomSummaryVarsSerializer
    implements StructuredSerializer<GChatRoomSummaryVars> {
  @override
  final Iterable<Type> types = const [
    GChatRoomSummaryVars,
    _$GChatRoomSummaryVars
  ];
  @override
  final String wireName = 'GChatRoomSummaryVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GChatRoomSummaryVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GChatRoomSummaryVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GChatRoomSummaryVarsBuilder().build();
  }
}

class _$GChatRoomDetailVars extends GChatRoomDetailVars {
  @override
  final String id;

  factory _$GChatRoomDetailVars(
          [void Function(GChatRoomDetailVarsBuilder)? updates]) =>
      (GChatRoomDetailVarsBuilder()..update(updates))._build();

  _$GChatRoomDetailVars._({required this.id}) : super._();
  @override
  GChatRoomDetailVars rebuild(
          void Function(GChatRoomDetailVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GChatRoomDetailVarsBuilder toBuilder() =>
      GChatRoomDetailVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GChatRoomDetailVars && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GChatRoomDetailVars')..add('id', id))
        .toString();
  }
}

class GChatRoomDetailVarsBuilder
    implements Builder<GChatRoomDetailVars, GChatRoomDetailVarsBuilder> {
  _$GChatRoomDetailVars? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GChatRoomDetailVarsBuilder();

  GChatRoomDetailVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GChatRoomDetailVars other) {
    _$v = other as _$GChatRoomDetailVars;
  }

  @override
  void update(void Function(GChatRoomDetailVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GChatRoomDetailVars build() => _build();

  _$GChatRoomDetailVars _build() {
    final _$result = _$v ??
        _$GChatRoomDetailVars._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GChatRoomDetailVars', 'id'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GSendMessageVars extends GSendMessageVars {
  @override
  final _i2.GSendMessageInput input;

  factory _$GSendMessageVars(
          [void Function(GSendMessageVarsBuilder)? updates]) =>
      (GSendMessageVarsBuilder()..update(updates))._build();

  _$GSendMessageVars._({required this.input}) : super._();
  @override
  GSendMessageVars rebuild(void Function(GSendMessageVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendMessageVarsBuilder toBuilder() =>
      GSendMessageVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendMessageVars && input == other.input;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, input.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendMessageVars')
          ..add('input', input))
        .toString();
  }
}

class GSendMessageVarsBuilder
    implements Builder<GSendMessageVars, GSendMessageVarsBuilder> {
  _$GSendMessageVars? _$v;

  _i2.GSendMessageInputBuilder? _input;
  _i2.GSendMessageInputBuilder get input =>
      _$this._input ??= _i2.GSendMessageInputBuilder();
  set input(_i2.GSendMessageInputBuilder? input) => _$this._input = input;

  GSendMessageVarsBuilder();

  GSendMessageVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendMessageVars other) {
    _$v = other as _$GSendMessageVars;
  }

  @override
  void update(void Function(GSendMessageVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendMessageVars build() => _build();

  _$GSendMessageVars _build() {
    _$GSendMessageVars _$result;
    try {
      _$result = _$v ??
          _$GSendMessageVars._(
            input: input.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GSendMessageVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateChatRoomVars extends GCreateChatRoomVars {
  @override
  final _i2.GCreateChatRoomInput input;

  factory _$GCreateChatRoomVars(
          [void Function(GCreateChatRoomVarsBuilder)? updates]) =>
      (GCreateChatRoomVarsBuilder()..update(updates))._build();

  _$GCreateChatRoomVars._({required this.input}) : super._();
  @override
  GCreateChatRoomVars rebuild(
          void Function(GCreateChatRoomVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateChatRoomVarsBuilder toBuilder() =>
      GCreateChatRoomVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateChatRoomVars && input == other.input;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, input.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateChatRoomVars')
          ..add('input', input))
        .toString();
  }
}

class GCreateChatRoomVarsBuilder
    implements Builder<GCreateChatRoomVars, GCreateChatRoomVarsBuilder> {
  _$GCreateChatRoomVars? _$v;

  _i2.GCreateChatRoomInputBuilder? _input;
  _i2.GCreateChatRoomInputBuilder get input =>
      _$this._input ??= _i2.GCreateChatRoomInputBuilder();
  set input(_i2.GCreateChatRoomInputBuilder? input) => _$this._input = input;

  GCreateChatRoomVarsBuilder();

  GCreateChatRoomVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateChatRoomVars other) {
    _$v = other as _$GCreateChatRoomVars;
  }

  @override
  void update(void Function(GCreateChatRoomVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateChatRoomVars build() => _build();

  _$GCreateChatRoomVars _build() {
    _$GCreateChatRoomVars _$result;
    try {
      _$result = _$v ??
          _$GCreateChatRoomVars._(
            input: input.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GCreateChatRoomVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMessageAddedVars extends GMessageAddedVars {
  @override
  final String roomId;

  factory _$GMessageAddedVars(
          [void Function(GMessageAddedVarsBuilder)? updates]) =>
      (GMessageAddedVarsBuilder()..update(updates))._build();

  _$GMessageAddedVars._({required this.roomId}) : super._();
  @override
  GMessageAddedVars rebuild(void Function(GMessageAddedVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMessageAddedVarsBuilder toBuilder() =>
      GMessageAddedVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMessageAddedVars && roomId == other.roomId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMessageAddedVars')
          ..add('roomId', roomId))
        .toString();
  }
}

class GMessageAddedVarsBuilder
    implements Builder<GMessageAddedVars, GMessageAddedVarsBuilder> {
  _$GMessageAddedVars? _$v;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  GMessageAddedVarsBuilder();

  GMessageAddedVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roomId = $v.roomId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMessageAddedVars other) {
    _$v = other as _$GMessageAddedVars;
  }

  @override
  void update(void Function(GMessageAddedVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMessageAddedVars build() => _build();

  _$GMessageAddedVars _build() {
    final _$result = _$v ??
        _$GMessageAddedVars._(
          roomId: BuiltValueNullFieldError.checkNotNull(
              roomId, r'GMessageAddedVars', 'roomId'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMessageSummaryVars extends GMessageSummaryVars {
  factory _$GMessageSummaryVars(
          [void Function(GMessageSummaryVarsBuilder)? updates]) =>
      (GMessageSummaryVarsBuilder()..update(updates))._build();

  _$GMessageSummaryVars._() : super._();
  @override
  GMessageSummaryVars rebuild(
          void Function(GMessageSummaryVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMessageSummaryVarsBuilder toBuilder() =>
      GMessageSummaryVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMessageSummaryVars;
  }

  @override
  int get hashCode {
    return 589066355;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GMessageSummaryVars').toString();
  }
}

class GMessageSummaryVarsBuilder
    implements Builder<GMessageSummaryVars, GMessageSummaryVarsBuilder> {
  _$GMessageSummaryVars? _$v;

  GMessageSummaryVarsBuilder();

  @override
  void replace(GMessageSummaryVars other) {
    _$v = other as _$GMessageSummaryVars;
  }

  @override
  void update(void Function(GMessageSummaryVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMessageSummaryVars build() => _build();

  _$GMessageSummaryVars _build() {
    final _$result = _$v ?? _$GMessageSummaryVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GChatRoomSummaryVars extends GChatRoomSummaryVars {
  factory _$GChatRoomSummaryVars(
          [void Function(GChatRoomSummaryVarsBuilder)? updates]) =>
      (GChatRoomSummaryVarsBuilder()..update(updates))._build();

  _$GChatRoomSummaryVars._() : super._();
  @override
  GChatRoomSummaryVars rebuild(
          void Function(GChatRoomSummaryVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GChatRoomSummaryVarsBuilder toBuilder() =>
      GChatRoomSummaryVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GChatRoomSummaryVars;
  }

  @override
  int get hashCode {
    return 724060298;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GChatRoomSummaryVars').toString();
  }
}

class GChatRoomSummaryVarsBuilder
    implements Builder<GChatRoomSummaryVars, GChatRoomSummaryVarsBuilder> {
  _$GChatRoomSummaryVars? _$v;

  GChatRoomSummaryVarsBuilder();

  @override
  void replace(GChatRoomSummaryVars other) {
    _$v = other as _$GChatRoomSummaryVars;
  }

  @override
  void update(void Function(GChatRoomSummaryVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GChatRoomSummaryVars build() => _build();

  _$GChatRoomSummaryVars _build() {
    final _$result = _$v ?? _$GChatRoomSummaryVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
