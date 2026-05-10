// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GHealthVars> _$gHealthVarsSerializer = _$GHealthVarsSerializer();

class _$GHealthVarsSerializer implements StructuredSerializer<GHealthVars> {
  @override
  final Iterable<Type> types = const [GHealthVars, _$GHealthVars];
  @override
  final String wireName = 'GHealthVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GHealthVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GHealthVars deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GHealthVarsBuilder().build();
  }
}

class _$GHealthVars extends GHealthVars {
  factory _$GHealthVars([void Function(GHealthVarsBuilder)? updates]) =>
      (GHealthVarsBuilder()..update(updates))._build();

  _$GHealthVars._() : super._();
  @override
  GHealthVars rebuild(void Function(GHealthVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GHealthVarsBuilder toBuilder() => GHealthVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GHealthVars;
  }

  @override
  int get hashCode {
    return 927791948;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GHealthVars').toString();
  }
}

class GHealthVarsBuilder implements Builder<GHealthVars, GHealthVarsBuilder> {
  _$GHealthVars? _$v;

  GHealthVarsBuilder();

  @override
  void replace(GHealthVars other) {
    _$v = other as _$GHealthVars;
  }

  @override
  void update(void Function(GHealthVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GHealthVars build() => _build();

  _$GHealthVars _build() {
    final _$result = _$v ?? _$GHealthVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
