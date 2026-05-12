// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistent_cache.dart';

// ignore_for_file: type=lint
class $CachedTagsTable extends CachedTags
    with TableInfo<$CachedTagsTable, CachedTagRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastRefreshedAtMsMeta =
      const VerificationMeta('lastRefreshedAtMs');
  @override
  late final GeneratedColumn<int> lastRefreshedAtMs = GeneratedColumn<int>(
      'last_refreshed_at_ms', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, slug, displayName, path, lastRefreshedAtMs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_tags';
  @override
  VerificationContext validateIntegrity(Insertable<CachedTagRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('last_refreshed_at_ms')) {
      context.handle(
          _lastRefreshedAtMsMeta,
          lastRefreshedAtMs.isAcceptableOrUnknown(
              data['last_refreshed_at_ms']!, _lastRefreshedAtMsMeta));
    } else if (isInserting) {
      context.missing(_lastRefreshedAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedTagRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedTagRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      lastRefreshedAtMs: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}last_refreshed_at_ms'])!,
    );
  }

  @override
  $CachedTagsTable createAlias(String alias) {
    return $CachedTagsTable(attachedDatabase, alias);
  }
}

class CachedTagRow extends DataClass implements Insertable<CachedTagRow> {
  final String id;
  final String slug;
  final String displayName;
  final String path;
  final int lastRefreshedAtMs;
  const CachedTagRow(
      {required this.id,
      required this.slug,
      required this.displayName,
      required this.path,
      required this.lastRefreshedAtMs});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['slug'] = Variable<String>(slug);
    map['display_name'] = Variable<String>(displayName);
    map['path'] = Variable<String>(path);
    map['last_refreshed_at_ms'] = Variable<int>(lastRefreshedAtMs);
    return map;
  }

  CachedTagsCompanion toCompanion(bool nullToAbsent) {
    return CachedTagsCompanion(
      id: Value(id),
      slug: Value(slug),
      displayName: Value(displayName),
      path: Value(path),
      lastRefreshedAtMs: Value(lastRefreshedAtMs),
    );
  }

  factory CachedTagRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedTagRow(
      id: serializer.fromJson<String>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      displayName: serializer.fromJson<String>(json['displayName']),
      path: serializer.fromJson<String>(json['path']),
      lastRefreshedAtMs: serializer.fromJson<int>(json['lastRefreshedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'slug': serializer.toJson<String>(slug),
      'displayName': serializer.toJson<String>(displayName),
      'path': serializer.toJson<String>(path),
      'lastRefreshedAtMs': serializer.toJson<int>(lastRefreshedAtMs),
    };
  }

  CachedTagRow copyWith(
          {String? id,
          String? slug,
          String? displayName,
          String? path,
          int? lastRefreshedAtMs}) =>
      CachedTagRow(
        id: id ?? this.id,
        slug: slug ?? this.slug,
        displayName: displayName ?? this.displayName,
        path: path ?? this.path,
        lastRefreshedAtMs: lastRefreshedAtMs ?? this.lastRefreshedAtMs,
      );
  CachedTagRow copyWithCompanion(CachedTagsCompanion data) {
    return CachedTagRow(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      path: data.path.present ? data.path.value : this.path,
      lastRefreshedAtMs: data.lastRefreshedAtMs.present
          ? data.lastRefreshedAtMs.value
          : this.lastRefreshedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedTagRow(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('displayName: $displayName, ')
          ..write('path: $path, ')
          ..write('lastRefreshedAtMs: $lastRefreshedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, slug, displayName, path, lastRefreshedAtMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedTagRow &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.displayName == this.displayName &&
          other.path == this.path &&
          other.lastRefreshedAtMs == this.lastRefreshedAtMs);
}

class CachedTagsCompanion extends UpdateCompanion<CachedTagRow> {
  final Value<String> id;
  final Value<String> slug;
  final Value<String> displayName;
  final Value<String> path;
  final Value<int> lastRefreshedAtMs;
  final Value<int> rowid;
  const CachedTagsCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.displayName = const Value.absent(),
    this.path = const Value.absent(),
    this.lastRefreshedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedTagsCompanion.insert({
    required String id,
    required String slug,
    required String displayName,
    required String path,
    required int lastRefreshedAtMs,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        slug = Value(slug),
        displayName = Value(displayName),
        path = Value(path),
        lastRefreshedAtMs = Value(lastRefreshedAtMs);
  static Insertable<CachedTagRow> custom({
    Expression<String>? id,
    Expression<String>? slug,
    Expression<String>? displayName,
    Expression<String>? path,
    Expression<int>? lastRefreshedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (displayName != null) 'display_name': displayName,
      if (path != null) 'path': path,
      if (lastRefreshedAtMs != null) 'last_refreshed_at_ms': lastRefreshedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedTagsCompanion copyWith(
      {Value<String>? id,
      Value<String>? slug,
      Value<String>? displayName,
      Value<String>? path,
      Value<int>? lastRefreshedAtMs,
      Value<int>? rowid}) {
    return CachedTagsCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      displayName: displayName ?? this.displayName,
      path: path ?? this.path,
      lastRefreshedAtMs: lastRefreshedAtMs ?? this.lastRefreshedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (lastRefreshedAtMs.present) {
      map['last_refreshed_at_ms'] = Variable<int>(lastRefreshedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedTagsCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('displayName: $displayName, ')
          ..write('path: $path, ')
          ..write('lastRefreshedAtMs: $lastRefreshedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedTagFeedTable extends CachedTagFeed
    with TableInfo<$CachedTagFeedTable, CachedTagFeedRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedTagFeedTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _postIdMeta = const VerificationMeta('postId');
  @override
  late final GeneratedColumn<String> postId = GeneratedColumn<String>(
      'post_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cursorMeta = const VerificationMeta('cursor');
  @override
  late final GeneratedColumn<String> cursor = GeneratedColumn<String>(
      'cursor', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [tagId, postId, position, cursor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_tag_feed';
  @override
  VerificationContext validateIntegrity(Insertable<CachedTagFeedRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (data.containsKey('post_id')) {
      context.handle(_postIdMeta,
          postId.isAcceptableOrUnknown(data['post_id']!, _postIdMeta));
    } else if (isInserting) {
      context.missing(_postIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('cursor')) {
      context.handle(_cursorMeta,
          cursor.isAcceptableOrUnknown(data['cursor']!, _cursorMeta));
    } else if (isInserting) {
      context.missing(_cursorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tagId, postId};
  @override
  CachedTagFeedRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedTagFeedRow(
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag_id'])!,
      postId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}post_id'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      cursor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cursor'])!,
    );
  }

  @override
  $CachedTagFeedTable createAlias(String alias) {
    return $CachedTagFeedTable(attachedDatabase, alias);
  }
}

class CachedTagFeedRow extends DataClass
    implements Insertable<CachedTagFeedRow> {
  final String tagId;
  final String postId;
  final int position;
  final String cursor;
  const CachedTagFeedRow(
      {required this.tagId,
      required this.postId,
      required this.position,
      required this.cursor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tag_id'] = Variable<String>(tagId);
    map['post_id'] = Variable<String>(postId);
    map['position'] = Variable<int>(position);
    map['cursor'] = Variable<String>(cursor);
    return map;
  }

  CachedTagFeedCompanion toCompanion(bool nullToAbsent) {
    return CachedTagFeedCompanion(
      tagId: Value(tagId),
      postId: Value(postId),
      position: Value(position),
      cursor: Value(cursor),
    );
  }

  factory CachedTagFeedRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedTagFeedRow(
      tagId: serializer.fromJson<String>(json['tagId']),
      postId: serializer.fromJson<String>(json['postId']),
      position: serializer.fromJson<int>(json['position']),
      cursor: serializer.fromJson<String>(json['cursor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tagId': serializer.toJson<String>(tagId),
      'postId': serializer.toJson<String>(postId),
      'position': serializer.toJson<int>(position),
      'cursor': serializer.toJson<String>(cursor),
    };
  }

  CachedTagFeedRow copyWith(
          {String? tagId, String? postId, int? position, String? cursor}) =>
      CachedTagFeedRow(
        tagId: tagId ?? this.tagId,
        postId: postId ?? this.postId,
        position: position ?? this.position,
        cursor: cursor ?? this.cursor,
      );
  CachedTagFeedRow copyWithCompanion(CachedTagFeedCompanion data) {
    return CachedTagFeedRow(
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
      postId: data.postId.present ? data.postId.value : this.postId,
      position: data.position.present ? data.position.value : this.position,
      cursor: data.cursor.present ? data.cursor.value : this.cursor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedTagFeedRow(')
          ..write('tagId: $tagId, ')
          ..write('postId: $postId, ')
          ..write('position: $position, ')
          ..write('cursor: $cursor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(tagId, postId, position, cursor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedTagFeedRow &&
          other.tagId == this.tagId &&
          other.postId == this.postId &&
          other.position == this.position &&
          other.cursor == this.cursor);
}

class CachedTagFeedCompanion extends UpdateCompanion<CachedTagFeedRow> {
  final Value<String> tagId;
  final Value<String> postId;
  final Value<int> position;
  final Value<String> cursor;
  final Value<int> rowid;
  const CachedTagFeedCompanion({
    this.tagId = const Value.absent(),
    this.postId = const Value.absent(),
    this.position = const Value.absent(),
    this.cursor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedTagFeedCompanion.insert({
    required String tagId,
    required String postId,
    required int position,
    required String cursor,
    this.rowid = const Value.absent(),
  })  : tagId = Value(tagId),
        postId = Value(postId),
        position = Value(position),
        cursor = Value(cursor);
  static Insertable<CachedTagFeedRow> custom({
    Expression<String>? tagId,
    Expression<String>? postId,
    Expression<int>? position,
    Expression<String>? cursor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (tagId != null) 'tag_id': tagId,
      if (postId != null) 'post_id': postId,
      if (position != null) 'position': position,
      if (cursor != null) 'cursor': cursor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedTagFeedCompanion copyWith(
      {Value<String>? tagId,
      Value<String>? postId,
      Value<int>? position,
      Value<String>? cursor,
      Value<int>? rowid}) {
    return CachedTagFeedCompanion(
      tagId: tagId ?? this.tagId,
      postId: postId ?? this.postId,
      position: position ?? this.position,
      cursor: cursor ?? this.cursor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (postId.present) {
      map['post_id'] = Variable<String>(postId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (cursor.present) {
      map['cursor'] = Variable<String>(cursor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedTagFeedCompanion(')
          ..write('tagId: $tagId, ')
          ..write('postId: $postId, ')
          ..write('position: $position, ')
          ..write('cursor: $cursor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedPostsTable extends CachedPosts
    with TableInfo<$CachedPostsTable, CachedPostRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedPostsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _summaryJsonMeta =
      const VerificationMeta('summaryJson');
  @override
  late final GeneratedColumn<String> summaryJson = GeneratedColumn<String>(
      'summary_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _detailJsonMeta =
      const VerificationMeta('detailJson');
  @override
  late final GeneratedColumn<String> detailJson = GeneratedColumn<String>(
      'detail_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _byteSizeMeta =
      const VerificationMeta('byteSize');
  @override
  late final GeneratedColumn<int> byteSize = GeneratedColumn<int>(
      'byte_size', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastViewedAtMsMeta =
      const VerificationMeta('lastViewedAtMs');
  @override
  late final GeneratedColumn<int> lastViewedAtMs = GeneratedColumn<int>(
      'last_viewed_at_ms', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMsMeta =
      const VerificationMeta('updatedAtMs');
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
      'updated_at_ms', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, summaryJson, detailJson, byteSize, lastViewedAtMs, updatedAtMs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_posts';
  @override
  VerificationContext validateIntegrity(Insertable<CachedPostRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('summary_json')) {
      context.handle(
          _summaryJsonMeta,
          summaryJson.isAcceptableOrUnknown(
              data['summary_json']!, _summaryJsonMeta));
    } else if (isInserting) {
      context.missing(_summaryJsonMeta);
    }
    if (data.containsKey('detail_json')) {
      context.handle(
          _detailJsonMeta,
          detailJson.isAcceptableOrUnknown(
              data['detail_json']!, _detailJsonMeta));
    }
    if (data.containsKey('byte_size')) {
      context.handle(_byteSizeMeta,
          byteSize.isAcceptableOrUnknown(data['byte_size']!, _byteSizeMeta));
    } else if (isInserting) {
      context.missing(_byteSizeMeta);
    }
    if (data.containsKey('last_viewed_at_ms')) {
      context.handle(
          _lastViewedAtMsMeta,
          lastViewedAtMs.isAcceptableOrUnknown(
              data['last_viewed_at_ms']!, _lastViewedAtMsMeta));
    } else if (isInserting) {
      context.missing(_lastViewedAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
          _updatedAtMsMeta,
          updatedAtMs.isAcceptableOrUnknown(
              data['updated_at_ms']!, _updatedAtMsMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedPostRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedPostRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      summaryJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}summary_json'])!,
      detailJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}detail_json']),
      byteSize: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}byte_size'])!,
      lastViewedAtMs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_viewed_at_ms'])!,
      updatedAtMs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at_ms'])!,
    );
  }

  @override
  $CachedPostsTable createAlias(String alias) {
    return $CachedPostsTable(attachedDatabase, alias);
  }
}

class CachedPostRow extends DataClass implements Insertable<CachedPostRow> {
  final String id;
  final String summaryJson;
  final String? detailJson;
  final int byteSize;
  final int lastViewedAtMs;
  final int updatedAtMs;
  const CachedPostRow(
      {required this.id,
      required this.summaryJson,
      this.detailJson,
      required this.byteSize,
      required this.lastViewedAtMs,
      required this.updatedAtMs});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['summary_json'] = Variable<String>(summaryJson);
    if (!nullToAbsent || detailJson != null) {
      map['detail_json'] = Variable<String>(detailJson);
    }
    map['byte_size'] = Variable<int>(byteSize);
    map['last_viewed_at_ms'] = Variable<int>(lastViewedAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  CachedPostsCompanion toCompanion(bool nullToAbsent) {
    return CachedPostsCompanion(
      id: Value(id),
      summaryJson: Value(summaryJson),
      detailJson: detailJson == null && nullToAbsent
          ? const Value.absent()
          : Value(detailJson),
      byteSize: Value(byteSize),
      lastViewedAtMs: Value(lastViewedAtMs),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory CachedPostRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedPostRow(
      id: serializer.fromJson<String>(json['id']),
      summaryJson: serializer.fromJson<String>(json['summaryJson']),
      detailJson: serializer.fromJson<String?>(json['detailJson']),
      byteSize: serializer.fromJson<int>(json['byteSize']),
      lastViewedAtMs: serializer.fromJson<int>(json['lastViewedAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'summaryJson': serializer.toJson<String>(summaryJson),
      'detailJson': serializer.toJson<String?>(detailJson),
      'byteSize': serializer.toJson<int>(byteSize),
      'lastViewedAtMs': serializer.toJson<int>(lastViewedAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  CachedPostRow copyWith(
          {String? id,
          String? summaryJson,
          Value<String?> detailJson = const Value.absent(),
          int? byteSize,
          int? lastViewedAtMs,
          int? updatedAtMs}) =>
      CachedPostRow(
        id: id ?? this.id,
        summaryJson: summaryJson ?? this.summaryJson,
        detailJson: detailJson.present ? detailJson.value : this.detailJson,
        byteSize: byteSize ?? this.byteSize,
        lastViewedAtMs: lastViewedAtMs ?? this.lastViewedAtMs,
        updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      );
  CachedPostRow copyWithCompanion(CachedPostsCompanion data) {
    return CachedPostRow(
      id: data.id.present ? data.id.value : this.id,
      summaryJson:
          data.summaryJson.present ? data.summaryJson.value : this.summaryJson,
      detailJson:
          data.detailJson.present ? data.detailJson.value : this.detailJson,
      byteSize: data.byteSize.present ? data.byteSize.value : this.byteSize,
      lastViewedAtMs: data.lastViewedAtMs.present
          ? data.lastViewedAtMs.value
          : this.lastViewedAtMs,
      updatedAtMs:
          data.updatedAtMs.present ? data.updatedAtMs.value : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedPostRow(')
          ..write('id: $id, ')
          ..write('summaryJson: $summaryJson, ')
          ..write('detailJson: $detailJson, ')
          ..write('byteSize: $byteSize, ')
          ..write('lastViewedAtMs: $lastViewedAtMs, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, summaryJson, detailJson, byteSize, lastViewedAtMs, updatedAtMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedPostRow &&
          other.id == this.id &&
          other.summaryJson == this.summaryJson &&
          other.detailJson == this.detailJson &&
          other.byteSize == this.byteSize &&
          other.lastViewedAtMs == this.lastViewedAtMs &&
          other.updatedAtMs == this.updatedAtMs);
}

class CachedPostsCompanion extends UpdateCompanion<CachedPostRow> {
  final Value<String> id;
  final Value<String> summaryJson;
  final Value<String?> detailJson;
  final Value<int> byteSize;
  final Value<int> lastViewedAtMs;
  final Value<int> updatedAtMs;
  final Value<int> rowid;
  const CachedPostsCompanion({
    this.id = const Value.absent(),
    this.summaryJson = const Value.absent(),
    this.detailJson = const Value.absent(),
    this.byteSize = const Value.absent(),
    this.lastViewedAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedPostsCompanion.insert({
    required String id,
    required String summaryJson,
    this.detailJson = const Value.absent(),
    required int byteSize,
    required int lastViewedAtMs,
    required int updatedAtMs,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        summaryJson = Value(summaryJson),
        byteSize = Value(byteSize),
        lastViewedAtMs = Value(lastViewedAtMs),
        updatedAtMs = Value(updatedAtMs);
  static Insertable<CachedPostRow> custom({
    Expression<String>? id,
    Expression<String>? summaryJson,
    Expression<String>? detailJson,
    Expression<int>? byteSize,
    Expression<int>? lastViewedAtMs,
    Expression<int>? updatedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (summaryJson != null) 'summary_json': summaryJson,
      if (detailJson != null) 'detail_json': detailJson,
      if (byteSize != null) 'byte_size': byteSize,
      if (lastViewedAtMs != null) 'last_viewed_at_ms': lastViewedAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedPostsCompanion copyWith(
      {Value<String>? id,
      Value<String>? summaryJson,
      Value<String?>? detailJson,
      Value<int>? byteSize,
      Value<int>? lastViewedAtMs,
      Value<int>? updatedAtMs,
      Value<int>? rowid}) {
    return CachedPostsCompanion(
      id: id ?? this.id,
      summaryJson: summaryJson ?? this.summaryJson,
      detailJson: detailJson ?? this.detailJson,
      byteSize: byteSize ?? this.byteSize,
      lastViewedAtMs: lastViewedAtMs ?? this.lastViewedAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (summaryJson.present) {
      map['summary_json'] = Variable<String>(summaryJson.value);
    }
    if (detailJson.present) {
      map['detail_json'] = Variable<String>(detailJson.value);
    }
    if (byteSize.present) {
      map['byte_size'] = Variable<int>(byteSize.value);
    }
    if (lastViewedAtMs.present) {
      map['last_viewed_at_ms'] = Variable<int>(lastViewedAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedPostsCompanion(')
          ..write('id: $id, ')
          ..write('summaryJson: $summaryJson, ')
          ..write('detailJson: $detailJson, ')
          ..write('byteSize: $byteSize, ')
          ..write('lastViewedAtMs: $lastViewedAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedRoomsTable extends CachedRooms
    with TableInfo<$CachedRoomsTable, CachedRoomRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedRoomsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _summaryJsonMeta =
      const VerificationMeta('summaryJson');
  @override
  late final GeneratedColumn<String> summaryJson = GeneratedColumn<String>(
      'summary_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _byteSizeMeta =
      const VerificationMeta('byteSize');
  @override
  late final GeneratedColumn<int> byteSize = GeneratedColumn<int>(
      'byte_size', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastViewedAtMsMeta =
      const VerificationMeta('lastViewedAtMs');
  @override
  late final GeneratedColumn<int> lastViewedAtMs = GeneratedColumn<int>(
      'last_viewed_at_ms', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMsMeta =
      const VerificationMeta('updatedAtMs');
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
      'updated_at_ms', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, summaryJson, byteSize, lastViewedAtMs, updatedAtMs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_rooms';
  @override
  VerificationContext validateIntegrity(Insertable<CachedRoomRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('summary_json')) {
      context.handle(
          _summaryJsonMeta,
          summaryJson.isAcceptableOrUnknown(
              data['summary_json']!, _summaryJsonMeta));
    } else if (isInserting) {
      context.missing(_summaryJsonMeta);
    }
    if (data.containsKey('byte_size')) {
      context.handle(_byteSizeMeta,
          byteSize.isAcceptableOrUnknown(data['byte_size']!, _byteSizeMeta));
    } else if (isInserting) {
      context.missing(_byteSizeMeta);
    }
    if (data.containsKey('last_viewed_at_ms')) {
      context.handle(
          _lastViewedAtMsMeta,
          lastViewedAtMs.isAcceptableOrUnknown(
              data['last_viewed_at_ms']!, _lastViewedAtMsMeta));
    } else if (isInserting) {
      context.missing(_lastViewedAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
          _updatedAtMsMeta,
          updatedAtMs.isAcceptableOrUnknown(
              data['updated_at_ms']!, _updatedAtMsMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedRoomRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedRoomRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      summaryJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}summary_json'])!,
      byteSize: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}byte_size'])!,
      lastViewedAtMs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_viewed_at_ms'])!,
      updatedAtMs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at_ms'])!,
    );
  }

  @override
  $CachedRoomsTable createAlias(String alias) {
    return $CachedRoomsTable(attachedDatabase, alias);
  }
}

class CachedRoomRow extends DataClass implements Insertable<CachedRoomRow> {
  final String id;
  final String summaryJson;
  final int byteSize;
  final int lastViewedAtMs;
  final int updatedAtMs;
  const CachedRoomRow(
      {required this.id,
      required this.summaryJson,
      required this.byteSize,
      required this.lastViewedAtMs,
      required this.updatedAtMs});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['summary_json'] = Variable<String>(summaryJson);
    map['byte_size'] = Variable<int>(byteSize);
    map['last_viewed_at_ms'] = Variable<int>(lastViewedAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  CachedRoomsCompanion toCompanion(bool nullToAbsent) {
    return CachedRoomsCompanion(
      id: Value(id),
      summaryJson: Value(summaryJson),
      byteSize: Value(byteSize),
      lastViewedAtMs: Value(lastViewedAtMs),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory CachedRoomRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedRoomRow(
      id: serializer.fromJson<String>(json['id']),
      summaryJson: serializer.fromJson<String>(json['summaryJson']),
      byteSize: serializer.fromJson<int>(json['byteSize']),
      lastViewedAtMs: serializer.fromJson<int>(json['lastViewedAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'summaryJson': serializer.toJson<String>(summaryJson),
      'byteSize': serializer.toJson<int>(byteSize),
      'lastViewedAtMs': serializer.toJson<int>(lastViewedAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  CachedRoomRow copyWith(
          {String? id,
          String? summaryJson,
          int? byteSize,
          int? lastViewedAtMs,
          int? updatedAtMs}) =>
      CachedRoomRow(
        id: id ?? this.id,
        summaryJson: summaryJson ?? this.summaryJson,
        byteSize: byteSize ?? this.byteSize,
        lastViewedAtMs: lastViewedAtMs ?? this.lastViewedAtMs,
        updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      );
  CachedRoomRow copyWithCompanion(CachedRoomsCompanion data) {
    return CachedRoomRow(
      id: data.id.present ? data.id.value : this.id,
      summaryJson:
          data.summaryJson.present ? data.summaryJson.value : this.summaryJson,
      byteSize: data.byteSize.present ? data.byteSize.value : this.byteSize,
      lastViewedAtMs: data.lastViewedAtMs.present
          ? data.lastViewedAtMs.value
          : this.lastViewedAtMs,
      updatedAtMs:
          data.updatedAtMs.present ? data.updatedAtMs.value : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedRoomRow(')
          ..write('id: $id, ')
          ..write('summaryJson: $summaryJson, ')
          ..write('byteSize: $byteSize, ')
          ..write('lastViewedAtMs: $lastViewedAtMs, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, summaryJson, byteSize, lastViewedAtMs, updatedAtMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedRoomRow &&
          other.id == this.id &&
          other.summaryJson == this.summaryJson &&
          other.byteSize == this.byteSize &&
          other.lastViewedAtMs == this.lastViewedAtMs &&
          other.updatedAtMs == this.updatedAtMs);
}

class CachedRoomsCompanion extends UpdateCompanion<CachedRoomRow> {
  final Value<String> id;
  final Value<String> summaryJson;
  final Value<int> byteSize;
  final Value<int> lastViewedAtMs;
  final Value<int> updatedAtMs;
  final Value<int> rowid;
  const CachedRoomsCompanion({
    this.id = const Value.absent(),
    this.summaryJson = const Value.absent(),
    this.byteSize = const Value.absent(),
    this.lastViewedAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedRoomsCompanion.insert({
    required String id,
    required String summaryJson,
    required int byteSize,
    required int lastViewedAtMs,
    required int updatedAtMs,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        summaryJson = Value(summaryJson),
        byteSize = Value(byteSize),
        lastViewedAtMs = Value(lastViewedAtMs),
        updatedAtMs = Value(updatedAtMs);
  static Insertable<CachedRoomRow> custom({
    Expression<String>? id,
    Expression<String>? summaryJson,
    Expression<int>? byteSize,
    Expression<int>? lastViewedAtMs,
    Expression<int>? updatedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (summaryJson != null) 'summary_json': summaryJson,
      if (byteSize != null) 'byte_size': byteSize,
      if (lastViewedAtMs != null) 'last_viewed_at_ms': lastViewedAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedRoomsCompanion copyWith(
      {Value<String>? id,
      Value<String>? summaryJson,
      Value<int>? byteSize,
      Value<int>? lastViewedAtMs,
      Value<int>? updatedAtMs,
      Value<int>? rowid}) {
    return CachedRoomsCompanion(
      id: id ?? this.id,
      summaryJson: summaryJson ?? this.summaryJson,
      byteSize: byteSize ?? this.byteSize,
      lastViewedAtMs: lastViewedAtMs ?? this.lastViewedAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (summaryJson.present) {
      map['summary_json'] = Variable<String>(summaryJson.value);
    }
    if (byteSize.present) {
      map['byte_size'] = Variable<int>(byteSize.value);
    }
    if (lastViewedAtMs.present) {
      map['last_viewed_at_ms'] = Variable<int>(lastViewedAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedRoomsCompanion(')
          ..write('id: $id, ')
          ..write('summaryJson: $summaryJson, ')
          ..write('byteSize: $byteSize, ')
          ..write('lastViewedAtMs: $lastViewedAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedMessagesTable extends CachedMessages
    with TableInfo<$CachedMessagesTable, CachedMessageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _roomIdMeta = const VerificationMeta('roomId');
  @override
  late final GeneratedColumn<String> roomId = GeneratedColumn<String>(
      'room_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadJsonMeta =
      const VerificationMeta('payloadJson');
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
      'payload_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _byteSizeMeta =
      const VerificationMeta('byteSize');
  @override
  late final GeneratedColumn<int> byteSize = GeneratedColumn<int>(
      'byte_size', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMsMeta =
      const VerificationMeta('createdAtMs');
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
      'created_at_ms', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cursorMeta = const VerificationMeta('cursor');
  @override
  late final GeneratedColumn<String> cursor = GeneratedColumn<String>(
      'cursor', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [roomId, id, payloadJson, byteSize, createdAtMs, cursor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_messages';
  @override
  VerificationContext validateIntegrity(Insertable<CachedMessageRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('room_id')) {
      context.handle(_roomIdMeta,
          roomId.isAcceptableOrUnknown(data['room_id']!, _roomIdMeta));
    } else if (isInserting) {
      context.missing(_roomIdMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
          _payloadJsonMeta,
          payloadJson.isAcceptableOrUnknown(
              data['payload_json']!, _payloadJsonMeta));
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('byte_size')) {
      context.handle(_byteSizeMeta,
          byteSize.isAcceptableOrUnknown(data['byte_size']!, _byteSizeMeta));
    } else if (isInserting) {
      context.missing(_byteSizeMeta);
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
          _createdAtMsMeta,
          createdAtMs.isAcceptableOrUnknown(
              data['created_at_ms']!, _createdAtMsMeta));
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('cursor')) {
      context.handle(_cursorMeta,
          cursor.isAcceptableOrUnknown(data['cursor']!, _cursorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {roomId, id};
  @override
  CachedMessageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedMessageRow(
      roomId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}room_id'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      payloadJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload_json'])!,
      byteSize: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}byte_size'])!,
      createdAtMs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at_ms'])!,
      cursor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cursor']),
    );
  }

  @override
  $CachedMessagesTable createAlias(String alias) {
    return $CachedMessagesTable(attachedDatabase, alias);
  }
}

class CachedMessageRow extends DataClass
    implements Insertable<CachedMessageRow> {
  final String roomId;
  final String id;
  final String payloadJson;
  final int byteSize;
  final int createdAtMs;
  final String? cursor;
  const CachedMessageRow(
      {required this.roomId,
      required this.id,
      required this.payloadJson,
      required this.byteSize,
      required this.createdAtMs,
      this.cursor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['room_id'] = Variable<String>(roomId);
    map['id'] = Variable<String>(id);
    map['payload_json'] = Variable<String>(payloadJson);
    map['byte_size'] = Variable<int>(byteSize);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    if (!nullToAbsent || cursor != null) {
      map['cursor'] = Variable<String>(cursor);
    }
    return map;
  }

  CachedMessagesCompanion toCompanion(bool nullToAbsent) {
    return CachedMessagesCompanion(
      roomId: Value(roomId),
      id: Value(id),
      payloadJson: Value(payloadJson),
      byteSize: Value(byteSize),
      createdAtMs: Value(createdAtMs),
      cursor:
          cursor == null && nullToAbsent ? const Value.absent() : Value(cursor),
    );
  }

  factory CachedMessageRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedMessageRow(
      roomId: serializer.fromJson<String>(json['roomId']),
      id: serializer.fromJson<String>(json['id']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      byteSize: serializer.fromJson<int>(json['byteSize']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      cursor: serializer.fromJson<String?>(json['cursor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'roomId': serializer.toJson<String>(roomId),
      'id': serializer.toJson<String>(id),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'byteSize': serializer.toJson<int>(byteSize),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'cursor': serializer.toJson<String?>(cursor),
    };
  }

  CachedMessageRow copyWith(
          {String? roomId,
          String? id,
          String? payloadJson,
          int? byteSize,
          int? createdAtMs,
          Value<String?> cursor = const Value.absent()}) =>
      CachedMessageRow(
        roomId: roomId ?? this.roomId,
        id: id ?? this.id,
        payloadJson: payloadJson ?? this.payloadJson,
        byteSize: byteSize ?? this.byteSize,
        createdAtMs: createdAtMs ?? this.createdAtMs,
        cursor: cursor.present ? cursor.value : this.cursor,
      );
  CachedMessageRow copyWithCompanion(CachedMessagesCompanion data) {
    return CachedMessageRow(
      roomId: data.roomId.present ? data.roomId.value : this.roomId,
      id: data.id.present ? data.id.value : this.id,
      payloadJson:
          data.payloadJson.present ? data.payloadJson.value : this.payloadJson,
      byteSize: data.byteSize.present ? data.byteSize.value : this.byteSize,
      createdAtMs:
          data.createdAtMs.present ? data.createdAtMs.value : this.createdAtMs,
      cursor: data.cursor.present ? data.cursor.value : this.cursor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedMessageRow(')
          ..write('roomId: $roomId, ')
          ..write('id: $id, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('byteSize: $byteSize, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('cursor: $cursor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(roomId, id, payloadJson, byteSize, createdAtMs, cursor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedMessageRow &&
          other.roomId == this.roomId &&
          other.id == this.id &&
          other.payloadJson == this.payloadJson &&
          other.byteSize == this.byteSize &&
          other.createdAtMs == this.createdAtMs &&
          other.cursor == this.cursor);
}

class CachedMessagesCompanion extends UpdateCompanion<CachedMessageRow> {
  final Value<String> roomId;
  final Value<String> id;
  final Value<String> payloadJson;
  final Value<int> byteSize;
  final Value<int> createdAtMs;
  final Value<String?> cursor;
  final Value<int> rowid;
  const CachedMessagesCompanion({
    this.roomId = const Value.absent(),
    this.id = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.byteSize = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.cursor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedMessagesCompanion.insert({
    required String roomId,
    required String id,
    required String payloadJson,
    required int byteSize,
    required int createdAtMs,
    this.cursor = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : roomId = Value(roomId),
        id = Value(id),
        payloadJson = Value(payloadJson),
        byteSize = Value(byteSize),
        createdAtMs = Value(createdAtMs);
  static Insertable<CachedMessageRow> custom({
    Expression<String>? roomId,
    Expression<String>? id,
    Expression<String>? payloadJson,
    Expression<int>? byteSize,
    Expression<int>? createdAtMs,
    Expression<String>? cursor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (roomId != null) 'room_id': roomId,
      if (id != null) 'id': id,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (byteSize != null) 'byte_size': byteSize,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (cursor != null) 'cursor': cursor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedMessagesCompanion copyWith(
      {Value<String>? roomId,
      Value<String>? id,
      Value<String>? payloadJson,
      Value<int>? byteSize,
      Value<int>? createdAtMs,
      Value<String?>? cursor,
      Value<int>? rowid}) {
    return CachedMessagesCompanion(
      roomId: roomId ?? this.roomId,
      id: id ?? this.id,
      payloadJson: payloadJson ?? this.payloadJson,
      byteSize: byteSize ?? this.byteSize,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      cursor: cursor ?? this.cursor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (roomId.present) {
      map['room_id'] = Variable<String>(roomId.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (byteSize.present) {
      map['byte_size'] = Variable<int>(byteSize.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (cursor.present) {
      map['cursor'] = Variable<String>(cursor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedMessagesCompanion(')
          ..write('roomId: $roomId, ')
          ..write('id: $id, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('byteSize: $byteSize, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('cursor: $cursor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$CacheDatabase extends GeneratedDatabase {
  _$CacheDatabase(QueryExecutor e) : super(e);
  $CacheDatabaseManager get managers => $CacheDatabaseManager(this);
  late final $CachedTagsTable cachedTags = $CachedTagsTable(this);
  late final $CachedTagFeedTable cachedTagFeed = $CachedTagFeedTable(this);
  late final $CachedPostsTable cachedPosts = $CachedPostsTable(this);
  late final $CachedRoomsTable cachedRooms = $CachedRoomsTable(this);
  late final $CachedMessagesTable cachedMessages = $CachedMessagesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [cachedTags, cachedTagFeed, cachedPosts, cachedRooms, cachedMessages];
}

typedef $$CachedTagsTableCreateCompanionBuilder = CachedTagsCompanion Function({
  required String id,
  required String slug,
  required String displayName,
  required String path,
  required int lastRefreshedAtMs,
  Value<int> rowid,
});
typedef $$CachedTagsTableUpdateCompanionBuilder = CachedTagsCompanion Function({
  Value<String> id,
  Value<String> slug,
  Value<String> displayName,
  Value<String> path,
  Value<int> lastRefreshedAtMs,
  Value<int> rowid,
});

class $$CachedTagsTableFilterComposer
    extends Composer<_$CacheDatabase, $CachedTagsTable> {
  $$CachedTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastRefreshedAtMs => $composableBuilder(
      column: $table.lastRefreshedAtMs,
      builder: (column) => ColumnFilters(column));
}

class $$CachedTagsTableOrderingComposer
    extends Composer<_$CacheDatabase, $CachedTagsTable> {
  $$CachedTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastRefreshedAtMs => $composableBuilder(
      column: $table.lastRefreshedAtMs,
      builder: (column) => ColumnOrderings(column));
}

class $$CachedTagsTableAnnotationComposer
    extends Composer<_$CacheDatabase, $CachedTagsTable> {
  $$CachedTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<int> get lastRefreshedAtMs => $composableBuilder(
      column: $table.lastRefreshedAtMs, builder: (column) => column);
}

class $$CachedTagsTableTableManager extends RootTableManager<
    _$CacheDatabase,
    $CachedTagsTable,
    CachedTagRow,
    $$CachedTagsTableFilterComposer,
    $$CachedTagsTableOrderingComposer,
    $$CachedTagsTableAnnotationComposer,
    $$CachedTagsTableCreateCompanionBuilder,
    $$CachedTagsTableUpdateCompanionBuilder,
    (
      CachedTagRow,
      BaseReferences<_$CacheDatabase, $CachedTagsTable, CachedTagRow>
    ),
    CachedTagRow,
    PrefetchHooks Function()> {
  $$CachedTagsTableTableManager(_$CacheDatabase db, $CachedTagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> slug = const Value.absent(),
            Value<String> displayName = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<int> lastRefreshedAtMs = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedTagsCompanion(
            id: id,
            slug: slug,
            displayName: displayName,
            path: path,
            lastRefreshedAtMs: lastRefreshedAtMs,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String slug,
            required String displayName,
            required String path,
            required int lastRefreshedAtMs,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedTagsCompanion.insert(
            id: id,
            slug: slug,
            displayName: displayName,
            path: path,
            lastRefreshedAtMs: lastRefreshedAtMs,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedTagsTableProcessedTableManager = ProcessedTableManager<
    _$CacheDatabase,
    $CachedTagsTable,
    CachedTagRow,
    $$CachedTagsTableFilterComposer,
    $$CachedTagsTableOrderingComposer,
    $$CachedTagsTableAnnotationComposer,
    $$CachedTagsTableCreateCompanionBuilder,
    $$CachedTagsTableUpdateCompanionBuilder,
    (
      CachedTagRow,
      BaseReferences<_$CacheDatabase, $CachedTagsTable, CachedTagRow>
    ),
    CachedTagRow,
    PrefetchHooks Function()>;
typedef $$CachedTagFeedTableCreateCompanionBuilder = CachedTagFeedCompanion
    Function({
  required String tagId,
  required String postId,
  required int position,
  required String cursor,
  Value<int> rowid,
});
typedef $$CachedTagFeedTableUpdateCompanionBuilder = CachedTagFeedCompanion
    Function({
  Value<String> tagId,
  Value<String> postId,
  Value<int> position,
  Value<String> cursor,
  Value<int> rowid,
});

class $$CachedTagFeedTableFilterComposer
    extends Composer<_$CacheDatabase, $CachedTagFeedTable> {
  $$CachedTagFeedTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get tagId => $composableBuilder(
      column: $table.tagId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get postId => $composableBuilder(
      column: $table.postId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cursor => $composableBuilder(
      column: $table.cursor, builder: (column) => ColumnFilters(column));
}

class $$CachedTagFeedTableOrderingComposer
    extends Composer<_$CacheDatabase, $CachedTagFeedTable> {
  $$CachedTagFeedTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get tagId => $composableBuilder(
      column: $table.tagId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get postId => $composableBuilder(
      column: $table.postId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cursor => $composableBuilder(
      column: $table.cursor, builder: (column) => ColumnOrderings(column));
}

class $$CachedTagFeedTableAnnotationComposer
    extends Composer<_$CacheDatabase, $CachedTagFeedTable> {
  $$CachedTagFeedTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get tagId =>
      $composableBuilder(column: $table.tagId, builder: (column) => column);

  GeneratedColumn<String> get postId =>
      $composableBuilder(column: $table.postId, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get cursor =>
      $composableBuilder(column: $table.cursor, builder: (column) => column);
}

class $$CachedTagFeedTableTableManager extends RootTableManager<
    _$CacheDatabase,
    $CachedTagFeedTable,
    CachedTagFeedRow,
    $$CachedTagFeedTableFilterComposer,
    $$CachedTagFeedTableOrderingComposer,
    $$CachedTagFeedTableAnnotationComposer,
    $$CachedTagFeedTableCreateCompanionBuilder,
    $$CachedTagFeedTableUpdateCompanionBuilder,
    (
      CachedTagFeedRow,
      BaseReferences<_$CacheDatabase, $CachedTagFeedTable, CachedTagFeedRow>
    ),
    CachedTagFeedRow,
    PrefetchHooks Function()> {
  $$CachedTagFeedTableTableManager(
      _$CacheDatabase db, $CachedTagFeedTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedTagFeedTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedTagFeedTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedTagFeedTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> tagId = const Value.absent(),
            Value<String> postId = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<String> cursor = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedTagFeedCompanion(
            tagId: tagId,
            postId: postId,
            position: position,
            cursor: cursor,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String tagId,
            required String postId,
            required int position,
            required String cursor,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedTagFeedCompanion.insert(
            tagId: tagId,
            postId: postId,
            position: position,
            cursor: cursor,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedTagFeedTableProcessedTableManager = ProcessedTableManager<
    _$CacheDatabase,
    $CachedTagFeedTable,
    CachedTagFeedRow,
    $$CachedTagFeedTableFilterComposer,
    $$CachedTagFeedTableOrderingComposer,
    $$CachedTagFeedTableAnnotationComposer,
    $$CachedTagFeedTableCreateCompanionBuilder,
    $$CachedTagFeedTableUpdateCompanionBuilder,
    (
      CachedTagFeedRow,
      BaseReferences<_$CacheDatabase, $CachedTagFeedTable, CachedTagFeedRow>
    ),
    CachedTagFeedRow,
    PrefetchHooks Function()>;
typedef $$CachedPostsTableCreateCompanionBuilder = CachedPostsCompanion
    Function({
  required String id,
  required String summaryJson,
  Value<String?> detailJson,
  required int byteSize,
  required int lastViewedAtMs,
  required int updatedAtMs,
  Value<int> rowid,
});
typedef $$CachedPostsTableUpdateCompanionBuilder = CachedPostsCompanion
    Function({
  Value<String> id,
  Value<String> summaryJson,
  Value<String?> detailJson,
  Value<int> byteSize,
  Value<int> lastViewedAtMs,
  Value<int> updatedAtMs,
  Value<int> rowid,
});

class $$CachedPostsTableFilterComposer
    extends Composer<_$CacheDatabase, $CachedPostsTable> {
  $$CachedPostsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get summaryJson => $composableBuilder(
      column: $table.summaryJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get detailJson => $composableBuilder(
      column: $table.detailJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get byteSize => $composableBuilder(
      column: $table.byteSize, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastViewedAtMs => $composableBuilder(
      column: $table.lastViewedAtMs,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
      column: $table.updatedAtMs, builder: (column) => ColumnFilters(column));
}

class $$CachedPostsTableOrderingComposer
    extends Composer<_$CacheDatabase, $CachedPostsTable> {
  $$CachedPostsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get summaryJson => $composableBuilder(
      column: $table.summaryJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get detailJson => $composableBuilder(
      column: $table.detailJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get byteSize => $composableBuilder(
      column: $table.byteSize, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastViewedAtMs => $composableBuilder(
      column: $table.lastViewedAtMs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
      column: $table.updatedAtMs, builder: (column) => ColumnOrderings(column));
}

class $$CachedPostsTableAnnotationComposer
    extends Composer<_$CacheDatabase, $CachedPostsTable> {
  $$CachedPostsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get summaryJson => $composableBuilder(
      column: $table.summaryJson, builder: (column) => column);

  GeneratedColumn<String> get detailJson => $composableBuilder(
      column: $table.detailJson, builder: (column) => column);

  GeneratedColumn<int> get byteSize =>
      $composableBuilder(column: $table.byteSize, builder: (column) => column);

  GeneratedColumn<int> get lastViewedAtMs => $composableBuilder(
      column: $table.lastViewedAtMs, builder: (column) => column);

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
      column: $table.updatedAtMs, builder: (column) => column);
}

class $$CachedPostsTableTableManager extends RootTableManager<
    _$CacheDatabase,
    $CachedPostsTable,
    CachedPostRow,
    $$CachedPostsTableFilterComposer,
    $$CachedPostsTableOrderingComposer,
    $$CachedPostsTableAnnotationComposer,
    $$CachedPostsTableCreateCompanionBuilder,
    $$CachedPostsTableUpdateCompanionBuilder,
    (
      CachedPostRow,
      BaseReferences<_$CacheDatabase, $CachedPostsTable, CachedPostRow>
    ),
    CachedPostRow,
    PrefetchHooks Function()> {
  $$CachedPostsTableTableManager(_$CacheDatabase db, $CachedPostsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedPostsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedPostsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedPostsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> summaryJson = const Value.absent(),
            Value<String?> detailJson = const Value.absent(),
            Value<int> byteSize = const Value.absent(),
            Value<int> lastViewedAtMs = const Value.absent(),
            Value<int> updatedAtMs = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedPostsCompanion(
            id: id,
            summaryJson: summaryJson,
            detailJson: detailJson,
            byteSize: byteSize,
            lastViewedAtMs: lastViewedAtMs,
            updatedAtMs: updatedAtMs,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String summaryJson,
            Value<String?> detailJson = const Value.absent(),
            required int byteSize,
            required int lastViewedAtMs,
            required int updatedAtMs,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedPostsCompanion.insert(
            id: id,
            summaryJson: summaryJson,
            detailJson: detailJson,
            byteSize: byteSize,
            lastViewedAtMs: lastViewedAtMs,
            updatedAtMs: updatedAtMs,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedPostsTableProcessedTableManager = ProcessedTableManager<
    _$CacheDatabase,
    $CachedPostsTable,
    CachedPostRow,
    $$CachedPostsTableFilterComposer,
    $$CachedPostsTableOrderingComposer,
    $$CachedPostsTableAnnotationComposer,
    $$CachedPostsTableCreateCompanionBuilder,
    $$CachedPostsTableUpdateCompanionBuilder,
    (
      CachedPostRow,
      BaseReferences<_$CacheDatabase, $CachedPostsTable, CachedPostRow>
    ),
    CachedPostRow,
    PrefetchHooks Function()>;
typedef $$CachedRoomsTableCreateCompanionBuilder = CachedRoomsCompanion
    Function({
  required String id,
  required String summaryJson,
  required int byteSize,
  required int lastViewedAtMs,
  required int updatedAtMs,
  Value<int> rowid,
});
typedef $$CachedRoomsTableUpdateCompanionBuilder = CachedRoomsCompanion
    Function({
  Value<String> id,
  Value<String> summaryJson,
  Value<int> byteSize,
  Value<int> lastViewedAtMs,
  Value<int> updatedAtMs,
  Value<int> rowid,
});

class $$CachedRoomsTableFilterComposer
    extends Composer<_$CacheDatabase, $CachedRoomsTable> {
  $$CachedRoomsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get summaryJson => $composableBuilder(
      column: $table.summaryJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get byteSize => $composableBuilder(
      column: $table.byteSize, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastViewedAtMs => $composableBuilder(
      column: $table.lastViewedAtMs,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
      column: $table.updatedAtMs, builder: (column) => ColumnFilters(column));
}

class $$CachedRoomsTableOrderingComposer
    extends Composer<_$CacheDatabase, $CachedRoomsTable> {
  $$CachedRoomsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get summaryJson => $composableBuilder(
      column: $table.summaryJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get byteSize => $composableBuilder(
      column: $table.byteSize, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastViewedAtMs => $composableBuilder(
      column: $table.lastViewedAtMs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
      column: $table.updatedAtMs, builder: (column) => ColumnOrderings(column));
}

class $$CachedRoomsTableAnnotationComposer
    extends Composer<_$CacheDatabase, $CachedRoomsTable> {
  $$CachedRoomsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get summaryJson => $composableBuilder(
      column: $table.summaryJson, builder: (column) => column);

  GeneratedColumn<int> get byteSize =>
      $composableBuilder(column: $table.byteSize, builder: (column) => column);

  GeneratedColumn<int> get lastViewedAtMs => $composableBuilder(
      column: $table.lastViewedAtMs, builder: (column) => column);

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
      column: $table.updatedAtMs, builder: (column) => column);
}

class $$CachedRoomsTableTableManager extends RootTableManager<
    _$CacheDatabase,
    $CachedRoomsTable,
    CachedRoomRow,
    $$CachedRoomsTableFilterComposer,
    $$CachedRoomsTableOrderingComposer,
    $$CachedRoomsTableAnnotationComposer,
    $$CachedRoomsTableCreateCompanionBuilder,
    $$CachedRoomsTableUpdateCompanionBuilder,
    (
      CachedRoomRow,
      BaseReferences<_$CacheDatabase, $CachedRoomsTable, CachedRoomRow>
    ),
    CachedRoomRow,
    PrefetchHooks Function()> {
  $$CachedRoomsTableTableManager(_$CacheDatabase db, $CachedRoomsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedRoomsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedRoomsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedRoomsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> summaryJson = const Value.absent(),
            Value<int> byteSize = const Value.absent(),
            Value<int> lastViewedAtMs = const Value.absent(),
            Value<int> updatedAtMs = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedRoomsCompanion(
            id: id,
            summaryJson: summaryJson,
            byteSize: byteSize,
            lastViewedAtMs: lastViewedAtMs,
            updatedAtMs: updatedAtMs,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String summaryJson,
            required int byteSize,
            required int lastViewedAtMs,
            required int updatedAtMs,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedRoomsCompanion.insert(
            id: id,
            summaryJson: summaryJson,
            byteSize: byteSize,
            lastViewedAtMs: lastViewedAtMs,
            updatedAtMs: updatedAtMs,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedRoomsTableProcessedTableManager = ProcessedTableManager<
    _$CacheDatabase,
    $CachedRoomsTable,
    CachedRoomRow,
    $$CachedRoomsTableFilterComposer,
    $$CachedRoomsTableOrderingComposer,
    $$CachedRoomsTableAnnotationComposer,
    $$CachedRoomsTableCreateCompanionBuilder,
    $$CachedRoomsTableUpdateCompanionBuilder,
    (
      CachedRoomRow,
      BaseReferences<_$CacheDatabase, $CachedRoomsTable, CachedRoomRow>
    ),
    CachedRoomRow,
    PrefetchHooks Function()>;
typedef $$CachedMessagesTableCreateCompanionBuilder = CachedMessagesCompanion
    Function({
  required String roomId,
  required String id,
  required String payloadJson,
  required int byteSize,
  required int createdAtMs,
  Value<String?> cursor,
  Value<int> rowid,
});
typedef $$CachedMessagesTableUpdateCompanionBuilder = CachedMessagesCompanion
    Function({
  Value<String> roomId,
  Value<String> id,
  Value<String> payloadJson,
  Value<int> byteSize,
  Value<int> createdAtMs,
  Value<String?> cursor,
  Value<int> rowid,
});

class $$CachedMessagesTableFilterComposer
    extends Composer<_$CacheDatabase, $CachedMessagesTable> {
  $$CachedMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get roomId => $composableBuilder(
      column: $table.roomId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get byteSize => $composableBuilder(
      column: $table.byteSize, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAtMs => $composableBuilder(
      column: $table.createdAtMs, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cursor => $composableBuilder(
      column: $table.cursor, builder: (column) => ColumnFilters(column));
}

class $$CachedMessagesTableOrderingComposer
    extends Composer<_$CacheDatabase, $CachedMessagesTable> {
  $$CachedMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get roomId => $composableBuilder(
      column: $table.roomId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get byteSize => $composableBuilder(
      column: $table.byteSize, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
      column: $table.createdAtMs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cursor => $composableBuilder(
      column: $table.cursor, builder: (column) => ColumnOrderings(column));
}

class $$CachedMessagesTableAnnotationComposer
    extends Composer<_$CacheDatabase, $CachedMessagesTable> {
  $$CachedMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get roomId =>
      $composableBuilder(column: $table.roomId, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => column);

  GeneratedColumn<int> get byteSize =>
      $composableBuilder(column: $table.byteSize, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
      column: $table.createdAtMs, builder: (column) => column);

  GeneratedColumn<String> get cursor =>
      $composableBuilder(column: $table.cursor, builder: (column) => column);
}

class $$CachedMessagesTableTableManager extends RootTableManager<
    _$CacheDatabase,
    $CachedMessagesTable,
    CachedMessageRow,
    $$CachedMessagesTableFilterComposer,
    $$CachedMessagesTableOrderingComposer,
    $$CachedMessagesTableAnnotationComposer,
    $$CachedMessagesTableCreateCompanionBuilder,
    $$CachedMessagesTableUpdateCompanionBuilder,
    (
      CachedMessageRow,
      BaseReferences<_$CacheDatabase, $CachedMessagesTable, CachedMessageRow>
    ),
    CachedMessageRow,
    PrefetchHooks Function()> {
  $$CachedMessagesTableTableManager(
      _$CacheDatabase db, $CachedMessagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> roomId = const Value.absent(),
            Value<String> id = const Value.absent(),
            Value<String> payloadJson = const Value.absent(),
            Value<int> byteSize = const Value.absent(),
            Value<int> createdAtMs = const Value.absent(),
            Value<String?> cursor = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedMessagesCompanion(
            roomId: roomId,
            id: id,
            payloadJson: payloadJson,
            byteSize: byteSize,
            createdAtMs: createdAtMs,
            cursor: cursor,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String roomId,
            required String id,
            required String payloadJson,
            required int byteSize,
            required int createdAtMs,
            Value<String?> cursor = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedMessagesCompanion.insert(
            roomId: roomId,
            id: id,
            payloadJson: payloadJson,
            byteSize: byteSize,
            createdAtMs: createdAtMs,
            cursor: cursor,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedMessagesTableProcessedTableManager = ProcessedTableManager<
    _$CacheDatabase,
    $CachedMessagesTable,
    CachedMessageRow,
    $$CachedMessagesTableFilterComposer,
    $$CachedMessagesTableOrderingComposer,
    $$CachedMessagesTableAnnotationComposer,
    $$CachedMessagesTableCreateCompanionBuilder,
    $$CachedMessagesTableUpdateCompanionBuilder,
    (
      CachedMessageRow,
      BaseReferences<_$CacheDatabase, $CachedMessagesTable, CachedMessageRow>
    ),
    CachedMessageRow,
    PrefetchHooks Function()>;

class $CacheDatabaseManager {
  final _$CacheDatabase _db;
  $CacheDatabaseManager(this._db);
  $$CachedTagsTableTableManager get cachedTags =>
      $$CachedTagsTableTableManager(_db, _db.cachedTags);
  $$CachedTagFeedTableTableManager get cachedTagFeed =>
      $$CachedTagFeedTableTableManager(_db, _db.cachedTagFeed);
  $$CachedPostsTableTableManager get cachedPosts =>
      $$CachedPostsTableTableManager(_db, _db.cachedPosts);
  $$CachedRoomsTableTableManager get cachedRooms =>
      $$CachedRoomsTableTableManager(_db, _db.cachedRooms);
  $$CachedMessagesTableTableManager get cachedMessages =>
      $$CachedMessagesTableTableManager(_db, _db.cachedMessages);
}
