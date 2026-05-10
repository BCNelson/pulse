// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewer.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GViewerVars> _$gViewerVarsSerializer = _$GViewerVarsSerializer();

class _$GViewerVarsSerializer implements StructuredSerializer<GViewerVars> {
  @override
  final Iterable<Type> types = const [GViewerVars, _$GViewerVars];
  @override
  final String wireName = 'GViewerVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GViewerVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GViewerVars deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GViewerVarsBuilder().build();
  }
}

class _$GViewerVars extends GViewerVars {
  factory _$GViewerVars([void Function(GViewerVarsBuilder)? updates]) =>
      (GViewerVarsBuilder()..update(updates))._build();

  _$GViewerVars._() : super._();
  @override
  GViewerVars rebuild(void Function(GViewerVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GViewerVarsBuilder toBuilder() => GViewerVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GViewerVars;
  }

  @override
  int get hashCode {
    return 587048059;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GViewerVars').toString();
  }
}

class GViewerVarsBuilder implements Builder<GViewerVars, GViewerVarsBuilder> {
  _$GViewerVars? _$v;

  GViewerVarsBuilder();

  @override
  void replace(GViewerVars other) {
    _$v = other as _$GViewerVars;
  }

  @override
  void update(void Function(GViewerVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GViewerVars build() => _build();

  _$GViewerVars _build() {
    final _$result = _$v ?? _$GViewerVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
