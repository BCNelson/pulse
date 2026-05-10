// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'impersonation.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GViewerImpersonationStateData>
    _$gViewerImpersonationStateDataSerializer =
    _$GViewerImpersonationStateDataSerializer();
Serializer<GViewerImpersonationStateData_viewerImpersonationState>
    _$gViewerImpersonationStateDataViewerImpersonationStateSerializer =
    _$GViewerImpersonationStateData_viewerImpersonationStateSerializer();
Serializer<GViewerImpersonationStateData_viewerImpersonationState_acting>
    _$gViewerImpersonationStateDataViewerImpersonationStateActingSerializer =
    _$GViewerImpersonationStateData_viewerImpersonationState_actingSerializer();
Serializer<GViewerImpersonationStateData_viewerImpersonationState_effective>
    _$gViewerImpersonationStateDataViewerImpersonationStateEffectiveSerializer =
    _$GViewerImpersonationStateData_viewerImpersonationState_effectiveSerializer();
Serializer<GImpersonateData> _$gImpersonateDataSerializer =
    _$GImpersonateDataSerializer();
Serializer<GImpersonateData_impersonate>
    _$gImpersonateDataImpersonateSerializer =
    _$GImpersonateData_impersonateSerializer();
Serializer<GImpersonateData_impersonate_acting>
    _$gImpersonateDataImpersonateActingSerializer =
    _$GImpersonateData_impersonate_actingSerializer();
Serializer<GImpersonateData_impersonate_effective>
    _$gImpersonateDataImpersonateEffectiveSerializer =
    _$GImpersonateData_impersonate_effectiveSerializer();
Serializer<GEndImpersonationData> _$gEndImpersonationDataSerializer =
    _$GEndImpersonationDataSerializer();
Serializer<GEndImpersonationData_endImpersonation>
    _$gEndImpersonationDataEndImpersonationSerializer =
    _$GEndImpersonationData_endImpersonationSerializer();
Serializer<GEndImpersonationData_endImpersonation_acting>
    _$gEndImpersonationDataEndImpersonationActingSerializer =
    _$GEndImpersonationData_endImpersonation_actingSerializer();
Serializer<GEndImpersonationData_endImpersonation_effective>
    _$gEndImpersonationDataEndImpersonationEffectiveSerializer =
    _$GEndImpersonationData_endImpersonation_effectiveSerializer();
Serializer<GRegisterDeviceTokenData> _$gRegisterDeviceTokenDataSerializer =
    _$GRegisterDeviceTokenDataSerializer();
Serializer<GUnregisterDeviceTokenData> _$gUnregisterDeviceTokenDataSerializer =
    _$GUnregisterDeviceTokenDataSerializer();

class _$GViewerImpersonationStateDataSerializer
    implements StructuredSerializer<GViewerImpersonationStateData> {
  @override
  final Iterable<Type> types = const [
    GViewerImpersonationStateData,
    _$GViewerImpersonationStateData
  ];
  @override
  final String wireName = 'GViewerImpersonationStateData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GViewerImpersonationStateData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'viewerImpersonationState',
      serializers.serialize(object.viewerImpersonationState,
          specifiedType: const FullType(
              GViewerImpersonationStateData_viewerImpersonationState)),
    ];

    return result;
  }

  @override
  GViewerImpersonationStateData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GViewerImpersonationStateDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'viewerImpersonationState':
          result.viewerImpersonationState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GViewerImpersonationStateData_viewerImpersonationState))!
              as GViewerImpersonationStateData_viewerImpersonationState);
          break;
      }
    }

    return result.build();
  }
}

class _$GViewerImpersonationStateData_viewerImpersonationStateSerializer
    implements
        StructuredSerializer<
            GViewerImpersonationStateData_viewerImpersonationState> {
  @override
  final Iterable<Type> types = const [
    GViewerImpersonationStateData_viewerImpersonationState,
    _$GViewerImpersonationStateData_viewerImpersonationState
  ];
  @override
  final String wireName =
      'GViewerImpersonationStateData_viewerImpersonationState';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GViewerImpersonationStateData_viewerImpersonationState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'isImpersonating',
      serializers.serialize(object.isImpersonating,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.acting;
    if (value != null) {
      result
        ..add('acting')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GViewerImpersonationStateData_viewerImpersonationState_acting)));
    }
    value = object.effective;
    if (value != null) {
      result
        ..add('effective')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GViewerImpersonationStateData_viewerImpersonationState_effective)));
    }
    return result;
  }

  @override
  GViewerImpersonationStateData_viewerImpersonationState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GViewerImpersonationStateData_viewerImpersonationStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'isImpersonating':
          result.isImpersonating = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'acting':
          result.acting.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GViewerImpersonationStateData_viewerImpersonationState_acting))!
              as GViewerImpersonationStateData_viewerImpersonationState_acting);
          break;
        case 'effective':
          result.effective.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GViewerImpersonationStateData_viewerImpersonationState_effective))!
              as GViewerImpersonationStateData_viewerImpersonationState_effective);
          break;
      }
    }

    return result.build();
  }
}

class _$GViewerImpersonationStateData_viewerImpersonationState_actingSerializer
    implements
        StructuredSerializer<
            GViewerImpersonationStateData_viewerImpersonationState_acting> {
  @override
  final Iterable<Type> types = const [
    GViewerImpersonationStateData_viewerImpersonationState_acting,
    _$GViewerImpersonationStateData_viewerImpersonationState_acting
  ];
  @override
  final String wireName =
      'GViewerImpersonationStateData_viewerImpersonationState_acting';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GViewerImpersonationStateData_viewerImpersonationState_acting object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GViewerImpersonationStateData_viewerImpersonationState_acting deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GViewerImpersonationStateData_viewerImpersonationState_actingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GViewerImpersonationStateData_viewerImpersonationState_effectiveSerializer
    implements
        StructuredSerializer<
            GViewerImpersonationStateData_viewerImpersonationState_effective> {
  @override
  final Iterable<Type> types = const [
    GViewerImpersonationStateData_viewerImpersonationState_effective,
    _$GViewerImpersonationStateData_viewerImpersonationState_effective
  ];
  @override
  final String wireName =
      'GViewerImpersonationStateData_viewerImpersonationState_effective';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GViewerImpersonationStateData_viewerImpersonationState_effective object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GViewerImpersonationStateData_viewerImpersonationState_effective deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GImpersonateDataSerializer
    implements StructuredSerializer<GImpersonateData> {
  @override
  final Iterable<Type> types = const [GImpersonateData, _$GImpersonateData];
  @override
  final String wireName = 'GImpersonateData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GImpersonateData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'impersonate',
      serializers.serialize(object.impersonate,
          specifiedType: const FullType(GImpersonateData_impersonate)),
    ];

    return result;
  }

  @override
  GImpersonateData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GImpersonateDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'impersonate':
          result.impersonate.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GImpersonateData_impersonate))!
              as GImpersonateData_impersonate);
          break;
      }
    }

    return result.build();
  }
}

class _$GImpersonateData_impersonateSerializer
    implements StructuredSerializer<GImpersonateData_impersonate> {
  @override
  final Iterable<Type> types = const [
    GImpersonateData_impersonate,
    _$GImpersonateData_impersonate
  ];
  @override
  final String wireName = 'GImpersonateData_impersonate';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GImpersonateData_impersonate object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'isImpersonating',
      serializers.serialize(object.isImpersonating,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.acting;
    if (value != null) {
      result
        ..add('acting')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GImpersonateData_impersonate_acting)));
    }
    value = object.effective;
    if (value != null) {
      result
        ..add('effective')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GImpersonateData_impersonate_effective)));
    }
    return result;
  }

  @override
  GImpersonateData_impersonate deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GImpersonateData_impersonateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'isImpersonating':
          result.isImpersonating = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'acting':
          result.acting.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GImpersonateData_impersonate_acting))!
              as GImpersonateData_impersonate_acting);
          break;
        case 'effective':
          result.effective.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GImpersonateData_impersonate_effective))!
              as GImpersonateData_impersonate_effective);
          break;
      }
    }

    return result.build();
  }
}

class _$GImpersonateData_impersonate_actingSerializer
    implements StructuredSerializer<GImpersonateData_impersonate_acting> {
  @override
  final Iterable<Type> types = const [
    GImpersonateData_impersonate_acting,
    _$GImpersonateData_impersonate_acting
  ];
  @override
  final String wireName = 'GImpersonateData_impersonate_acting';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GImpersonateData_impersonate_acting object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GImpersonateData_impersonate_acting deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GImpersonateData_impersonate_actingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GImpersonateData_impersonate_effectiveSerializer
    implements StructuredSerializer<GImpersonateData_impersonate_effective> {
  @override
  final Iterable<Type> types = const [
    GImpersonateData_impersonate_effective,
    _$GImpersonateData_impersonate_effective
  ];
  @override
  final String wireName = 'GImpersonateData_impersonate_effective';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GImpersonateData_impersonate_effective object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GImpersonateData_impersonate_effective deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GImpersonateData_impersonate_effectiveBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GEndImpersonationDataSerializer
    implements StructuredSerializer<GEndImpersonationData> {
  @override
  final Iterable<Type> types = const [
    GEndImpersonationData,
    _$GEndImpersonationData
  ];
  @override
  final String wireName = 'GEndImpersonationData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GEndImpersonationData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'endImpersonation',
      serializers.serialize(object.endImpersonation,
          specifiedType:
              const FullType(GEndImpersonationData_endImpersonation)),
    ];

    return result;
  }

  @override
  GEndImpersonationData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GEndImpersonationDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'endImpersonation':
          result.endImpersonation.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GEndImpersonationData_endImpersonation))!
              as GEndImpersonationData_endImpersonation);
          break;
      }
    }

    return result.build();
  }
}

class _$GEndImpersonationData_endImpersonationSerializer
    implements StructuredSerializer<GEndImpersonationData_endImpersonation> {
  @override
  final Iterable<Type> types = const [
    GEndImpersonationData_endImpersonation,
    _$GEndImpersonationData_endImpersonation
  ];
  @override
  final String wireName = 'GEndImpersonationData_endImpersonation';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GEndImpersonationData_endImpersonation object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'isImpersonating',
      serializers.serialize(object.isImpersonating,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.acting;
    if (value != null) {
      result
        ..add('acting')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GEndImpersonationData_endImpersonation_acting)));
    }
    value = object.effective;
    if (value != null) {
      result
        ..add('effective')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GEndImpersonationData_endImpersonation_effective)));
    }
    return result;
  }

  @override
  GEndImpersonationData_endImpersonation deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GEndImpersonationData_endImpersonationBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'isImpersonating':
          result.isImpersonating = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'acting':
          result.acting.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GEndImpersonationData_endImpersonation_acting))!
              as GEndImpersonationData_endImpersonation_acting);
          break;
        case 'effective':
          result.effective.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GEndImpersonationData_endImpersonation_effective))!
              as GEndImpersonationData_endImpersonation_effective);
          break;
      }
    }

    return result.build();
  }
}

class _$GEndImpersonationData_endImpersonation_actingSerializer
    implements
        StructuredSerializer<GEndImpersonationData_endImpersonation_acting> {
  @override
  final Iterable<Type> types = const [
    GEndImpersonationData_endImpersonation_acting,
    _$GEndImpersonationData_endImpersonation_acting
  ];
  @override
  final String wireName = 'GEndImpersonationData_endImpersonation_acting';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GEndImpersonationData_endImpersonation_acting object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GEndImpersonationData_endImpersonation_acting deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GEndImpersonationData_endImpersonation_actingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GEndImpersonationData_endImpersonation_effectiveSerializer
    implements
        StructuredSerializer<GEndImpersonationData_endImpersonation_effective> {
  @override
  final Iterable<Type> types = const [
    GEndImpersonationData_endImpersonation_effective,
    _$GEndImpersonationData_endImpersonation_effective
  ];
  @override
  final String wireName = 'GEndImpersonationData_endImpersonation_effective';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GEndImpersonationData_endImpersonation_effective object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GEndImpersonationData_endImpersonation_effective deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GEndImpersonationData_endImpersonation_effectiveBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterDeviceTokenDataSerializer
    implements StructuredSerializer<GRegisterDeviceTokenData> {
  @override
  final Iterable<Type> types = const [
    GRegisterDeviceTokenData,
    _$GRegisterDeviceTokenData
  ];
  @override
  final String wireName = 'GRegisterDeviceTokenData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRegisterDeviceTokenData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'registerDeviceToken',
      serializers.serialize(object.registerDeviceToken,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GRegisterDeviceTokenData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GRegisterDeviceTokenDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'registerDeviceToken':
          result.registerDeviceToken = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GUnregisterDeviceTokenDataSerializer
    implements StructuredSerializer<GUnregisterDeviceTokenData> {
  @override
  final Iterable<Type> types = const [
    GUnregisterDeviceTokenData,
    _$GUnregisterDeviceTokenData
  ];
  @override
  final String wireName = 'GUnregisterDeviceTokenData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUnregisterDeviceTokenData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'unregisterDeviceToken',
      serializers.serialize(object.unregisterDeviceToken,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GUnregisterDeviceTokenData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUnregisterDeviceTokenDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'unregisterDeviceToken':
          result.unregisterDeviceToken = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GViewerImpersonationStateData extends GViewerImpersonationStateData {
  @override
  final String G__typename;
  @override
  final GViewerImpersonationStateData_viewerImpersonationState
      viewerImpersonationState;

  factory _$GViewerImpersonationStateData(
          [void Function(GViewerImpersonationStateDataBuilder)? updates]) =>
      (GViewerImpersonationStateDataBuilder()..update(updates))._build();

  _$GViewerImpersonationStateData._(
      {required this.G__typename, required this.viewerImpersonationState})
      : super._();
  @override
  GViewerImpersonationStateData rebuild(
          void Function(GViewerImpersonationStateDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GViewerImpersonationStateDataBuilder toBuilder() =>
      GViewerImpersonationStateDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GViewerImpersonationStateData &&
        G__typename == other.G__typename &&
        viewerImpersonationState == other.viewerImpersonationState;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, viewerImpersonationState.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GViewerImpersonationStateData')
          ..add('G__typename', G__typename)
          ..add('viewerImpersonationState', viewerImpersonationState))
        .toString();
  }
}

class GViewerImpersonationStateDataBuilder
    implements
        Builder<GViewerImpersonationStateData,
            GViewerImpersonationStateDataBuilder> {
  _$GViewerImpersonationStateData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GViewerImpersonationStateData_viewerImpersonationStateBuilder?
      _viewerImpersonationState;
  GViewerImpersonationStateData_viewerImpersonationStateBuilder
      get viewerImpersonationState => _$this._viewerImpersonationState ??=
          GViewerImpersonationStateData_viewerImpersonationStateBuilder();
  set viewerImpersonationState(
          GViewerImpersonationStateData_viewerImpersonationStateBuilder?
              viewerImpersonationState) =>
      _$this._viewerImpersonationState = viewerImpersonationState;

  GViewerImpersonationStateDataBuilder() {
    GViewerImpersonationStateData._initializeBuilder(this);
  }

  GViewerImpersonationStateDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _viewerImpersonationState = $v.viewerImpersonationState.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GViewerImpersonationStateData other) {
    _$v = other as _$GViewerImpersonationStateData;
  }

  @override
  void update(void Function(GViewerImpersonationStateDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GViewerImpersonationStateData build() => _build();

  _$GViewerImpersonationStateData _build() {
    _$GViewerImpersonationStateData _$result;
    try {
      _$result = _$v ??
          _$GViewerImpersonationStateData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GViewerImpersonationStateData', 'G__typename'),
            viewerImpersonationState: viewerImpersonationState.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'viewerImpersonationState';
        viewerImpersonationState.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GViewerImpersonationStateData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GViewerImpersonationStateData_viewerImpersonationState
    extends GViewerImpersonationStateData_viewerImpersonationState {
  @override
  final String G__typename;
  @override
  final bool isImpersonating;
  @override
  final GViewerImpersonationStateData_viewerImpersonationState_acting? acting;
  @override
  final GViewerImpersonationStateData_viewerImpersonationState_effective?
      effective;

  factory _$GViewerImpersonationStateData_viewerImpersonationState(
          [void Function(
                  GViewerImpersonationStateData_viewerImpersonationStateBuilder)?
              updates]) =>
      (GViewerImpersonationStateData_viewerImpersonationStateBuilder()
            ..update(updates))
          ._build();

  _$GViewerImpersonationStateData_viewerImpersonationState._(
      {required this.G__typename,
      required this.isImpersonating,
      this.acting,
      this.effective})
      : super._();
  @override
  GViewerImpersonationStateData_viewerImpersonationState rebuild(
          void Function(
                  GViewerImpersonationStateData_viewerImpersonationStateBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GViewerImpersonationStateData_viewerImpersonationStateBuilder toBuilder() =>
      GViewerImpersonationStateData_viewerImpersonationStateBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GViewerImpersonationStateData_viewerImpersonationState &&
        G__typename == other.G__typename &&
        isImpersonating == other.isImpersonating &&
        acting == other.acting &&
        effective == other.effective;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, isImpersonating.hashCode);
    _$hash = $jc(_$hash, acting.hashCode);
    _$hash = $jc(_$hash, effective.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GViewerImpersonationStateData_viewerImpersonationState')
          ..add('G__typename', G__typename)
          ..add('isImpersonating', isImpersonating)
          ..add('acting', acting)
          ..add('effective', effective))
        .toString();
  }
}

class GViewerImpersonationStateData_viewerImpersonationStateBuilder
    implements
        Builder<GViewerImpersonationStateData_viewerImpersonationState,
            GViewerImpersonationStateData_viewerImpersonationStateBuilder> {
  _$GViewerImpersonationStateData_viewerImpersonationState? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _isImpersonating;
  bool? get isImpersonating => _$this._isImpersonating;
  set isImpersonating(bool? isImpersonating) =>
      _$this._isImpersonating = isImpersonating;

  GViewerImpersonationStateData_viewerImpersonationState_actingBuilder? _acting;
  GViewerImpersonationStateData_viewerImpersonationState_actingBuilder
      get acting => _$this._acting ??=
          GViewerImpersonationStateData_viewerImpersonationState_actingBuilder();
  set acting(
          GViewerImpersonationStateData_viewerImpersonationState_actingBuilder?
              acting) =>
      _$this._acting = acting;

  GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder?
      _effective;
  GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder
      get effective => _$this._effective ??=
          GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder();
  set effective(
          GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder?
              effective) =>
      _$this._effective = effective;

  GViewerImpersonationStateData_viewerImpersonationStateBuilder() {
    GViewerImpersonationStateData_viewerImpersonationState._initializeBuilder(
        this);
  }

  GViewerImpersonationStateData_viewerImpersonationStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _isImpersonating = $v.isImpersonating;
      _acting = $v.acting?.toBuilder();
      _effective = $v.effective?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GViewerImpersonationStateData_viewerImpersonationState other) {
    _$v = other as _$GViewerImpersonationStateData_viewerImpersonationState;
  }

  @override
  void update(
      void Function(
              GViewerImpersonationStateData_viewerImpersonationStateBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GViewerImpersonationStateData_viewerImpersonationState build() => _build();

  _$GViewerImpersonationStateData_viewerImpersonationState _build() {
    _$GViewerImpersonationStateData_viewerImpersonationState _$result;
    try {
      _$result = _$v ??
          _$GViewerImpersonationStateData_viewerImpersonationState._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GViewerImpersonationStateData_viewerImpersonationState',
                'G__typename'),
            isImpersonating: BuiltValueNullFieldError.checkNotNull(
                isImpersonating,
                r'GViewerImpersonationStateData_viewerImpersonationState',
                'isImpersonating'),
            acting: _acting?.build(),
            effective: _effective?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'acting';
        _acting?.build();
        _$failedField = 'effective';
        _effective?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GViewerImpersonationStateData_viewerImpersonationState',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GViewerImpersonationStateData_viewerImpersonationState_acting
    extends GViewerImpersonationStateData_viewerImpersonationState_acting {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GViewerImpersonationStateData_viewerImpersonationState_acting(
          [void Function(
                  GViewerImpersonationStateData_viewerImpersonationState_actingBuilder)?
              updates]) =>
      (GViewerImpersonationStateData_viewerImpersonationState_actingBuilder()
            ..update(updates))
          ._build();

  _$GViewerImpersonationStateData_viewerImpersonationState_acting._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GViewerImpersonationStateData_viewerImpersonationState_acting rebuild(
          void Function(
                  GViewerImpersonationStateData_viewerImpersonationState_actingBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GViewerImpersonationStateData_viewerImpersonationState_actingBuilder
      toBuilder() =>
          GViewerImpersonationStateData_viewerImpersonationState_actingBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GViewerImpersonationStateData_viewerImpersonationState_acting &&
        G__typename == other.G__typename &&
        id == other.id &&
        displayName == other.displayName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GViewerImpersonationStateData_viewerImpersonationState_acting')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GViewerImpersonationStateData_viewerImpersonationState_actingBuilder
    implements
        Builder<GViewerImpersonationStateData_viewerImpersonationState_acting,
            GViewerImpersonationStateData_viewerImpersonationState_actingBuilder> {
  _$GViewerImpersonationStateData_viewerImpersonationState_acting? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GViewerImpersonationStateData_viewerImpersonationState_actingBuilder() {
    GViewerImpersonationStateData_viewerImpersonationState_acting
        ._initializeBuilder(this);
  }

  GViewerImpersonationStateData_viewerImpersonationState_actingBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _displayName = $v.displayName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GViewerImpersonationStateData_viewerImpersonationState_acting other) {
    _$v = other
        as _$GViewerImpersonationStateData_viewerImpersonationState_acting;
  }

  @override
  void update(
      void Function(
              GViewerImpersonationStateData_viewerImpersonationState_actingBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GViewerImpersonationStateData_viewerImpersonationState_acting build() =>
      _build();

  _$GViewerImpersonationStateData_viewerImpersonationState_acting _build() {
    final _$result = _$v ??
        _$GViewerImpersonationStateData_viewerImpersonationState_acting._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GViewerImpersonationStateData_viewerImpersonationState_acting',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GViewerImpersonationStateData_viewerImpersonationState_acting',
              'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(
              displayName,
              r'GViewerImpersonationStateData_viewerImpersonationState_acting',
              'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GViewerImpersonationStateData_viewerImpersonationState_effective
    extends GViewerImpersonationStateData_viewerImpersonationState_effective {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GViewerImpersonationStateData_viewerImpersonationState_effective(
          [void Function(
                  GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder)?
              updates]) =>
      (GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder()
            ..update(updates))
          ._build();

  _$GViewerImpersonationStateData_viewerImpersonationState_effective._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GViewerImpersonationStateData_viewerImpersonationState_effective rebuild(
          void Function(
                  GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder
      toBuilder() =>
          GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GViewerImpersonationStateData_viewerImpersonationState_effective &&
        G__typename == other.G__typename &&
        id == other.id &&
        displayName == other.displayName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GViewerImpersonationStateData_viewerImpersonationState_effective')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder
    implements
        Builder<
            GViewerImpersonationStateData_viewerImpersonationState_effective,
            GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder> {
  _$GViewerImpersonationStateData_viewerImpersonationState_effective? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder() {
    GViewerImpersonationStateData_viewerImpersonationState_effective
        ._initializeBuilder(this);
  }

  GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _displayName = $v.displayName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GViewerImpersonationStateData_viewerImpersonationState_effective other) {
    _$v = other
        as _$GViewerImpersonationStateData_viewerImpersonationState_effective;
  }

  @override
  void update(
      void Function(
              GViewerImpersonationStateData_viewerImpersonationState_effectiveBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GViewerImpersonationStateData_viewerImpersonationState_effective build() =>
      _build();

  _$GViewerImpersonationStateData_viewerImpersonationState_effective _build() {
    final _$result = _$v ??
        _$GViewerImpersonationStateData_viewerImpersonationState_effective._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GViewerImpersonationStateData_viewerImpersonationState_effective',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GViewerImpersonationStateData_viewerImpersonationState_effective',
              'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(
              displayName,
              r'GViewerImpersonationStateData_viewerImpersonationState_effective',
              'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GImpersonateData extends GImpersonateData {
  @override
  final String G__typename;
  @override
  final GImpersonateData_impersonate impersonate;

  factory _$GImpersonateData(
          [void Function(GImpersonateDataBuilder)? updates]) =>
      (GImpersonateDataBuilder()..update(updates))._build();

  _$GImpersonateData._({required this.G__typename, required this.impersonate})
      : super._();
  @override
  GImpersonateData rebuild(void Function(GImpersonateDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GImpersonateDataBuilder toBuilder() =>
      GImpersonateDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GImpersonateData &&
        G__typename == other.G__typename &&
        impersonate == other.impersonate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, impersonate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GImpersonateData')
          ..add('G__typename', G__typename)
          ..add('impersonate', impersonate))
        .toString();
  }
}

class GImpersonateDataBuilder
    implements Builder<GImpersonateData, GImpersonateDataBuilder> {
  _$GImpersonateData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GImpersonateData_impersonateBuilder? _impersonate;
  GImpersonateData_impersonateBuilder get impersonate =>
      _$this._impersonate ??= GImpersonateData_impersonateBuilder();
  set impersonate(GImpersonateData_impersonateBuilder? impersonate) =>
      _$this._impersonate = impersonate;

  GImpersonateDataBuilder() {
    GImpersonateData._initializeBuilder(this);
  }

  GImpersonateDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _impersonate = $v.impersonate.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GImpersonateData other) {
    _$v = other as _$GImpersonateData;
  }

  @override
  void update(void Function(GImpersonateDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GImpersonateData build() => _build();

  _$GImpersonateData _build() {
    _$GImpersonateData _$result;
    try {
      _$result = _$v ??
          _$GImpersonateData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GImpersonateData', 'G__typename'),
            impersonate: impersonate.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'impersonate';
        impersonate.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GImpersonateData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GImpersonateData_impersonate extends GImpersonateData_impersonate {
  @override
  final String G__typename;
  @override
  final bool isImpersonating;
  @override
  final GImpersonateData_impersonate_acting? acting;
  @override
  final GImpersonateData_impersonate_effective? effective;

  factory _$GImpersonateData_impersonate(
          [void Function(GImpersonateData_impersonateBuilder)? updates]) =>
      (GImpersonateData_impersonateBuilder()..update(updates))._build();

  _$GImpersonateData_impersonate._(
      {required this.G__typename,
      required this.isImpersonating,
      this.acting,
      this.effective})
      : super._();
  @override
  GImpersonateData_impersonate rebuild(
          void Function(GImpersonateData_impersonateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GImpersonateData_impersonateBuilder toBuilder() =>
      GImpersonateData_impersonateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GImpersonateData_impersonate &&
        G__typename == other.G__typename &&
        isImpersonating == other.isImpersonating &&
        acting == other.acting &&
        effective == other.effective;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, isImpersonating.hashCode);
    _$hash = $jc(_$hash, acting.hashCode);
    _$hash = $jc(_$hash, effective.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GImpersonateData_impersonate')
          ..add('G__typename', G__typename)
          ..add('isImpersonating', isImpersonating)
          ..add('acting', acting)
          ..add('effective', effective))
        .toString();
  }
}

class GImpersonateData_impersonateBuilder
    implements
        Builder<GImpersonateData_impersonate,
            GImpersonateData_impersonateBuilder> {
  _$GImpersonateData_impersonate? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _isImpersonating;
  bool? get isImpersonating => _$this._isImpersonating;
  set isImpersonating(bool? isImpersonating) =>
      _$this._isImpersonating = isImpersonating;

  GImpersonateData_impersonate_actingBuilder? _acting;
  GImpersonateData_impersonate_actingBuilder get acting =>
      _$this._acting ??= GImpersonateData_impersonate_actingBuilder();
  set acting(GImpersonateData_impersonate_actingBuilder? acting) =>
      _$this._acting = acting;

  GImpersonateData_impersonate_effectiveBuilder? _effective;
  GImpersonateData_impersonate_effectiveBuilder get effective =>
      _$this._effective ??= GImpersonateData_impersonate_effectiveBuilder();
  set effective(GImpersonateData_impersonate_effectiveBuilder? effective) =>
      _$this._effective = effective;

  GImpersonateData_impersonateBuilder() {
    GImpersonateData_impersonate._initializeBuilder(this);
  }

  GImpersonateData_impersonateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _isImpersonating = $v.isImpersonating;
      _acting = $v.acting?.toBuilder();
      _effective = $v.effective?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GImpersonateData_impersonate other) {
    _$v = other as _$GImpersonateData_impersonate;
  }

  @override
  void update(void Function(GImpersonateData_impersonateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GImpersonateData_impersonate build() => _build();

  _$GImpersonateData_impersonate _build() {
    _$GImpersonateData_impersonate _$result;
    try {
      _$result = _$v ??
          _$GImpersonateData_impersonate._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GImpersonateData_impersonate', 'G__typename'),
            isImpersonating: BuiltValueNullFieldError.checkNotNull(
                isImpersonating,
                r'GImpersonateData_impersonate',
                'isImpersonating'),
            acting: _acting?.build(),
            effective: _effective?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'acting';
        _acting?.build();
        _$failedField = 'effective';
        _effective?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GImpersonateData_impersonate', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GImpersonateData_impersonate_acting
    extends GImpersonateData_impersonate_acting {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GImpersonateData_impersonate_acting(
          [void Function(GImpersonateData_impersonate_actingBuilder)?
              updates]) =>
      (GImpersonateData_impersonate_actingBuilder()..update(updates))._build();

  _$GImpersonateData_impersonate_acting._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GImpersonateData_impersonate_acting rebuild(
          void Function(GImpersonateData_impersonate_actingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GImpersonateData_impersonate_actingBuilder toBuilder() =>
      GImpersonateData_impersonate_actingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GImpersonateData_impersonate_acting &&
        G__typename == other.G__typename &&
        id == other.id &&
        displayName == other.displayName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GImpersonateData_impersonate_acting')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GImpersonateData_impersonate_actingBuilder
    implements
        Builder<GImpersonateData_impersonate_acting,
            GImpersonateData_impersonate_actingBuilder> {
  _$GImpersonateData_impersonate_acting? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GImpersonateData_impersonate_actingBuilder() {
    GImpersonateData_impersonate_acting._initializeBuilder(this);
  }

  GImpersonateData_impersonate_actingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _displayName = $v.displayName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GImpersonateData_impersonate_acting other) {
    _$v = other as _$GImpersonateData_impersonate_acting;
  }

  @override
  void update(
      void Function(GImpersonateData_impersonate_actingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GImpersonateData_impersonate_acting build() => _build();

  _$GImpersonateData_impersonate_acting _build() {
    final _$result = _$v ??
        _$GImpersonateData_impersonate_acting._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GImpersonateData_impersonate_acting', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GImpersonateData_impersonate_acting', 'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(displayName,
              r'GImpersonateData_impersonate_acting', 'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GImpersonateData_impersonate_effective
    extends GImpersonateData_impersonate_effective {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GImpersonateData_impersonate_effective(
          [void Function(GImpersonateData_impersonate_effectiveBuilder)?
              updates]) =>
      (GImpersonateData_impersonate_effectiveBuilder()..update(updates))
          ._build();

  _$GImpersonateData_impersonate_effective._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GImpersonateData_impersonate_effective rebuild(
          void Function(GImpersonateData_impersonate_effectiveBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GImpersonateData_impersonate_effectiveBuilder toBuilder() =>
      GImpersonateData_impersonate_effectiveBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GImpersonateData_impersonate_effective &&
        G__typename == other.G__typename &&
        id == other.id &&
        displayName == other.displayName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GImpersonateData_impersonate_effective')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GImpersonateData_impersonate_effectiveBuilder
    implements
        Builder<GImpersonateData_impersonate_effective,
            GImpersonateData_impersonate_effectiveBuilder> {
  _$GImpersonateData_impersonate_effective? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GImpersonateData_impersonate_effectiveBuilder() {
    GImpersonateData_impersonate_effective._initializeBuilder(this);
  }

  GImpersonateData_impersonate_effectiveBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _displayName = $v.displayName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GImpersonateData_impersonate_effective other) {
    _$v = other as _$GImpersonateData_impersonate_effective;
  }

  @override
  void update(
      void Function(GImpersonateData_impersonate_effectiveBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GImpersonateData_impersonate_effective build() => _build();

  _$GImpersonateData_impersonate_effective _build() {
    final _$result = _$v ??
        _$GImpersonateData_impersonate_effective._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GImpersonateData_impersonate_effective', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GImpersonateData_impersonate_effective', 'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(displayName,
              r'GImpersonateData_impersonate_effective', 'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GEndImpersonationData extends GEndImpersonationData {
  @override
  final String G__typename;
  @override
  final GEndImpersonationData_endImpersonation endImpersonation;

  factory _$GEndImpersonationData(
          [void Function(GEndImpersonationDataBuilder)? updates]) =>
      (GEndImpersonationDataBuilder()..update(updates))._build();

  _$GEndImpersonationData._(
      {required this.G__typename, required this.endImpersonation})
      : super._();
  @override
  GEndImpersonationData rebuild(
          void Function(GEndImpersonationDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GEndImpersonationDataBuilder toBuilder() =>
      GEndImpersonationDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GEndImpersonationData &&
        G__typename == other.G__typename &&
        endImpersonation == other.endImpersonation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, endImpersonation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GEndImpersonationData')
          ..add('G__typename', G__typename)
          ..add('endImpersonation', endImpersonation))
        .toString();
  }
}

class GEndImpersonationDataBuilder
    implements Builder<GEndImpersonationData, GEndImpersonationDataBuilder> {
  _$GEndImpersonationData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GEndImpersonationData_endImpersonationBuilder? _endImpersonation;
  GEndImpersonationData_endImpersonationBuilder get endImpersonation =>
      _$this._endImpersonation ??=
          GEndImpersonationData_endImpersonationBuilder();
  set endImpersonation(
          GEndImpersonationData_endImpersonationBuilder? endImpersonation) =>
      _$this._endImpersonation = endImpersonation;

  GEndImpersonationDataBuilder() {
    GEndImpersonationData._initializeBuilder(this);
  }

  GEndImpersonationDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _endImpersonation = $v.endImpersonation.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GEndImpersonationData other) {
    _$v = other as _$GEndImpersonationData;
  }

  @override
  void update(void Function(GEndImpersonationDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GEndImpersonationData build() => _build();

  _$GEndImpersonationData _build() {
    _$GEndImpersonationData _$result;
    try {
      _$result = _$v ??
          _$GEndImpersonationData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GEndImpersonationData', 'G__typename'),
            endImpersonation: endImpersonation.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'endImpersonation';
        endImpersonation.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GEndImpersonationData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GEndImpersonationData_endImpersonation
    extends GEndImpersonationData_endImpersonation {
  @override
  final String G__typename;
  @override
  final bool isImpersonating;
  @override
  final GEndImpersonationData_endImpersonation_acting? acting;
  @override
  final GEndImpersonationData_endImpersonation_effective? effective;

  factory _$GEndImpersonationData_endImpersonation(
          [void Function(GEndImpersonationData_endImpersonationBuilder)?
              updates]) =>
      (GEndImpersonationData_endImpersonationBuilder()..update(updates))
          ._build();

  _$GEndImpersonationData_endImpersonation._(
      {required this.G__typename,
      required this.isImpersonating,
      this.acting,
      this.effective})
      : super._();
  @override
  GEndImpersonationData_endImpersonation rebuild(
          void Function(GEndImpersonationData_endImpersonationBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GEndImpersonationData_endImpersonationBuilder toBuilder() =>
      GEndImpersonationData_endImpersonationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GEndImpersonationData_endImpersonation &&
        G__typename == other.G__typename &&
        isImpersonating == other.isImpersonating &&
        acting == other.acting &&
        effective == other.effective;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, isImpersonating.hashCode);
    _$hash = $jc(_$hash, acting.hashCode);
    _$hash = $jc(_$hash, effective.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GEndImpersonationData_endImpersonation')
          ..add('G__typename', G__typename)
          ..add('isImpersonating', isImpersonating)
          ..add('acting', acting)
          ..add('effective', effective))
        .toString();
  }
}

class GEndImpersonationData_endImpersonationBuilder
    implements
        Builder<GEndImpersonationData_endImpersonation,
            GEndImpersonationData_endImpersonationBuilder> {
  _$GEndImpersonationData_endImpersonation? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _isImpersonating;
  bool? get isImpersonating => _$this._isImpersonating;
  set isImpersonating(bool? isImpersonating) =>
      _$this._isImpersonating = isImpersonating;

  GEndImpersonationData_endImpersonation_actingBuilder? _acting;
  GEndImpersonationData_endImpersonation_actingBuilder get acting =>
      _$this._acting ??= GEndImpersonationData_endImpersonation_actingBuilder();
  set acting(GEndImpersonationData_endImpersonation_actingBuilder? acting) =>
      _$this._acting = acting;

  GEndImpersonationData_endImpersonation_effectiveBuilder? _effective;
  GEndImpersonationData_endImpersonation_effectiveBuilder get effective =>
      _$this._effective ??=
          GEndImpersonationData_endImpersonation_effectiveBuilder();
  set effective(
          GEndImpersonationData_endImpersonation_effectiveBuilder? effective) =>
      _$this._effective = effective;

  GEndImpersonationData_endImpersonationBuilder() {
    GEndImpersonationData_endImpersonation._initializeBuilder(this);
  }

  GEndImpersonationData_endImpersonationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _isImpersonating = $v.isImpersonating;
      _acting = $v.acting?.toBuilder();
      _effective = $v.effective?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GEndImpersonationData_endImpersonation other) {
    _$v = other as _$GEndImpersonationData_endImpersonation;
  }

  @override
  void update(
      void Function(GEndImpersonationData_endImpersonationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GEndImpersonationData_endImpersonation build() => _build();

  _$GEndImpersonationData_endImpersonation _build() {
    _$GEndImpersonationData_endImpersonation _$result;
    try {
      _$result = _$v ??
          _$GEndImpersonationData_endImpersonation._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GEndImpersonationData_endImpersonation', 'G__typename'),
            isImpersonating: BuiltValueNullFieldError.checkNotNull(
                isImpersonating,
                r'GEndImpersonationData_endImpersonation',
                'isImpersonating'),
            acting: _acting?.build(),
            effective: _effective?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'acting';
        _acting?.build();
        _$failedField = 'effective';
        _effective?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GEndImpersonationData_endImpersonation',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GEndImpersonationData_endImpersonation_acting
    extends GEndImpersonationData_endImpersonation_acting {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GEndImpersonationData_endImpersonation_acting(
          [void Function(GEndImpersonationData_endImpersonation_actingBuilder)?
              updates]) =>
      (GEndImpersonationData_endImpersonation_actingBuilder()..update(updates))
          ._build();

  _$GEndImpersonationData_endImpersonation_acting._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GEndImpersonationData_endImpersonation_acting rebuild(
          void Function(GEndImpersonationData_endImpersonation_actingBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GEndImpersonationData_endImpersonation_actingBuilder toBuilder() =>
      GEndImpersonationData_endImpersonation_actingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GEndImpersonationData_endImpersonation_acting &&
        G__typename == other.G__typename &&
        id == other.id &&
        displayName == other.displayName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GEndImpersonationData_endImpersonation_acting')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GEndImpersonationData_endImpersonation_actingBuilder
    implements
        Builder<GEndImpersonationData_endImpersonation_acting,
            GEndImpersonationData_endImpersonation_actingBuilder> {
  _$GEndImpersonationData_endImpersonation_acting? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GEndImpersonationData_endImpersonation_actingBuilder() {
    GEndImpersonationData_endImpersonation_acting._initializeBuilder(this);
  }

  GEndImpersonationData_endImpersonation_actingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _displayName = $v.displayName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GEndImpersonationData_endImpersonation_acting other) {
    _$v = other as _$GEndImpersonationData_endImpersonation_acting;
  }

  @override
  void update(
      void Function(GEndImpersonationData_endImpersonation_actingBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GEndImpersonationData_endImpersonation_acting build() => _build();

  _$GEndImpersonationData_endImpersonation_acting _build() {
    final _$result = _$v ??
        _$GEndImpersonationData_endImpersonation_acting._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GEndImpersonationData_endImpersonation_acting', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GEndImpersonationData_endImpersonation_acting', 'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(displayName,
              r'GEndImpersonationData_endImpersonation_acting', 'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GEndImpersonationData_endImpersonation_effective
    extends GEndImpersonationData_endImpersonation_effective {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String displayName;

  factory _$GEndImpersonationData_endImpersonation_effective(
          [void Function(
                  GEndImpersonationData_endImpersonation_effectiveBuilder)?
              updates]) =>
      (GEndImpersonationData_endImpersonation_effectiveBuilder()
            ..update(updates))
          ._build();

  _$GEndImpersonationData_endImpersonation_effective._(
      {required this.G__typename, required this.id, required this.displayName})
      : super._();
  @override
  GEndImpersonationData_endImpersonation_effective rebuild(
          void Function(GEndImpersonationData_endImpersonation_effectiveBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GEndImpersonationData_endImpersonation_effectiveBuilder toBuilder() =>
      GEndImpersonationData_endImpersonation_effectiveBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GEndImpersonationData_endImpersonation_effective &&
        G__typename == other.G__typename &&
        id == other.id &&
        displayName == other.displayName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GEndImpersonationData_endImpersonation_effective')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('displayName', displayName))
        .toString();
  }
}

class GEndImpersonationData_endImpersonation_effectiveBuilder
    implements
        Builder<GEndImpersonationData_endImpersonation_effective,
            GEndImpersonationData_endImpersonation_effectiveBuilder> {
  _$GEndImpersonationData_endImpersonation_effective? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  GEndImpersonationData_endImpersonation_effectiveBuilder() {
    GEndImpersonationData_endImpersonation_effective._initializeBuilder(this);
  }

  GEndImpersonationData_endImpersonation_effectiveBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _displayName = $v.displayName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GEndImpersonationData_endImpersonation_effective other) {
    _$v = other as _$GEndImpersonationData_endImpersonation_effective;
  }

  @override
  void update(
      void Function(GEndImpersonationData_endImpersonation_effectiveBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GEndImpersonationData_endImpersonation_effective build() => _build();

  _$GEndImpersonationData_endImpersonation_effective _build() {
    final _$result = _$v ??
        _$GEndImpersonationData_endImpersonation_effective._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GEndImpersonationData_endImpersonation_effective',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GEndImpersonationData_endImpersonation_effective', 'id'),
          displayName: BuiltValueNullFieldError.checkNotNull(
              displayName,
              r'GEndImpersonationData_endImpersonation_effective',
              'displayName'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GRegisterDeviceTokenData extends GRegisterDeviceTokenData {
  @override
  final String G__typename;
  @override
  final bool registerDeviceToken;

  factory _$GRegisterDeviceTokenData(
          [void Function(GRegisterDeviceTokenDataBuilder)? updates]) =>
      (GRegisterDeviceTokenDataBuilder()..update(updates))._build();

  _$GRegisterDeviceTokenData._(
      {required this.G__typename, required this.registerDeviceToken})
      : super._();
  @override
  GRegisterDeviceTokenData rebuild(
          void Function(GRegisterDeviceTokenDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRegisterDeviceTokenDataBuilder toBuilder() =>
      GRegisterDeviceTokenDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterDeviceTokenData &&
        G__typename == other.G__typename &&
        registerDeviceToken == other.registerDeviceToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, registerDeviceToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRegisterDeviceTokenData')
          ..add('G__typename', G__typename)
          ..add('registerDeviceToken', registerDeviceToken))
        .toString();
  }
}

class GRegisterDeviceTokenDataBuilder
    implements
        Builder<GRegisterDeviceTokenData, GRegisterDeviceTokenDataBuilder> {
  _$GRegisterDeviceTokenData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _registerDeviceToken;
  bool? get registerDeviceToken => _$this._registerDeviceToken;
  set registerDeviceToken(bool? registerDeviceToken) =>
      _$this._registerDeviceToken = registerDeviceToken;

  GRegisterDeviceTokenDataBuilder() {
    GRegisterDeviceTokenData._initializeBuilder(this);
  }

  GRegisterDeviceTokenDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _registerDeviceToken = $v.registerDeviceToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRegisterDeviceTokenData other) {
    _$v = other as _$GRegisterDeviceTokenData;
  }

  @override
  void update(void Function(GRegisterDeviceTokenDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterDeviceTokenData build() => _build();

  _$GRegisterDeviceTokenData _build() {
    final _$result = _$v ??
        _$GRegisterDeviceTokenData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GRegisterDeviceTokenData', 'G__typename'),
          registerDeviceToken: BuiltValueNullFieldError.checkNotNull(
              registerDeviceToken,
              r'GRegisterDeviceTokenData',
              'registerDeviceToken'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GUnregisterDeviceTokenData extends GUnregisterDeviceTokenData {
  @override
  final String G__typename;
  @override
  final bool unregisterDeviceToken;

  factory _$GUnregisterDeviceTokenData(
          [void Function(GUnregisterDeviceTokenDataBuilder)? updates]) =>
      (GUnregisterDeviceTokenDataBuilder()..update(updates))._build();

  _$GUnregisterDeviceTokenData._(
      {required this.G__typename, required this.unregisterDeviceToken})
      : super._();
  @override
  GUnregisterDeviceTokenData rebuild(
          void Function(GUnregisterDeviceTokenDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUnregisterDeviceTokenDataBuilder toBuilder() =>
      GUnregisterDeviceTokenDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUnregisterDeviceTokenData &&
        G__typename == other.G__typename &&
        unregisterDeviceToken == other.unregisterDeviceToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, unregisterDeviceToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUnregisterDeviceTokenData')
          ..add('G__typename', G__typename)
          ..add('unregisterDeviceToken', unregisterDeviceToken))
        .toString();
  }
}

class GUnregisterDeviceTokenDataBuilder
    implements
        Builder<GUnregisterDeviceTokenData, GUnregisterDeviceTokenDataBuilder> {
  _$GUnregisterDeviceTokenData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _unregisterDeviceToken;
  bool? get unregisterDeviceToken => _$this._unregisterDeviceToken;
  set unregisterDeviceToken(bool? unregisterDeviceToken) =>
      _$this._unregisterDeviceToken = unregisterDeviceToken;

  GUnregisterDeviceTokenDataBuilder() {
    GUnregisterDeviceTokenData._initializeBuilder(this);
  }

  GUnregisterDeviceTokenDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _unregisterDeviceToken = $v.unregisterDeviceToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUnregisterDeviceTokenData other) {
    _$v = other as _$GUnregisterDeviceTokenData;
  }

  @override
  void update(void Function(GUnregisterDeviceTokenDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUnregisterDeviceTokenData build() => _build();

  _$GUnregisterDeviceTokenData _build() {
    final _$result = _$v ??
        _$GUnregisterDeviceTokenData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GUnregisterDeviceTokenData', 'G__typename'),
          unregisterDeviceToken: BuiltValueNullFieldError.checkNotNull(
              unregisterDeviceToken,
              r'GUnregisterDeviceTokenData',
              'unregisterDeviceToken'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
