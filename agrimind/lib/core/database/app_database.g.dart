// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalUsersTable extends LocalUsers
    with TableInfo<$LocalUsersTable, LocalUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _telefoneMeta =
      const VerificationMeta('telefone');
  @override
  late final GeneratedColumn<String> telefone = GeneratedColumn<String>(
      'telefone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _empresaMeta =
      const VerificationMeta('empresa');
  @override
  late final GeneratedColumn<String> empresa = GeneratedColumn<String>(
      'empresa', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _craRegistroMeta =
      const VerificationMeta('craRegistro');
  @override
  late final GeneratedColumn<String> craRegistro = GeneratedColumn<String>(
      'cra_registro', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _avatarUrlMeta =
      const VerificationMeta('avatarUrl');
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
      'avatar_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _darkModeMeta =
      const VerificationMeta('darkMode');
  @override
  late final GeneratedColumn<bool> darkMode = GeneratedColumn<bool>(
      'dark_mode', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("dark_mode" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _appIconKeyMeta =
      const VerificationMeta('appIconKey');
  @override
  late final GeneratedColumn<String> appIconKey = GeneratedColumn<String>(
      'app_icon_key', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('principal'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        nome,
        email,
        telefone,
        empresa,
        craRegistro,
        avatarUrl,
        darkMode,
        appIconKey,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_users';
  @override
  VerificationContext validateIntegrity(Insertable<LocalUser> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('telefone')) {
      context.handle(_telefoneMeta,
          telefone.isAcceptableOrUnknown(data['telefone']!, _telefoneMeta));
    }
    if (data.containsKey('empresa')) {
      context.handle(_empresaMeta,
          empresa.isAcceptableOrUnknown(data['empresa']!, _empresaMeta));
    }
    if (data.containsKey('cra_registro')) {
      context.handle(
          _craRegistroMeta,
          craRegistro.isAcceptableOrUnknown(
              data['cra_registro']!, _craRegistroMeta));
    }
    if (data.containsKey('avatar_url')) {
      context.handle(_avatarUrlMeta,
          avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta));
    }
    if (data.containsKey('dark_mode')) {
      context.handle(_darkModeMeta,
          darkMode.isAcceptableOrUnknown(data['dark_mode']!, _darkModeMeta));
    }
    if (data.containsKey('app_icon_key')) {
      context.handle(
          _appIconKeyMeta,
          appIconKey.isAcceptableOrUnknown(
              data['app_icon_key']!, _appIconKeyMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  LocalUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalUser(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      telefone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefone']),
      empresa: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}empresa']),
      craRegistro: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cra_registro']),
      avatarUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_url']),
      darkMode: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}dark_mode'])!,
      appIconKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}app_icon_key'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LocalUsersTable createAlias(String alias) {
    return $LocalUsersTable(attachedDatabase, alias);
  }
}

class LocalUser extends DataClass implements Insertable<LocalUser> {
  final String uid;
  final String nome;
  final String email;
  final String? telefone;
  final String? empresa;
  final String? craRegistro;
  final String? avatarUrl;
  final bool darkMode;
  final String appIconKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalUser(
      {required this.uid,
      required this.nome,
      required this.email,
      this.telefone,
      this.empresa,
      this.craRegistro,
      this.avatarUrl,
      required this.darkMode,
      required this.appIconKey,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['nome'] = Variable<String>(nome);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || telefone != null) {
      map['telefone'] = Variable<String>(telefone);
    }
    if (!nullToAbsent || empresa != null) {
      map['empresa'] = Variable<String>(empresa);
    }
    if (!nullToAbsent || craRegistro != null) {
      map['cra_registro'] = Variable<String>(craRegistro);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['dark_mode'] = Variable<bool>(darkMode);
    map['app_icon_key'] = Variable<String>(appIconKey);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalUsersCompanion toCompanion(bool nullToAbsent) {
    return LocalUsersCompanion(
      uid: Value(uid),
      nome: Value(nome),
      email: Value(email),
      telefone: telefone == null && nullToAbsent
          ? const Value.absent()
          : Value(telefone),
      empresa: empresa == null && nullToAbsent
          ? const Value.absent()
          : Value(empresa),
      craRegistro: craRegistro == null && nullToAbsent
          ? const Value.absent()
          : Value(craRegistro),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      darkMode: Value(darkMode),
      appIconKey: Value(appIconKey),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUser(
      uid: serializer.fromJson<String>(json['uid']),
      nome: serializer.fromJson<String>(json['nome']),
      email: serializer.fromJson<String>(json['email']),
      telefone: serializer.fromJson<String?>(json['telefone']),
      empresa: serializer.fromJson<String?>(json['empresa']),
      craRegistro: serializer.fromJson<String?>(json['craRegistro']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      darkMode: serializer.fromJson<bool>(json['darkMode']),
      appIconKey: serializer.fromJson<String>(json['appIconKey']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'nome': serializer.toJson<String>(nome),
      'email': serializer.toJson<String>(email),
      'telefone': serializer.toJson<String?>(telefone),
      'empresa': serializer.toJson<String?>(empresa),
      'craRegistro': serializer.toJson<String?>(craRegistro),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'darkMode': serializer.toJson<bool>(darkMode),
      'appIconKey': serializer.toJson<String>(appIconKey),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalUser copyWith(
          {String? uid,
          String? nome,
          String? email,
          Value<String?> telefone = const Value.absent(),
          Value<String?> empresa = const Value.absent(),
          Value<String?> craRegistro = const Value.absent(),
          Value<String?> avatarUrl = const Value.absent(),
          bool? darkMode,
          String? appIconKey,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LocalUser(
        uid: uid ?? this.uid,
        nome: nome ?? this.nome,
        email: email ?? this.email,
        telefone: telefone.present ? telefone.value : this.telefone,
        empresa: empresa.present ? empresa.value : this.empresa,
        craRegistro: craRegistro.present ? craRegistro.value : this.craRegistro,
        avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
        darkMode: darkMode ?? this.darkMode,
        appIconKey: appIconKey ?? this.appIconKey,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalUser copyWithCompanion(LocalUsersCompanion data) {
    return LocalUser(
      uid: data.uid.present ? data.uid.value : this.uid,
      nome: data.nome.present ? data.nome.value : this.nome,
      email: data.email.present ? data.email.value : this.email,
      telefone: data.telefone.present ? data.telefone.value : this.telefone,
      empresa: data.empresa.present ? data.empresa.value : this.empresa,
      craRegistro:
          data.craRegistro.present ? data.craRegistro.value : this.craRegistro,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      darkMode: data.darkMode.present ? data.darkMode.value : this.darkMode,
      appIconKey:
          data.appIconKey.present ? data.appIconKey.value : this.appIconKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalUser(')
          ..write('uid: $uid, ')
          ..write('nome: $nome, ')
          ..write('email: $email, ')
          ..write('telefone: $telefone, ')
          ..write('empresa: $empresa, ')
          ..write('craRegistro: $craRegistro, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('darkMode: $darkMode, ')
          ..write('appIconKey: $appIconKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uid, nome, email, telefone, empresa,
      craRegistro, avatarUrl, darkMode, appIconKey, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUser &&
          other.uid == this.uid &&
          other.nome == this.nome &&
          other.email == this.email &&
          other.telefone == this.telefone &&
          other.empresa == this.empresa &&
          other.craRegistro == this.craRegistro &&
          other.avatarUrl == this.avatarUrl &&
          other.darkMode == this.darkMode &&
          other.appIconKey == this.appIconKey &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalUsersCompanion extends UpdateCompanion<LocalUser> {
  final Value<String> uid;
  final Value<String> nome;
  final Value<String> email;
  final Value<String?> telefone;
  final Value<String?> empresa;
  final Value<String?> craRegistro;
  final Value<String?> avatarUrl;
  final Value<bool> darkMode;
  final Value<String> appIconKey;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalUsersCompanion({
    this.uid = const Value.absent(),
    this.nome = const Value.absent(),
    this.email = const Value.absent(),
    this.telefone = const Value.absent(),
    this.empresa = const Value.absent(),
    this.craRegistro = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.darkMode = const Value.absent(),
    this.appIconKey = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalUsersCompanion.insert({
    required String uid,
    required String nome,
    required String email,
    this.telefone = const Value.absent(),
    this.empresa = const Value.absent(),
    this.craRegistro = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.darkMode = const Value.absent(),
    this.appIconKey = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        nome = Value(nome),
        email = Value(email),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<LocalUser> custom({
    Expression<String>? uid,
    Expression<String>? nome,
    Expression<String>? email,
    Expression<String>? telefone,
    Expression<String>? empresa,
    Expression<String>? craRegistro,
    Expression<String>? avatarUrl,
    Expression<bool>? darkMode,
    Expression<String>? appIconKey,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (nome != null) 'nome': nome,
      if (email != null) 'email': email,
      if (telefone != null) 'telefone': telefone,
      if (empresa != null) 'empresa': empresa,
      if (craRegistro != null) 'cra_registro': craRegistro,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (darkMode != null) 'dark_mode': darkMode,
      if (appIconKey != null) 'app_icon_key': appIconKey,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalUsersCompanion copyWith(
      {Value<String>? uid,
      Value<String>? nome,
      Value<String>? email,
      Value<String?>? telefone,
      Value<String?>? empresa,
      Value<String?>? craRegistro,
      Value<String?>? avatarUrl,
      Value<bool>? darkMode,
      Value<String>? appIconKey,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return LocalUsersCompanion(
      uid: uid ?? this.uid,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      empresa: empresa ?? this.empresa,
      craRegistro: craRegistro ?? this.craRegistro,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      darkMode: darkMode ?? this.darkMode,
      appIconKey: appIconKey ?? this.appIconKey,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (telefone.present) {
      map['telefone'] = Variable<String>(telefone.value);
    }
    if (empresa.present) {
      map['empresa'] = Variable<String>(empresa.value);
    }
    if (craRegistro.present) {
      map['cra_registro'] = Variable<String>(craRegistro.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (darkMode.present) {
      map['dark_mode'] = Variable<bool>(darkMode.value);
    }
    if (appIconKey.present) {
      map['app_icon_key'] = Variable<String>(appIconKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalUsersCompanion(')
          ..write('uid: $uid, ')
          ..write('nome: $nome, ')
          ..write('email: $email, ')
          ..write('telefone: $telefone, ')
          ..write('empresa: $empresa, ')
          ..write('craRegistro: $craRegistro, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('darkMode: $darkMode, ')
          ..write('appIconKey: $appIconKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClientesTable extends Clientes with TableInfo<$ClientesTable, Cliente> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cpfCnpjMeta =
      const VerificationMeta('cpfCnpj');
  @override
  late final GeneratedColumn<String> cpfCnpj = GeneratedColumn<String>(
      'cpf_cnpj', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _telefoneMeta =
      const VerificationMeta('telefone');
  @override
  late final GeneratedColumn<String> telefone = GeneratedColumn<String>(
      'telefone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cidadeMeta = const VerificationMeta('cidade');
  @override
  late final GeneratedColumn<String> cidade = GeneratedColumn<String>(
      'cidade', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ufMeta = const VerificationMeta('uf');
  @override
  late final GeneratedColumn<String> uf = GeneratedColumn<String>(
      'uf', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
      'ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ativo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        userId,
        nome,
        cpfCnpj,
        telefone,
        email,
        cidade,
        uf,
        ativo,
        createdAt,
        updatedAt,
        syncState,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clientes';
  @override
  VerificationContext validateIntegrity(Insertable<Cliente> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('cpf_cnpj')) {
      context.handle(_cpfCnpjMeta,
          cpfCnpj.isAcceptableOrUnknown(data['cpf_cnpj']!, _cpfCnpjMeta));
    }
    if (data.containsKey('telefone')) {
      context.handle(_telefoneMeta,
          telefone.isAcceptableOrUnknown(data['telefone']!, _telefoneMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('cidade')) {
      context.handle(_cidadeMeta,
          cidade.isAcceptableOrUnknown(data['cidade']!, _cidadeMeta));
    }
    if (data.containsKey('uf')) {
      context.handle(_ufMeta, uf.isAcceptableOrUnknown(data['uf']!, _ufMeta));
    }
    if (data.containsKey('ativo')) {
      context.handle(
          _ativoMeta, ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  Cliente map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cliente(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      cpfCnpj: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cpf_cnpj']),
      telefone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefone']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      cidade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cidade']),
      uf: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uf']),
      ativo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ativo'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $ClientesTable createAlias(String alias) {
    return $ClientesTable(attachedDatabase, alias);
  }
}

class Cliente extends DataClass implements Insertable<Cliente> {
  final String uid;
  final String? userId;
  final String nome;
  final String? cpfCnpj;
  final String? telefone;
  final String? email;
  final String? cidade;
  final String? uf;
  final bool ativo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncState;
  final DateTime? deletedAt;
  const Cliente(
      {required this.uid,
      this.userId,
      required this.nome,
      this.cpfCnpj,
      this.telefone,
      this.email,
      this.cidade,
      this.uf,
      required this.ativo,
      required this.createdAt,
      required this.updatedAt,
      required this.syncState,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['nome'] = Variable<String>(nome);
    if (!nullToAbsent || cpfCnpj != null) {
      map['cpf_cnpj'] = Variable<String>(cpfCnpj);
    }
    if (!nullToAbsent || telefone != null) {
      map['telefone'] = Variable<String>(telefone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || cidade != null) {
      map['cidade'] = Variable<String>(cidade);
    }
    if (!nullToAbsent || uf != null) {
      map['uf'] = Variable<String>(uf);
    }
    map['ativo'] = Variable<bool>(ativo);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ClientesCompanion toCompanion(bool nullToAbsent) {
    return ClientesCompanion(
      uid: Value(uid),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      nome: Value(nome),
      cpfCnpj: cpfCnpj == null && nullToAbsent
          ? const Value.absent()
          : Value(cpfCnpj),
      telefone: telefone == null && nullToAbsent
          ? const Value.absent()
          : Value(telefone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      cidade:
          cidade == null && nullToAbsent ? const Value.absent() : Value(cidade),
      uf: uf == null && nullToAbsent ? const Value.absent() : Value(uf),
      ativo: Value(ativo),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncState: Value(syncState),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Cliente.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cliente(
      uid: serializer.fromJson<String>(json['uid']),
      userId: serializer.fromJson<String?>(json['userId']),
      nome: serializer.fromJson<String>(json['nome']),
      cpfCnpj: serializer.fromJson<String?>(json['cpfCnpj']),
      telefone: serializer.fromJson<String?>(json['telefone']),
      email: serializer.fromJson<String?>(json['email']),
      cidade: serializer.fromJson<String?>(json['cidade']),
      uf: serializer.fromJson<String?>(json['uf']),
      ativo: serializer.fromJson<bool>(json['ativo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'userId': serializer.toJson<String?>(userId),
      'nome': serializer.toJson<String>(nome),
      'cpfCnpj': serializer.toJson<String?>(cpfCnpj),
      'telefone': serializer.toJson<String?>(telefone),
      'email': serializer.toJson<String?>(email),
      'cidade': serializer.toJson<String?>(cidade),
      'uf': serializer.toJson<String?>(uf),
      'ativo': serializer.toJson<bool>(ativo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncState': serializer.toJson<String>(syncState),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Cliente copyWith(
          {String? uid,
          Value<String?> userId = const Value.absent(),
          String? nome,
          Value<String?> cpfCnpj = const Value.absent(),
          Value<String?> telefone = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> cidade = const Value.absent(),
          Value<String?> uf = const Value.absent(),
          bool? ativo,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncState,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      Cliente(
        uid: uid ?? this.uid,
        userId: userId.present ? userId.value : this.userId,
        nome: nome ?? this.nome,
        cpfCnpj: cpfCnpj.present ? cpfCnpj.value : this.cpfCnpj,
        telefone: telefone.present ? telefone.value : this.telefone,
        email: email.present ? email.value : this.email,
        cidade: cidade.present ? cidade.value : this.cidade,
        uf: uf.present ? uf.value : this.uf,
        ativo: ativo ?? this.ativo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncState: syncState ?? this.syncState,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  Cliente copyWithCompanion(ClientesCompanion data) {
    return Cliente(
      uid: data.uid.present ? data.uid.value : this.uid,
      userId: data.userId.present ? data.userId.value : this.userId,
      nome: data.nome.present ? data.nome.value : this.nome,
      cpfCnpj: data.cpfCnpj.present ? data.cpfCnpj.value : this.cpfCnpj,
      telefone: data.telefone.present ? data.telefone.value : this.telefone,
      email: data.email.present ? data.email.value : this.email,
      cidade: data.cidade.present ? data.cidade.value : this.cidade,
      uf: data.uf.present ? data.uf.value : this.uf,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cliente(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('nome: $nome, ')
          ..write('cpfCnpj: $cpfCnpj, ')
          ..write('telefone: $telefone, ')
          ..write('email: $email, ')
          ..write('cidade: $cidade, ')
          ..write('uf: $uf, ')
          ..write('ativo: $ativo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uid, userId, nome, cpfCnpj, telefone, email,
      cidade, uf, ativo, createdAt, updatedAt, syncState, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cliente &&
          other.uid == this.uid &&
          other.userId == this.userId &&
          other.nome == this.nome &&
          other.cpfCnpj == this.cpfCnpj &&
          other.telefone == this.telefone &&
          other.email == this.email &&
          other.cidade == this.cidade &&
          other.uf == this.uf &&
          other.ativo == this.ativo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncState == this.syncState &&
          other.deletedAt == this.deletedAt);
}

class ClientesCompanion extends UpdateCompanion<Cliente> {
  final Value<String> uid;
  final Value<String?> userId;
  final Value<String> nome;
  final Value<String?> cpfCnpj;
  final Value<String?> telefone;
  final Value<String?> email;
  final Value<String?> cidade;
  final Value<String?> uf;
  final Value<bool> ativo;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncState;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const ClientesCompanion({
    this.uid = const Value.absent(),
    this.userId = const Value.absent(),
    this.nome = const Value.absent(),
    this.cpfCnpj = const Value.absent(),
    this.telefone = const Value.absent(),
    this.email = const Value.absent(),
    this.cidade = const Value.absent(),
    this.uf = const Value.absent(),
    this.ativo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientesCompanion.insert({
    required String uid,
    this.userId = const Value.absent(),
    required String nome,
    this.cpfCnpj = const Value.absent(),
    this.telefone = const Value.absent(),
    this.email = const Value.absent(),
    this.cidade = const Value.absent(),
    this.uf = const Value.absent(),
    this.ativo = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        nome = Value(nome),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Cliente> custom({
    Expression<String>? uid,
    Expression<String>? userId,
    Expression<String>? nome,
    Expression<String>? cpfCnpj,
    Expression<String>? telefone,
    Expression<String>? email,
    Expression<String>? cidade,
    Expression<String>? uf,
    Expression<bool>? ativo,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncState,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (userId != null) 'user_id': userId,
      if (nome != null) 'nome': nome,
      if (cpfCnpj != null) 'cpf_cnpj': cpfCnpj,
      if (telefone != null) 'telefone': telefone,
      if (email != null) 'email': email,
      if (cidade != null) 'cidade': cidade,
      if (uf != null) 'uf': uf,
      if (ativo != null) 'ativo': ativo,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncState != null) 'sync_state': syncState,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientesCompanion copyWith(
      {Value<String>? uid,
      Value<String?>? userId,
      Value<String>? nome,
      Value<String?>? cpfCnpj,
      Value<String?>? telefone,
      Value<String?>? email,
      Value<String?>? cidade,
      Value<String?>? uf,
      Value<bool>? ativo,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncState,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return ClientesCompanion(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      nome: nome ?? this.nome,
      cpfCnpj: cpfCnpj ?? this.cpfCnpj,
      telefone: telefone ?? this.telefone,
      email: email ?? this.email,
      cidade: cidade ?? this.cidade,
      uf: uf ?? this.uf,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncState: syncState ?? this.syncState,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (cpfCnpj.present) {
      map['cpf_cnpj'] = Variable<String>(cpfCnpj.value);
    }
    if (telefone.present) {
      map['telefone'] = Variable<String>(telefone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (cidade.present) {
      map['cidade'] = Variable<String>(cidade.value);
    }
    if (uf.present) {
      map['uf'] = Variable<String>(uf.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientesCompanion(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('nome: $nome, ')
          ..write('cpfCnpj: $cpfCnpj, ')
          ..write('telefone: $telefone, ')
          ..write('email: $email, ')
          ..write('cidade: $cidade, ')
          ..write('uf: $uf, ')
          ..write('ativo: $ativo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FazendasTable extends Fazendas with TableInfo<$FazendasTable, Fazenda> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FazendasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _clienteIdMeta =
      const VerificationMeta('clienteId');
  @override
  late final GeneratedColumn<String> clienteId = GeneratedColumn<String>(
      'cliente_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES clientes (uid) ON DELETE CASCADE'));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _areaHaMeta = const VerificationMeta('areaHa');
  @override
  late final GeneratedColumn<double> areaHa = GeneratedColumn<double>(
      'area_ha', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _culturaMeta =
      const VerificationMeta('cultura');
  @override
  late final GeneratedColumn<String> cultura = GeneratedColumn<String>(
      'cultura', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _safraMeta = const VerificationMeta('safra');
  @override
  late final GeneratedColumn<String> safra = GeneratedColumn<String>(
      'safra', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _municipioMeta =
      const VerificationMeta('municipio');
  @override
  late final GeneratedColumn<String> municipio = GeneratedColumn<String>(
      'municipio', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ufMeta = const VerificationMeta('uf');
  @override
  late final GeneratedColumn<String> uf = GeneratedColumn<String>(
      'uf', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
      'ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ativo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        userId,
        clienteId,
        nome,
        areaHa,
        cultura,
        safra,
        municipio,
        uf,
        ativo,
        createdAt,
        updatedAt,
        syncState,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fazendas';
  @override
  VerificationContext validateIntegrity(Insertable<Fazenda> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('cliente_id')) {
      context.handle(_clienteIdMeta,
          clienteId.isAcceptableOrUnknown(data['cliente_id']!, _clienteIdMeta));
    } else if (isInserting) {
      context.missing(_clienteIdMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('area_ha')) {
      context.handle(_areaHaMeta,
          areaHa.isAcceptableOrUnknown(data['area_ha']!, _areaHaMeta));
    } else if (isInserting) {
      context.missing(_areaHaMeta);
    }
    if (data.containsKey('cultura')) {
      context.handle(_culturaMeta,
          cultura.isAcceptableOrUnknown(data['cultura']!, _culturaMeta));
    } else if (isInserting) {
      context.missing(_culturaMeta);
    }
    if (data.containsKey('safra')) {
      context.handle(
          _safraMeta, safra.isAcceptableOrUnknown(data['safra']!, _safraMeta));
    } else if (isInserting) {
      context.missing(_safraMeta);
    }
    if (data.containsKey('municipio')) {
      context.handle(_municipioMeta,
          municipio.isAcceptableOrUnknown(data['municipio']!, _municipioMeta));
    }
    if (data.containsKey('uf')) {
      context.handle(_ufMeta, uf.isAcceptableOrUnknown(data['uf']!, _ufMeta));
    }
    if (data.containsKey('ativo')) {
      context.handle(
          _ativoMeta, ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  Fazenda map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Fazenda(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      clienteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cliente_id'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      areaHa: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}area_ha'])!,
      cultura: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cultura'])!,
      safra: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}safra'])!,
      municipio: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}municipio']),
      uf: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uf']),
      ativo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ativo'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $FazendasTable createAlias(String alias) {
    return $FazendasTable(attachedDatabase, alias);
  }
}

class Fazenda extends DataClass implements Insertable<Fazenda> {
  final String uid;
  final String? userId;
  final String clienteId;
  final String nome;
  final double areaHa;
  final String cultura;
  final String safra;
  final String? municipio;
  final String? uf;
  final bool ativo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncState;
  final DateTime? deletedAt;
  const Fazenda(
      {required this.uid,
      this.userId,
      required this.clienteId,
      required this.nome,
      required this.areaHa,
      required this.cultura,
      required this.safra,
      this.municipio,
      this.uf,
      required this.ativo,
      required this.createdAt,
      required this.updatedAt,
      required this.syncState,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['cliente_id'] = Variable<String>(clienteId);
    map['nome'] = Variable<String>(nome);
    map['area_ha'] = Variable<double>(areaHa);
    map['cultura'] = Variable<String>(cultura);
    map['safra'] = Variable<String>(safra);
    if (!nullToAbsent || municipio != null) {
      map['municipio'] = Variable<String>(municipio);
    }
    if (!nullToAbsent || uf != null) {
      map['uf'] = Variable<String>(uf);
    }
    map['ativo'] = Variable<bool>(ativo);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  FazendasCompanion toCompanion(bool nullToAbsent) {
    return FazendasCompanion(
      uid: Value(uid),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      clienteId: Value(clienteId),
      nome: Value(nome),
      areaHa: Value(areaHa),
      cultura: Value(cultura),
      safra: Value(safra),
      municipio: municipio == null && nullToAbsent
          ? const Value.absent()
          : Value(municipio),
      uf: uf == null && nullToAbsent ? const Value.absent() : Value(uf),
      ativo: Value(ativo),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncState: Value(syncState),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Fazenda.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Fazenda(
      uid: serializer.fromJson<String>(json['uid']),
      userId: serializer.fromJson<String?>(json['userId']),
      clienteId: serializer.fromJson<String>(json['clienteId']),
      nome: serializer.fromJson<String>(json['nome']),
      areaHa: serializer.fromJson<double>(json['areaHa']),
      cultura: serializer.fromJson<String>(json['cultura']),
      safra: serializer.fromJson<String>(json['safra']),
      municipio: serializer.fromJson<String?>(json['municipio']),
      uf: serializer.fromJson<String?>(json['uf']),
      ativo: serializer.fromJson<bool>(json['ativo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'userId': serializer.toJson<String?>(userId),
      'clienteId': serializer.toJson<String>(clienteId),
      'nome': serializer.toJson<String>(nome),
      'areaHa': serializer.toJson<double>(areaHa),
      'cultura': serializer.toJson<String>(cultura),
      'safra': serializer.toJson<String>(safra),
      'municipio': serializer.toJson<String?>(municipio),
      'uf': serializer.toJson<String?>(uf),
      'ativo': serializer.toJson<bool>(ativo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncState': serializer.toJson<String>(syncState),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Fazenda copyWith(
          {String? uid,
          Value<String?> userId = const Value.absent(),
          String? clienteId,
          String? nome,
          double? areaHa,
          String? cultura,
          String? safra,
          Value<String?> municipio = const Value.absent(),
          Value<String?> uf = const Value.absent(),
          bool? ativo,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncState,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      Fazenda(
        uid: uid ?? this.uid,
        userId: userId.present ? userId.value : this.userId,
        clienteId: clienteId ?? this.clienteId,
        nome: nome ?? this.nome,
        areaHa: areaHa ?? this.areaHa,
        cultura: cultura ?? this.cultura,
        safra: safra ?? this.safra,
        municipio: municipio.present ? municipio.value : this.municipio,
        uf: uf.present ? uf.value : this.uf,
        ativo: ativo ?? this.ativo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncState: syncState ?? this.syncState,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  Fazenda copyWithCompanion(FazendasCompanion data) {
    return Fazenda(
      uid: data.uid.present ? data.uid.value : this.uid,
      userId: data.userId.present ? data.userId.value : this.userId,
      clienteId: data.clienteId.present ? data.clienteId.value : this.clienteId,
      nome: data.nome.present ? data.nome.value : this.nome,
      areaHa: data.areaHa.present ? data.areaHa.value : this.areaHa,
      cultura: data.cultura.present ? data.cultura.value : this.cultura,
      safra: data.safra.present ? data.safra.value : this.safra,
      municipio: data.municipio.present ? data.municipio.value : this.municipio,
      uf: data.uf.present ? data.uf.value : this.uf,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Fazenda(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('clienteId: $clienteId, ')
          ..write('nome: $nome, ')
          ..write('areaHa: $areaHa, ')
          ..write('cultura: $cultura, ')
          ..write('safra: $safra, ')
          ..write('municipio: $municipio, ')
          ..write('uf: $uf, ')
          ..write('ativo: $ativo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uid, userId, clienteId, nome, areaHa, cultura,
      safra, municipio, uf, ativo, createdAt, updatedAt, syncState, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Fazenda &&
          other.uid == this.uid &&
          other.userId == this.userId &&
          other.clienteId == this.clienteId &&
          other.nome == this.nome &&
          other.areaHa == this.areaHa &&
          other.cultura == this.cultura &&
          other.safra == this.safra &&
          other.municipio == this.municipio &&
          other.uf == this.uf &&
          other.ativo == this.ativo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncState == this.syncState &&
          other.deletedAt == this.deletedAt);
}

class FazendasCompanion extends UpdateCompanion<Fazenda> {
  final Value<String> uid;
  final Value<String?> userId;
  final Value<String> clienteId;
  final Value<String> nome;
  final Value<double> areaHa;
  final Value<String> cultura;
  final Value<String> safra;
  final Value<String?> municipio;
  final Value<String?> uf;
  final Value<bool> ativo;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncState;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const FazendasCompanion({
    this.uid = const Value.absent(),
    this.userId = const Value.absent(),
    this.clienteId = const Value.absent(),
    this.nome = const Value.absent(),
    this.areaHa = const Value.absent(),
    this.cultura = const Value.absent(),
    this.safra = const Value.absent(),
    this.municipio = const Value.absent(),
    this.uf = const Value.absent(),
    this.ativo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FazendasCompanion.insert({
    required String uid,
    this.userId = const Value.absent(),
    required String clienteId,
    required String nome,
    required double areaHa,
    required String cultura,
    required String safra,
    this.municipio = const Value.absent(),
    this.uf = const Value.absent(),
    this.ativo = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        clienteId = Value(clienteId),
        nome = Value(nome),
        areaHa = Value(areaHa),
        cultura = Value(cultura),
        safra = Value(safra),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Fazenda> custom({
    Expression<String>? uid,
    Expression<String>? userId,
    Expression<String>? clienteId,
    Expression<String>? nome,
    Expression<double>? areaHa,
    Expression<String>? cultura,
    Expression<String>? safra,
    Expression<String>? municipio,
    Expression<String>? uf,
    Expression<bool>? ativo,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncState,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (userId != null) 'user_id': userId,
      if (clienteId != null) 'cliente_id': clienteId,
      if (nome != null) 'nome': nome,
      if (areaHa != null) 'area_ha': areaHa,
      if (cultura != null) 'cultura': cultura,
      if (safra != null) 'safra': safra,
      if (municipio != null) 'municipio': municipio,
      if (uf != null) 'uf': uf,
      if (ativo != null) 'ativo': ativo,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncState != null) 'sync_state': syncState,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FazendasCompanion copyWith(
      {Value<String>? uid,
      Value<String?>? userId,
      Value<String>? clienteId,
      Value<String>? nome,
      Value<double>? areaHa,
      Value<String>? cultura,
      Value<String>? safra,
      Value<String?>? municipio,
      Value<String?>? uf,
      Value<bool>? ativo,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncState,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return FazendasCompanion(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      clienteId: clienteId ?? this.clienteId,
      nome: nome ?? this.nome,
      areaHa: areaHa ?? this.areaHa,
      cultura: cultura ?? this.cultura,
      safra: safra ?? this.safra,
      municipio: municipio ?? this.municipio,
      uf: uf ?? this.uf,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncState: syncState ?? this.syncState,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (clienteId.present) {
      map['cliente_id'] = Variable<String>(clienteId.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (areaHa.present) {
      map['area_ha'] = Variable<double>(areaHa.value);
    }
    if (cultura.present) {
      map['cultura'] = Variable<String>(cultura.value);
    }
    if (safra.present) {
      map['safra'] = Variable<String>(safra.value);
    }
    if (municipio.present) {
      map['municipio'] = Variable<String>(municipio.value);
    }
    if (uf.present) {
      map['uf'] = Variable<String>(uf.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FazendasCompanion(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('clienteId: $clienteId, ')
          ..write('nome: $nome, ')
          ..write('areaHa: $areaHa, ')
          ..write('cultura: $cultura, ')
          ..write('safra: $safra, ')
          ..write('municipio: $municipio, ')
          ..write('uf: $uf, ')
          ..write('ativo: $ativo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TalhoesTable extends Talhoes with TableInfo<$TalhoesTable, Talhoe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TalhoesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fazendaIdMeta =
      const VerificationMeta('fazendaId');
  @override
  late final GeneratedColumn<String> fazendaId = GeneratedColumn<String>(
      'fazenda_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES fazendas (uid) ON DELETE CASCADE'));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _areaHaMeta = const VerificationMeta('areaHa');
  @override
  late final GeneratedColumn<double> areaHa = GeneratedColumn<double>(
      'area_ha', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _observacaoMeta =
      const VerificationMeta('observacao');
  @override
  late final GeneratedColumn<String> observacao = GeneratedColumn<String>(
      'observacao', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
      'ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ativo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        userId,
        fazendaId,
        nome,
        areaHa,
        observacao,
        ativo,
        createdAt,
        updatedAt,
        syncState,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'talhoes';
  @override
  VerificationContext validateIntegrity(Insertable<Talhoe> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('fazenda_id')) {
      context.handle(_fazendaIdMeta,
          fazendaId.isAcceptableOrUnknown(data['fazenda_id']!, _fazendaIdMeta));
    } else if (isInserting) {
      context.missing(_fazendaIdMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('area_ha')) {
      context.handle(_areaHaMeta,
          areaHa.isAcceptableOrUnknown(data['area_ha']!, _areaHaMeta));
    } else if (isInserting) {
      context.missing(_areaHaMeta);
    }
    if (data.containsKey('observacao')) {
      context.handle(
          _observacaoMeta,
          observacao.isAcceptableOrUnknown(
              data['observacao']!, _observacaoMeta));
    }
    if (data.containsKey('ativo')) {
      context.handle(
          _ativoMeta, ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  Talhoe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Talhoe(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      fazendaId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fazenda_id'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      areaHa: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}area_ha'])!,
      observacao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacao']),
      ativo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ativo'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $TalhoesTable createAlias(String alias) {
    return $TalhoesTable(attachedDatabase, alias);
  }
}

class Talhoe extends DataClass implements Insertable<Talhoe> {
  final String uid;
  final String? userId;
  final String fazendaId;
  final String nome;
  final double areaHa;
  final String? observacao;
  final bool ativo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncState;
  final DateTime? deletedAt;
  const Talhoe(
      {required this.uid,
      this.userId,
      required this.fazendaId,
      required this.nome,
      required this.areaHa,
      this.observacao,
      required this.ativo,
      required this.createdAt,
      required this.updatedAt,
      required this.syncState,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['fazenda_id'] = Variable<String>(fazendaId);
    map['nome'] = Variable<String>(nome);
    map['area_ha'] = Variable<double>(areaHa);
    if (!nullToAbsent || observacao != null) {
      map['observacao'] = Variable<String>(observacao);
    }
    map['ativo'] = Variable<bool>(ativo);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  TalhoesCompanion toCompanion(bool nullToAbsent) {
    return TalhoesCompanion(
      uid: Value(uid),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      fazendaId: Value(fazendaId),
      nome: Value(nome),
      areaHa: Value(areaHa),
      observacao: observacao == null && nullToAbsent
          ? const Value.absent()
          : Value(observacao),
      ativo: Value(ativo),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncState: Value(syncState),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Talhoe.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Talhoe(
      uid: serializer.fromJson<String>(json['uid']),
      userId: serializer.fromJson<String?>(json['userId']),
      fazendaId: serializer.fromJson<String>(json['fazendaId']),
      nome: serializer.fromJson<String>(json['nome']),
      areaHa: serializer.fromJson<double>(json['areaHa']),
      observacao: serializer.fromJson<String?>(json['observacao']),
      ativo: serializer.fromJson<bool>(json['ativo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'userId': serializer.toJson<String?>(userId),
      'fazendaId': serializer.toJson<String>(fazendaId),
      'nome': serializer.toJson<String>(nome),
      'areaHa': serializer.toJson<double>(areaHa),
      'observacao': serializer.toJson<String?>(observacao),
      'ativo': serializer.toJson<bool>(ativo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncState': serializer.toJson<String>(syncState),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Talhoe copyWith(
          {String? uid,
          Value<String?> userId = const Value.absent(),
          String? fazendaId,
          String? nome,
          double? areaHa,
          Value<String?> observacao = const Value.absent(),
          bool? ativo,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncState,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      Talhoe(
        uid: uid ?? this.uid,
        userId: userId.present ? userId.value : this.userId,
        fazendaId: fazendaId ?? this.fazendaId,
        nome: nome ?? this.nome,
        areaHa: areaHa ?? this.areaHa,
        observacao: observacao.present ? observacao.value : this.observacao,
        ativo: ativo ?? this.ativo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncState: syncState ?? this.syncState,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  Talhoe copyWithCompanion(TalhoesCompanion data) {
    return Talhoe(
      uid: data.uid.present ? data.uid.value : this.uid,
      userId: data.userId.present ? data.userId.value : this.userId,
      fazendaId: data.fazendaId.present ? data.fazendaId.value : this.fazendaId,
      nome: data.nome.present ? data.nome.value : this.nome,
      areaHa: data.areaHa.present ? data.areaHa.value : this.areaHa,
      observacao:
          data.observacao.present ? data.observacao.value : this.observacao,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Talhoe(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('fazendaId: $fazendaId, ')
          ..write('nome: $nome, ')
          ..write('areaHa: $areaHa, ')
          ..write('observacao: $observacao, ')
          ..write('ativo: $ativo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uid, userId, fazendaId, nome, areaHa,
      observacao, ativo, createdAt, updatedAt, syncState, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Talhoe &&
          other.uid == this.uid &&
          other.userId == this.userId &&
          other.fazendaId == this.fazendaId &&
          other.nome == this.nome &&
          other.areaHa == this.areaHa &&
          other.observacao == this.observacao &&
          other.ativo == this.ativo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncState == this.syncState &&
          other.deletedAt == this.deletedAt);
}

class TalhoesCompanion extends UpdateCompanion<Talhoe> {
  final Value<String> uid;
  final Value<String?> userId;
  final Value<String> fazendaId;
  final Value<String> nome;
  final Value<double> areaHa;
  final Value<String?> observacao;
  final Value<bool> ativo;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncState;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const TalhoesCompanion({
    this.uid = const Value.absent(),
    this.userId = const Value.absent(),
    this.fazendaId = const Value.absent(),
    this.nome = const Value.absent(),
    this.areaHa = const Value.absent(),
    this.observacao = const Value.absent(),
    this.ativo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TalhoesCompanion.insert({
    required String uid,
    this.userId = const Value.absent(),
    required String fazendaId,
    required String nome,
    required double areaHa,
    this.observacao = const Value.absent(),
    this.ativo = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        fazendaId = Value(fazendaId),
        nome = Value(nome),
        areaHa = Value(areaHa),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Talhoe> custom({
    Expression<String>? uid,
    Expression<String>? userId,
    Expression<String>? fazendaId,
    Expression<String>? nome,
    Expression<double>? areaHa,
    Expression<String>? observacao,
    Expression<bool>? ativo,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncState,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (userId != null) 'user_id': userId,
      if (fazendaId != null) 'fazenda_id': fazendaId,
      if (nome != null) 'nome': nome,
      if (areaHa != null) 'area_ha': areaHa,
      if (observacao != null) 'observacao': observacao,
      if (ativo != null) 'ativo': ativo,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncState != null) 'sync_state': syncState,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TalhoesCompanion copyWith(
      {Value<String>? uid,
      Value<String?>? userId,
      Value<String>? fazendaId,
      Value<String>? nome,
      Value<double>? areaHa,
      Value<String?>? observacao,
      Value<bool>? ativo,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncState,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return TalhoesCompanion(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      fazendaId: fazendaId ?? this.fazendaId,
      nome: nome ?? this.nome,
      areaHa: areaHa ?? this.areaHa,
      observacao: observacao ?? this.observacao,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncState: syncState ?? this.syncState,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (fazendaId.present) {
      map['fazenda_id'] = Variable<String>(fazendaId.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (areaHa.present) {
      map['area_ha'] = Variable<double>(areaHa.value);
    }
    if (observacao.present) {
      map['observacao'] = Variable<String>(observacao.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TalhoesCompanion(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('fazendaId: $fazendaId, ')
          ..write('nome: $nome, ')
          ..write('areaHa: $areaHa, ')
          ..write('observacao: $observacao, ')
          ..write('ativo: $ativo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CatalogoProdutosTable extends CatalogoProdutos
    with TableInfo<$CatalogoProdutosTable, CatalogoProduto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CatalogoProdutosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nomeComercialMeta =
      const VerificationMeta('nomeComercial');
  @override
  late final GeneratedColumn<String> nomeComercial = GeneratedColumn<String>(
      'nome_comercial', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ingredienteAtivoMeta =
      const VerificationMeta('ingredienteAtivo');
  @override
  late final GeneratedColumn<String> ingredienteAtivo = GeneratedColumn<String>(
      'ingrediente_ativo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoriaMeta =
      const VerificationMeta('categoria');
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
      'categoria', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unidadePadraoMeta =
      const VerificationMeta('unidadePadrao');
  @override
  late final GeneratedColumn<String> unidadePadrao = GeneratedColumn<String>(
      'unidade_padrao', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _doseMinMeta =
      const VerificationMeta('doseMin');
  @override
  late final GeneratedColumn<double> doseMin = GeneratedColumn<double>(
      'dose_min', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _doseMaxMeta =
      const VerificationMeta('doseMax');
  @override
  late final GeneratedColumn<double> doseMax = GeneratedColumn<double>(
      'dose_max', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _precoUnitarioMeta =
      const VerificationMeta('precoUnitario');
  @override
  late final GeneratedColumn<double> precoUnitario = GeneratedColumn<double>(
      'preco_unitario', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _fabricanteMeta =
      const VerificationMeta('fabricante');
  @override
  late final GeneratedColumn<String> fabricante = GeneratedColumn<String>(
      'fabricante', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _observacoesMeta =
      const VerificationMeta('observacoes');
  @override
  late final GeneratedColumn<String> observacoes = GeneratedColumn<String>(
      'observacoes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _culturasMeta =
      const VerificationMeta('culturas');
  @override
  late final GeneratedColumn<String> culturas = GeneratedColumn<String>(
      'culturas', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
      'ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ativo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isSeedMeta = const VerificationMeta('isSeed');
  @override
  late final GeneratedColumn<bool> isSeed = GeneratedColumn<bool>(
      'is_seed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_seed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        userId,
        nomeComercial,
        ingredienteAtivo,
        categoria,
        unidadePadrao,
        doseMin,
        doseMax,
        precoUnitario,
        fabricante,
        observacoes,
        culturas,
        ativo,
        isSeed,
        createdAt,
        updatedAt,
        syncState,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'catalogo_produtos';
  @override
  VerificationContext validateIntegrity(Insertable<CatalogoProduto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('nome_comercial')) {
      context.handle(
          _nomeComercialMeta,
          nomeComercial.isAcceptableOrUnknown(
              data['nome_comercial']!, _nomeComercialMeta));
    } else if (isInserting) {
      context.missing(_nomeComercialMeta);
    }
    if (data.containsKey('ingrediente_ativo')) {
      context.handle(
          _ingredienteAtivoMeta,
          ingredienteAtivo.isAcceptableOrUnknown(
              data['ingrediente_ativo']!, _ingredienteAtivoMeta));
    }
    if (data.containsKey('categoria')) {
      context.handle(_categoriaMeta,
          categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta));
    } else if (isInserting) {
      context.missing(_categoriaMeta);
    }
    if (data.containsKey('unidade_padrao')) {
      context.handle(
          _unidadePadraoMeta,
          unidadePadrao.isAcceptableOrUnknown(
              data['unidade_padrao']!, _unidadePadraoMeta));
    } else if (isInserting) {
      context.missing(_unidadePadraoMeta);
    }
    if (data.containsKey('dose_min')) {
      context.handle(_doseMinMeta,
          doseMin.isAcceptableOrUnknown(data['dose_min']!, _doseMinMeta));
    }
    if (data.containsKey('dose_max')) {
      context.handle(_doseMaxMeta,
          doseMax.isAcceptableOrUnknown(data['dose_max']!, _doseMaxMeta));
    }
    if (data.containsKey('preco_unitario')) {
      context.handle(
          _precoUnitarioMeta,
          precoUnitario.isAcceptableOrUnknown(
              data['preco_unitario']!, _precoUnitarioMeta));
    }
    if (data.containsKey('fabricante')) {
      context.handle(
          _fabricanteMeta,
          fabricante.isAcceptableOrUnknown(
              data['fabricante']!, _fabricanteMeta));
    }
    if (data.containsKey('observacoes')) {
      context.handle(
          _observacoesMeta,
          observacoes.isAcceptableOrUnknown(
              data['observacoes']!, _observacoesMeta));
    }
    if (data.containsKey('culturas')) {
      context.handle(_culturasMeta,
          culturas.isAcceptableOrUnknown(data['culturas']!, _culturasMeta));
    }
    if (data.containsKey('ativo')) {
      context.handle(
          _ativoMeta, ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta));
    }
    if (data.containsKey('is_seed')) {
      context.handle(_isSeedMeta,
          isSeed.isAcceptableOrUnknown(data['is_seed']!, _isSeedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  CatalogoProduto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CatalogoProduto(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      nomeComercial: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome_comercial'])!,
      ingredienteAtivo: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}ingrediente_ativo']),
      categoria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoria'])!,
      unidadePadrao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unidade_padrao'])!,
      doseMin: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}dose_min']),
      doseMax: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}dose_max']),
      precoUnitario: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}preco_unitario']),
      fabricante: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fabricante']),
      observacoes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacoes']),
      culturas: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}culturas']),
      ativo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ativo'])!,
      isSeed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_seed'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $CatalogoProdutosTable createAlias(String alias) {
    return $CatalogoProdutosTable(attachedDatabase, alias);
  }
}

class CatalogoProduto extends DataClass implements Insertable<CatalogoProduto> {
  final String uid;
  final String? userId;
  final String nomeComercial;
  final String? ingredienteAtivo;
  final String categoria;
  final String unidadePadrao;
  final double? doseMin;
  final double? doseMax;
  final double? precoUnitario;
  final String? fabricante;
  final String? observacoes;
  final String? culturas;
  final bool ativo;
  final bool isSeed;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncState;
  final DateTime? deletedAt;
  const CatalogoProduto(
      {required this.uid,
      this.userId,
      required this.nomeComercial,
      this.ingredienteAtivo,
      required this.categoria,
      required this.unidadePadrao,
      this.doseMin,
      this.doseMax,
      this.precoUnitario,
      this.fabricante,
      this.observacoes,
      this.culturas,
      required this.ativo,
      required this.isSeed,
      required this.createdAt,
      required this.updatedAt,
      required this.syncState,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['nome_comercial'] = Variable<String>(nomeComercial);
    if (!nullToAbsent || ingredienteAtivo != null) {
      map['ingrediente_ativo'] = Variable<String>(ingredienteAtivo);
    }
    map['categoria'] = Variable<String>(categoria);
    map['unidade_padrao'] = Variable<String>(unidadePadrao);
    if (!nullToAbsent || doseMin != null) {
      map['dose_min'] = Variable<double>(doseMin);
    }
    if (!nullToAbsent || doseMax != null) {
      map['dose_max'] = Variable<double>(doseMax);
    }
    if (!nullToAbsent || precoUnitario != null) {
      map['preco_unitario'] = Variable<double>(precoUnitario);
    }
    if (!nullToAbsent || fabricante != null) {
      map['fabricante'] = Variable<String>(fabricante);
    }
    if (!nullToAbsent || observacoes != null) {
      map['observacoes'] = Variable<String>(observacoes);
    }
    if (!nullToAbsent || culturas != null) {
      map['culturas'] = Variable<String>(culturas);
    }
    map['ativo'] = Variable<bool>(ativo);
    map['is_seed'] = Variable<bool>(isSeed);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  CatalogoProdutosCompanion toCompanion(bool nullToAbsent) {
    return CatalogoProdutosCompanion(
      uid: Value(uid),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      nomeComercial: Value(nomeComercial),
      ingredienteAtivo: ingredienteAtivo == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredienteAtivo),
      categoria: Value(categoria),
      unidadePadrao: Value(unidadePadrao),
      doseMin: doseMin == null && nullToAbsent
          ? const Value.absent()
          : Value(doseMin),
      doseMax: doseMax == null && nullToAbsent
          ? const Value.absent()
          : Value(doseMax),
      precoUnitario: precoUnitario == null && nullToAbsent
          ? const Value.absent()
          : Value(precoUnitario),
      fabricante: fabricante == null && nullToAbsent
          ? const Value.absent()
          : Value(fabricante),
      observacoes: observacoes == null && nullToAbsent
          ? const Value.absent()
          : Value(observacoes),
      culturas: culturas == null && nullToAbsent
          ? const Value.absent()
          : Value(culturas),
      ativo: Value(ativo),
      isSeed: Value(isSeed),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncState: Value(syncState),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory CatalogoProduto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CatalogoProduto(
      uid: serializer.fromJson<String>(json['uid']),
      userId: serializer.fromJson<String?>(json['userId']),
      nomeComercial: serializer.fromJson<String>(json['nomeComercial']),
      ingredienteAtivo: serializer.fromJson<String?>(json['ingredienteAtivo']),
      categoria: serializer.fromJson<String>(json['categoria']),
      unidadePadrao: serializer.fromJson<String>(json['unidadePadrao']),
      doseMin: serializer.fromJson<double?>(json['doseMin']),
      doseMax: serializer.fromJson<double?>(json['doseMax']),
      precoUnitario: serializer.fromJson<double?>(json['precoUnitario']),
      fabricante: serializer.fromJson<String?>(json['fabricante']),
      observacoes: serializer.fromJson<String?>(json['observacoes']),
      culturas: serializer.fromJson<String?>(json['culturas']),
      ativo: serializer.fromJson<bool>(json['ativo']),
      isSeed: serializer.fromJson<bool>(json['isSeed']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'userId': serializer.toJson<String?>(userId),
      'nomeComercial': serializer.toJson<String>(nomeComercial),
      'ingredienteAtivo': serializer.toJson<String?>(ingredienteAtivo),
      'categoria': serializer.toJson<String>(categoria),
      'unidadePadrao': serializer.toJson<String>(unidadePadrao),
      'doseMin': serializer.toJson<double?>(doseMin),
      'doseMax': serializer.toJson<double?>(doseMax),
      'precoUnitario': serializer.toJson<double?>(precoUnitario),
      'fabricante': serializer.toJson<String?>(fabricante),
      'observacoes': serializer.toJson<String?>(observacoes),
      'culturas': serializer.toJson<String?>(culturas),
      'ativo': serializer.toJson<bool>(ativo),
      'isSeed': serializer.toJson<bool>(isSeed),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncState': serializer.toJson<String>(syncState),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  CatalogoProduto copyWith(
          {String? uid,
          Value<String?> userId = const Value.absent(),
          String? nomeComercial,
          Value<String?> ingredienteAtivo = const Value.absent(),
          String? categoria,
          String? unidadePadrao,
          Value<double?> doseMin = const Value.absent(),
          Value<double?> doseMax = const Value.absent(),
          Value<double?> precoUnitario = const Value.absent(),
          Value<String?> fabricante = const Value.absent(),
          Value<String?> observacoes = const Value.absent(),
          Value<String?> culturas = const Value.absent(),
          bool? ativo,
          bool? isSeed,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncState,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      CatalogoProduto(
        uid: uid ?? this.uid,
        userId: userId.present ? userId.value : this.userId,
        nomeComercial: nomeComercial ?? this.nomeComercial,
        ingredienteAtivo: ingredienteAtivo.present
            ? ingredienteAtivo.value
            : this.ingredienteAtivo,
        categoria: categoria ?? this.categoria,
        unidadePadrao: unidadePadrao ?? this.unidadePadrao,
        doseMin: doseMin.present ? doseMin.value : this.doseMin,
        doseMax: doseMax.present ? doseMax.value : this.doseMax,
        precoUnitario:
            precoUnitario.present ? precoUnitario.value : this.precoUnitario,
        fabricante: fabricante.present ? fabricante.value : this.fabricante,
        observacoes: observacoes.present ? observacoes.value : this.observacoes,
        culturas: culturas.present ? culturas.value : this.culturas,
        ativo: ativo ?? this.ativo,
        isSeed: isSeed ?? this.isSeed,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncState: syncState ?? this.syncState,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  CatalogoProduto copyWithCompanion(CatalogoProdutosCompanion data) {
    return CatalogoProduto(
      uid: data.uid.present ? data.uid.value : this.uid,
      userId: data.userId.present ? data.userId.value : this.userId,
      nomeComercial: data.nomeComercial.present
          ? data.nomeComercial.value
          : this.nomeComercial,
      ingredienteAtivo: data.ingredienteAtivo.present
          ? data.ingredienteAtivo.value
          : this.ingredienteAtivo,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      unidadePadrao: data.unidadePadrao.present
          ? data.unidadePadrao.value
          : this.unidadePadrao,
      doseMin: data.doseMin.present ? data.doseMin.value : this.doseMin,
      doseMax: data.doseMax.present ? data.doseMax.value : this.doseMax,
      precoUnitario: data.precoUnitario.present
          ? data.precoUnitario.value
          : this.precoUnitario,
      fabricante:
          data.fabricante.present ? data.fabricante.value : this.fabricante,
      observacoes:
          data.observacoes.present ? data.observacoes.value : this.observacoes,
      culturas: data.culturas.present ? data.culturas.value : this.culturas,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      isSeed: data.isSeed.present ? data.isSeed.value : this.isSeed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CatalogoProduto(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('nomeComercial: $nomeComercial, ')
          ..write('ingredienteAtivo: $ingredienteAtivo, ')
          ..write('categoria: $categoria, ')
          ..write('unidadePadrao: $unidadePadrao, ')
          ..write('doseMin: $doseMin, ')
          ..write('doseMax: $doseMax, ')
          ..write('precoUnitario: $precoUnitario, ')
          ..write('fabricante: $fabricante, ')
          ..write('observacoes: $observacoes, ')
          ..write('culturas: $culturas, ')
          ..write('ativo: $ativo, ')
          ..write('isSeed: $isSeed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      uid,
      userId,
      nomeComercial,
      ingredienteAtivo,
      categoria,
      unidadePadrao,
      doseMin,
      doseMax,
      precoUnitario,
      fabricante,
      observacoes,
      culturas,
      ativo,
      isSeed,
      createdAt,
      updatedAt,
      syncState,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CatalogoProduto &&
          other.uid == this.uid &&
          other.userId == this.userId &&
          other.nomeComercial == this.nomeComercial &&
          other.ingredienteAtivo == this.ingredienteAtivo &&
          other.categoria == this.categoria &&
          other.unidadePadrao == this.unidadePadrao &&
          other.doseMin == this.doseMin &&
          other.doseMax == this.doseMax &&
          other.precoUnitario == this.precoUnitario &&
          other.fabricante == this.fabricante &&
          other.observacoes == this.observacoes &&
          other.culturas == this.culturas &&
          other.ativo == this.ativo &&
          other.isSeed == this.isSeed &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncState == this.syncState &&
          other.deletedAt == this.deletedAt);
}

class CatalogoProdutosCompanion extends UpdateCompanion<CatalogoProduto> {
  final Value<String> uid;
  final Value<String?> userId;
  final Value<String> nomeComercial;
  final Value<String?> ingredienteAtivo;
  final Value<String> categoria;
  final Value<String> unidadePadrao;
  final Value<double?> doseMin;
  final Value<double?> doseMax;
  final Value<double?> precoUnitario;
  final Value<String?> fabricante;
  final Value<String?> observacoes;
  final Value<String?> culturas;
  final Value<bool> ativo;
  final Value<bool> isSeed;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncState;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const CatalogoProdutosCompanion({
    this.uid = const Value.absent(),
    this.userId = const Value.absent(),
    this.nomeComercial = const Value.absent(),
    this.ingredienteAtivo = const Value.absent(),
    this.categoria = const Value.absent(),
    this.unidadePadrao = const Value.absent(),
    this.doseMin = const Value.absent(),
    this.doseMax = const Value.absent(),
    this.precoUnitario = const Value.absent(),
    this.fabricante = const Value.absent(),
    this.observacoes = const Value.absent(),
    this.culturas = const Value.absent(),
    this.ativo = const Value.absent(),
    this.isSeed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CatalogoProdutosCompanion.insert({
    required String uid,
    this.userId = const Value.absent(),
    required String nomeComercial,
    this.ingredienteAtivo = const Value.absent(),
    required String categoria,
    required String unidadePadrao,
    this.doseMin = const Value.absent(),
    this.doseMax = const Value.absent(),
    this.precoUnitario = const Value.absent(),
    this.fabricante = const Value.absent(),
    this.observacoes = const Value.absent(),
    this.culturas = const Value.absent(),
    this.ativo = const Value.absent(),
    this.isSeed = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        nomeComercial = Value(nomeComercial),
        categoria = Value(categoria),
        unidadePadrao = Value(unidadePadrao),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CatalogoProduto> custom({
    Expression<String>? uid,
    Expression<String>? userId,
    Expression<String>? nomeComercial,
    Expression<String>? ingredienteAtivo,
    Expression<String>? categoria,
    Expression<String>? unidadePadrao,
    Expression<double>? doseMin,
    Expression<double>? doseMax,
    Expression<double>? precoUnitario,
    Expression<String>? fabricante,
    Expression<String>? observacoes,
    Expression<String>? culturas,
    Expression<bool>? ativo,
    Expression<bool>? isSeed,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncState,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (userId != null) 'user_id': userId,
      if (nomeComercial != null) 'nome_comercial': nomeComercial,
      if (ingredienteAtivo != null) 'ingrediente_ativo': ingredienteAtivo,
      if (categoria != null) 'categoria': categoria,
      if (unidadePadrao != null) 'unidade_padrao': unidadePadrao,
      if (doseMin != null) 'dose_min': doseMin,
      if (doseMax != null) 'dose_max': doseMax,
      if (precoUnitario != null) 'preco_unitario': precoUnitario,
      if (fabricante != null) 'fabricante': fabricante,
      if (observacoes != null) 'observacoes': observacoes,
      if (culturas != null) 'culturas': culturas,
      if (ativo != null) 'ativo': ativo,
      if (isSeed != null) 'is_seed': isSeed,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncState != null) 'sync_state': syncState,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CatalogoProdutosCompanion copyWith(
      {Value<String>? uid,
      Value<String?>? userId,
      Value<String>? nomeComercial,
      Value<String?>? ingredienteAtivo,
      Value<String>? categoria,
      Value<String>? unidadePadrao,
      Value<double?>? doseMin,
      Value<double?>? doseMax,
      Value<double?>? precoUnitario,
      Value<String?>? fabricante,
      Value<String?>? observacoes,
      Value<String?>? culturas,
      Value<bool>? ativo,
      Value<bool>? isSeed,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncState,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return CatalogoProdutosCompanion(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      nomeComercial: nomeComercial ?? this.nomeComercial,
      ingredienteAtivo: ingredienteAtivo ?? this.ingredienteAtivo,
      categoria: categoria ?? this.categoria,
      unidadePadrao: unidadePadrao ?? this.unidadePadrao,
      doseMin: doseMin ?? this.doseMin,
      doseMax: doseMax ?? this.doseMax,
      precoUnitario: precoUnitario ?? this.precoUnitario,
      fabricante: fabricante ?? this.fabricante,
      observacoes: observacoes ?? this.observacoes,
      culturas: culturas ?? this.culturas,
      ativo: ativo ?? this.ativo,
      isSeed: isSeed ?? this.isSeed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncState: syncState ?? this.syncState,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (nomeComercial.present) {
      map['nome_comercial'] = Variable<String>(nomeComercial.value);
    }
    if (ingredienteAtivo.present) {
      map['ingrediente_ativo'] = Variable<String>(ingredienteAtivo.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (unidadePadrao.present) {
      map['unidade_padrao'] = Variable<String>(unidadePadrao.value);
    }
    if (doseMin.present) {
      map['dose_min'] = Variable<double>(doseMin.value);
    }
    if (doseMax.present) {
      map['dose_max'] = Variable<double>(doseMax.value);
    }
    if (precoUnitario.present) {
      map['preco_unitario'] = Variable<double>(precoUnitario.value);
    }
    if (fabricante.present) {
      map['fabricante'] = Variable<String>(fabricante.value);
    }
    if (observacoes.present) {
      map['observacoes'] = Variable<String>(observacoes.value);
    }
    if (culturas.present) {
      map['culturas'] = Variable<String>(culturas.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (isSeed.present) {
      map['is_seed'] = Variable<bool>(isSeed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CatalogoProdutosCompanion(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('nomeComercial: $nomeComercial, ')
          ..write('ingredienteAtivo: $ingredienteAtivo, ')
          ..write('categoria: $categoria, ')
          ..write('unidadePadrao: $unidadePadrao, ')
          ..write('doseMin: $doseMin, ')
          ..write('doseMax: $doseMax, ')
          ..write('precoUnitario: $precoUnitario, ')
          ..write('fabricante: $fabricante, ')
          ..write('observacoes: $observacoes, ')
          ..write('culturas: $culturas, ')
          ..write('ativo: $ativo, ')
          ..write('isSeed: $isSeed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReferenciasTecnicasTable extends ReferenciasTecnicas
    with TableInfo<$ReferenciasTecnicasTable, ReferenciasTecnica> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReferenciasTecnicasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoriaMeta =
      const VerificationMeta('categoria');
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
      'categoria', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _estadioMeta =
      const VerificationMeta('estadio');
  @override
  late final GeneratedColumn<String> estadio = GeneratedColumn<String>(
      'estadio', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  @override
  late final GeneratedColumn<String> titulo = GeneratedColumn<String>(
      'titulo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _focoManejoMeta =
      const VerificationMeta('focoManejo');
  @override
  late final GeneratedColumn<String> focoManejo = GeneratedColumn<String>(
      'foco_manejo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _praticasMeta =
      const VerificationMeta('praticas');
  @override
  late final GeneratedColumn<String> praticas = GeneratedColumn<String>(
      'praticas', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _padraoMeta = const VerificationMeta('padrao');
  @override
  late final GeneratedColumn<String> padrao = GeneratedColumn<String>(
      'padrao', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _destaqueMeta =
      const VerificationMeta('destaque');
  @override
  late final GeneratedColumn<String> destaque = GeneratedColumn<String>(
      'destaque', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fonteMeta = const VerificationMeta('fonte');
  @override
  late final GeneratedColumn<String> fonte = GeneratedColumn<String>(
      'fonte', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _safraReferenciaMeta =
      const VerificationMeta('safraReferencia');
  @override
  late final GeneratedColumn<String> safraReferencia = GeneratedColumn<String>(
      'safra_referencia', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dataReferenciaMeta =
      const VerificationMeta('dataReferencia');
  @override
  late final GeneratedColumn<DateTime> dataReferencia =
      GeneratedColumn<DateTime>('data_referencia', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _resultadoMeta =
      const VerificationMeta('resultado');
  @override
  late final GeneratedColumn<String> resultado = GeneratedColumn<String>(
      'resultado', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _localMeta = const VerificationMeta('local');
  @override
  late final GeneratedColumn<String> local = GeneratedColumn<String>(
      'local', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tipoFonteMeta =
      const VerificationMeta('tipoFonte');
  @override
  late final GeneratedColumn<String> tipoFonte = GeneratedColumn<String>(
      'tipo_fonte', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        categoria,
        estadio,
        titulo,
        descricao,
        focoManejo,
        praticas,
        padrao,
        destaque,
        fonte,
        safraReferencia,
        dataReferencia,
        resultado,
        local,
        tipoFonte
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'referencias_tecnicas';
  @override
  VerificationContext validateIntegrity(Insertable<ReferenciasTecnica> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('categoria')) {
      context.handle(_categoriaMeta,
          categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta));
    } else if (isInserting) {
      context.missing(_categoriaMeta);
    }
    if (data.containsKey('estadio')) {
      context.handle(_estadioMeta,
          estadio.isAcceptableOrUnknown(data['estadio']!, _estadioMeta));
    } else if (isInserting) {
      context.missing(_estadioMeta);
    }
    if (data.containsKey('titulo')) {
      context.handle(_tituloMeta,
          titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta));
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    }
    if (data.containsKey('foco_manejo')) {
      context.handle(
          _focoManejoMeta,
          focoManejo.isAcceptableOrUnknown(
              data['foco_manejo']!, _focoManejoMeta));
    }
    if (data.containsKey('praticas')) {
      context.handle(_praticasMeta,
          praticas.isAcceptableOrUnknown(data['praticas']!, _praticasMeta));
    }
    if (data.containsKey('padrao')) {
      context.handle(_padraoMeta,
          padrao.isAcceptableOrUnknown(data['padrao']!, _padraoMeta));
    }
    if (data.containsKey('destaque')) {
      context.handle(_destaqueMeta,
          destaque.isAcceptableOrUnknown(data['destaque']!, _destaqueMeta));
    }
    if (data.containsKey('fonte')) {
      context.handle(
          _fonteMeta, fonte.isAcceptableOrUnknown(data['fonte']!, _fonteMeta));
    }
    if (data.containsKey('safra_referencia')) {
      context.handle(
          _safraReferenciaMeta,
          safraReferencia.isAcceptableOrUnknown(
              data['safra_referencia']!, _safraReferenciaMeta));
    }
    if (data.containsKey('data_referencia')) {
      context.handle(
          _dataReferenciaMeta,
          dataReferencia.isAcceptableOrUnknown(
              data['data_referencia']!, _dataReferenciaMeta));
    }
    if (data.containsKey('resultado')) {
      context.handle(_resultadoMeta,
          resultado.isAcceptableOrUnknown(data['resultado']!, _resultadoMeta));
    }
    if (data.containsKey('local')) {
      context.handle(
          _localMeta, local.isAcceptableOrUnknown(data['local']!, _localMeta));
    }
    if (data.containsKey('tipo_fonte')) {
      context.handle(_tipoFonteMeta,
          tipoFonte.isAcceptableOrUnknown(data['tipo_fonte']!, _tipoFonteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  ReferenciasTecnica map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReferenciasTecnica(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      categoria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoria'])!,
      estadio: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estadio'])!,
      titulo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}titulo'])!,
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao']),
      focoManejo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}foco_manejo']),
      praticas: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}praticas']),
      padrao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}padrao']),
      destaque: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}destaque']),
      fonte: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fonte']),
      safraReferencia: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}safra_referencia']),
      dataReferencia: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_referencia']),
      resultado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}resultado']),
      local: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local']),
      tipoFonte: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo_fonte']),
    );
  }

  @override
  $ReferenciasTecnicasTable createAlias(String alias) {
    return $ReferenciasTecnicasTable(attachedDatabase, alias);
  }
}

class ReferenciasTecnica extends DataClass
    implements Insertable<ReferenciasTecnica> {
  final String uid;
  final String categoria;
  final String estadio;
  final String titulo;
  final String? descricao;
  final String? focoManejo;
  final String? praticas;
  final String? padrao;
  final String? destaque;
  final String? fonte;
  final String? safraReferencia;
  final DateTime? dataReferencia;
  final String? resultado;
  final String? local;
  final String? tipoFonte;
  const ReferenciasTecnica(
      {required this.uid,
      required this.categoria,
      required this.estadio,
      required this.titulo,
      this.descricao,
      this.focoManejo,
      this.praticas,
      this.padrao,
      this.destaque,
      this.fonte,
      this.safraReferencia,
      this.dataReferencia,
      this.resultado,
      this.local,
      this.tipoFonte});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['categoria'] = Variable<String>(categoria);
    map['estadio'] = Variable<String>(estadio);
    map['titulo'] = Variable<String>(titulo);
    if (!nullToAbsent || descricao != null) {
      map['descricao'] = Variable<String>(descricao);
    }
    if (!nullToAbsent || focoManejo != null) {
      map['foco_manejo'] = Variable<String>(focoManejo);
    }
    if (!nullToAbsent || praticas != null) {
      map['praticas'] = Variable<String>(praticas);
    }
    if (!nullToAbsent || padrao != null) {
      map['padrao'] = Variable<String>(padrao);
    }
    if (!nullToAbsent || destaque != null) {
      map['destaque'] = Variable<String>(destaque);
    }
    if (!nullToAbsent || fonte != null) {
      map['fonte'] = Variable<String>(fonte);
    }
    if (!nullToAbsent || safraReferencia != null) {
      map['safra_referencia'] = Variable<String>(safraReferencia);
    }
    if (!nullToAbsent || dataReferencia != null) {
      map['data_referencia'] = Variable<DateTime>(dataReferencia);
    }
    if (!nullToAbsent || resultado != null) {
      map['resultado'] = Variable<String>(resultado);
    }
    if (!nullToAbsent || local != null) {
      map['local'] = Variable<String>(local);
    }
    if (!nullToAbsent || tipoFonte != null) {
      map['tipo_fonte'] = Variable<String>(tipoFonte);
    }
    return map;
  }

  ReferenciasTecnicasCompanion toCompanion(bool nullToAbsent) {
    return ReferenciasTecnicasCompanion(
      uid: Value(uid),
      categoria: Value(categoria),
      estadio: Value(estadio),
      titulo: Value(titulo),
      descricao: descricao == null && nullToAbsent
          ? const Value.absent()
          : Value(descricao),
      focoManejo: focoManejo == null && nullToAbsent
          ? const Value.absent()
          : Value(focoManejo),
      praticas: praticas == null && nullToAbsent
          ? const Value.absent()
          : Value(praticas),
      padrao:
          padrao == null && nullToAbsent ? const Value.absent() : Value(padrao),
      destaque: destaque == null && nullToAbsent
          ? const Value.absent()
          : Value(destaque),
      fonte:
          fonte == null && nullToAbsent ? const Value.absent() : Value(fonte),
      safraReferencia: safraReferencia == null && nullToAbsent
          ? const Value.absent()
          : Value(safraReferencia),
      dataReferencia: dataReferencia == null && nullToAbsent
          ? const Value.absent()
          : Value(dataReferencia),
      resultado: resultado == null && nullToAbsent
          ? const Value.absent()
          : Value(resultado),
      local:
          local == null && nullToAbsent ? const Value.absent() : Value(local),
      tipoFonte: tipoFonte == null && nullToAbsent
          ? const Value.absent()
          : Value(tipoFonte),
    );
  }

  factory ReferenciasTecnica.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReferenciasTecnica(
      uid: serializer.fromJson<String>(json['uid']),
      categoria: serializer.fromJson<String>(json['categoria']),
      estadio: serializer.fromJson<String>(json['estadio']),
      titulo: serializer.fromJson<String>(json['titulo']),
      descricao: serializer.fromJson<String?>(json['descricao']),
      focoManejo: serializer.fromJson<String?>(json['focoManejo']),
      praticas: serializer.fromJson<String?>(json['praticas']),
      padrao: serializer.fromJson<String?>(json['padrao']),
      destaque: serializer.fromJson<String?>(json['destaque']),
      fonte: serializer.fromJson<String?>(json['fonte']),
      safraReferencia: serializer.fromJson<String?>(json['safraReferencia']),
      dataReferencia: serializer.fromJson<DateTime?>(json['dataReferencia']),
      resultado: serializer.fromJson<String?>(json['resultado']),
      local: serializer.fromJson<String?>(json['local']),
      tipoFonte: serializer.fromJson<String?>(json['tipoFonte']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'categoria': serializer.toJson<String>(categoria),
      'estadio': serializer.toJson<String>(estadio),
      'titulo': serializer.toJson<String>(titulo),
      'descricao': serializer.toJson<String?>(descricao),
      'focoManejo': serializer.toJson<String?>(focoManejo),
      'praticas': serializer.toJson<String?>(praticas),
      'padrao': serializer.toJson<String?>(padrao),
      'destaque': serializer.toJson<String?>(destaque),
      'fonte': serializer.toJson<String?>(fonte),
      'safraReferencia': serializer.toJson<String?>(safraReferencia),
      'dataReferencia': serializer.toJson<DateTime?>(dataReferencia),
      'resultado': serializer.toJson<String?>(resultado),
      'local': serializer.toJson<String?>(local),
      'tipoFonte': serializer.toJson<String?>(tipoFonte),
    };
  }

  ReferenciasTecnica copyWith(
          {String? uid,
          String? categoria,
          String? estadio,
          String? titulo,
          Value<String?> descricao = const Value.absent(),
          Value<String?> focoManejo = const Value.absent(),
          Value<String?> praticas = const Value.absent(),
          Value<String?> padrao = const Value.absent(),
          Value<String?> destaque = const Value.absent(),
          Value<String?> fonte = const Value.absent(),
          Value<String?> safraReferencia = const Value.absent(),
          Value<DateTime?> dataReferencia = const Value.absent(),
          Value<String?> resultado = const Value.absent(),
          Value<String?> local = const Value.absent(),
          Value<String?> tipoFonte = const Value.absent()}) =>
      ReferenciasTecnica(
        uid: uid ?? this.uid,
        categoria: categoria ?? this.categoria,
        estadio: estadio ?? this.estadio,
        titulo: titulo ?? this.titulo,
        descricao: descricao.present ? descricao.value : this.descricao,
        focoManejo: focoManejo.present ? focoManejo.value : this.focoManejo,
        praticas: praticas.present ? praticas.value : this.praticas,
        padrao: padrao.present ? padrao.value : this.padrao,
        destaque: destaque.present ? destaque.value : this.destaque,
        fonte: fonte.present ? fonte.value : this.fonte,
        safraReferencia: safraReferencia.present
            ? safraReferencia.value
            : this.safraReferencia,
        dataReferencia:
            dataReferencia.present ? dataReferencia.value : this.dataReferencia,
        resultado: resultado.present ? resultado.value : this.resultado,
        local: local.present ? local.value : this.local,
        tipoFonte: tipoFonte.present ? tipoFonte.value : this.tipoFonte,
      );
  ReferenciasTecnica copyWithCompanion(ReferenciasTecnicasCompanion data) {
    return ReferenciasTecnica(
      uid: data.uid.present ? data.uid.value : this.uid,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      estadio: data.estadio.present ? data.estadio.value : this.estadio,
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
      focoManejo:
          data.focoManejo.present ? data.focoManejo.value : this.focoManejo,
      praticas: data.praticas.present ? data.praticas.value : this.praticas,
      padrao: data.padrao.present ? data.padrao.value : this.padrao,
      destaque: data.destaque.present ? data.destaque.value : this.destaque,
      fonte: data.fonte.present ? data.fonte.value : this.fonte,
      safraReferencia: data.safraReferencia.present
          ? data.safraReferencia.value
          : this.safraReferencia,
      dataReferencia: data.dataReferencia.present
          ? data.dataReferencia.value
          : this.dataReferencia,
      resultado: data.resultado.present ? data.resultado.value : this.resultado,
      local: data.local.present ? data.local.value : this.local,
      tipoFonte: data.tipoFonte.present ? data.tipoFonte.value : this.tipoFonte,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReferenciasTecnica(')
          ..write('uid: $uid, ')
          ..write('categoria: $categoria, ')
          ..write('estadio: $estadio, ')
          ..write('titulo: $titulo, ')
          ..write('descricao: $descricao, ')
          ..write('focoManejo: $focoManejo, ')
          ..write('praticas: $praticas, ')
          ..write('padrao: $padrao, ')
          ..write('destaque: $destaque, ')
          ..write('fonte: $fonte, ')
          ..write('safraReferencia: $safraReferencia, ')
          ..write('dataReferencia: $dataReferencia, ')
          ..write('resultado: $resultado, ')
          ..write('local: $local, ')
          ..write('tipoFonte: $tipoFonte')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      uid,
      categoria,
      estadio,
      titulo,
      descricao,
      focoManejo,
      praticas,
      padrao,
      destaque,
      fonte,
      safraReferencia,
      dataReferencia,
      resultado,
      local,
      tipoFonte);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReferenciasTecnica &&
          other.uid == this.uid &&
          other.categoria == this.categoria &&
          other.estadio == this.estadio &&
          other.titulo == this.titulo &&
          other.descricao == this.descricao &&
          other.focoManejo == this.focoManejo &&
          other.praticas == this.praticas &&
          other.padrao == this.padrao &&
          other.destaque == this.destaque &&
          other.fonte == this.fonte &&
          other.safraReferencia == this.safraReferencia &&
          other.dataReferencia == this.dataReferencia &&
          other.resultado == this.resultado &&
          other.local == this.local &&
          other.tipoFonte == this.tipoFonte);
}

class ReferenciasTecnicasCompanion extends UpdateCompanion<ReferenciasTecnica> {
  final Value<String> uid;
  final Value<String> categoria;
  final Value<String> estadio;
  final Value<String> titulo;
  final Value<String?> descricao;
  final Value<String?> focoManejo;
  final Value<String?> praticas;
  final Value<String?> padrao;
  final Value<String?> destaque;
  final Value<String?> fonte;
  final Value<String?> safraReferencia;
  final Value<DateTime?> dataReferencia;
  final Value<String?> resultado;
  final Value<String?> local;
  final Value<String?> tipoFonte;
  final Value<int> rowid;
  const ReferenciasTecnicasCompanion({
    this.uid = const Value.absent(),
    this.categoria = const Value.absent(),
    this.estadio = const Value.absent(),
    this.titulo = const Value.absent(),
    this.descricao = const Value.absent(),
    this.focoManejo = const Value.absent(),
    this.praticas = const Value.absent(),
    this.padrao = const Value.absent(),
    this.destaque = const Value.absent(),
    this.fonte = const Value.absent(),
    this.safraReferencia = const Value.absent(),
    this.dataReferencia = const Value.absent(),
    this.resultado = const Value.absent(),
    this.local = const Value.absent(),
    this.tipoFonte = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReferenciasTecnicasCompanion.insert({
    required String uid,
    required String categoria,
    required String estadio,
    required String titulo,
    this.descricao = const Value.absent(),
    this.focoManejo = const Value.absent(),
    this.praticas = const Value.absent(),
    this.padrao = const Value.absent(),
    this.destaque = const Value.absent(),
    this.fonte = const Value.absent(),
    this.safraReferencia = const Value.absent(),
    this.dataReferencia = const Value.absent(),
    this.resultado = const Value.absent(),
    this.local = const Value.absent(),
    this.tipoFonte = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        categoria = Value(categoria),
        estadio = Value(estadio),
        titulo = Value(titulo);
  static Insertable<ReferenciasTecnica> custom({
    Expression<String>? uid,
    Expression<String>? categoria,
    Expression<String>? estadio,
    Expression<String>? titulo,
    Expression<String>? descricao,
    Expression<String>? focoManejo,
    Expression<String>? praticas,
    Expression<String>? padrao,
    Expression<String>? destaque,
    Expression<String>? fonte,
    Expression<String>? safraReferencia,
    Expression<DateTime>? dataReferencia,
    Expression<String>? resultado,
    Expression<String>? local,
    Expression<String>? tipoFonte,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (categoria != null) 'categoria': categoria,
      if (estadio != null) 'estadio': estadio,
      if (titulo != null) 'titulo': titulo,
      if (descricao != null) 'descricao': descricao,
      if (focoManejo != null) 'foco_manejo': focoManejo,
      if (praticas != null) 'praticas': praticas,
      if (padrao != null) 'padrao': padrao,
      if (destaque != null) 'destaque': destaque,
      if (fonte != null) 'fonte': fonte,
      if (safraReferencia != null) 'safra_referencia': safraReferencia,
      if (dataReferencia != null) 'data_referencia': dataReferencia,
      if (resultado != null) 'resultado': resultado,
      if (local != null) 'local': local,
      if (tipoFonte != null) 'tipo_fonte': tipoFonte,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReferenciasTecnicasCompanion copyWith(
      {Value<String>? uid,
      Value<String>? categoria,
      Value<String>? estadio,
      Value<String>? titulo,
      Value<String?>? descricao,
      Value<String?>? focoManejo,
      Value<String?>? praticas,
      Value<String?>? padrao,
      Value<String?>? destaque,
      Value<String?>? fonte,
      Value<String?>? safraReferencia,
      Value<DateTime?>? dataReferencia,
      Value<String?>? resultado,
      Value<String?>? local,
      Value<String?>? tipoFonte,
      Value<int>? rowid}) {
    return ReferenciasTecnicasCompanion(
      uid: uid ?? this.uid,
      categoria: categoria ?? this.categoria,
      estadio: estadio ?? this.estadio,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      focoManejo: focoManejo ?? this.focoManejo,
      praticas: praticas ?? this.praticas,
      padrao: padrao ?? this.padrao,
      destaque: destaque ?? this.destaque,
      fonte: fonte ?? this.fonte,
      safraReferencia: safraReferencia ?? this.safraReferencia,
      dataReferencia: dataReferencia ?? this.dataReferencia,
      resultado: resultado ?? this.resultado,
      local: local ?? this.local,
      tipoFonte: tipoFonte ?? this.tipoFonte,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (estadio.present) {
      map['estadio'] = Variable<String>(estadio.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    if (focoManejo.present) {
      map['foco_manejo'] = Variable<String>(focoManejo.value);
    }
    if (praticas.present) {
      map['praticas'] = Variable<String>(praticas.value);
    }
    if (padrao.present) {
      map['padrao'] = Variable<String>(padrao.value);
    }
    if (destaque.present) {
      map['destaque'] = Variable<String>(destaque.value);
    }
    if (fonte.present) {
      map['fonte'] = Variable<String>(fonte.value);
    }
    if (safraReferencia.present) {
      map['safra_referencia'] = Variable<String>(safraReferencia.value);
    }
    if (dataReferencia.present) {
      map['data_referencia'] = Variable<DateTime>(dataReferencia.value);
    }
    if (resultado.present) {
      map['resultado'] = Variable<String>(resultado.value);
    }
    if (local.present) {
      map['local'] = Variable<String>(local.value);
    }
    if (tipoFonte.present) {
      map['tipo_fonte'] = Variable<String>(tipoFonte.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReferenciasTecnicasCompanion(')
          ..write('uid: $uid, ')
          ..write('categoria: $categoria, ')
          ..write('estadio: $estadio, ')
          ..write('titulo: $titulo, ')
          ..write('descricao: $descricao, ')
          ..write('focoManejo: $focoManejo, ')
          ..write('praticas: $praticas, ')
          ..write('padrao: $padrao, ')
          ..write('destaque: $destaque, ')
          ..write('fonte: $fonte, ')
          ..write('safraReferencia: $safraReferencia, ')
          ..write('dataReferencia: $dataReferencia, ')
          ..write('resultado: $resultado, ')
          ..write('local: $local, ')
          ..write('tipoFonte: $tipoFonte, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlanosTable extends Planos with TableInfo<$PlanosTable, Plano> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _clienteIdMeta =
      const VerificationMeta('clienteId');
  @override
  late final GeneratedColumn<String> clienteId = GeneratedColumn<String>(
      'cliente_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES clientes (uid)'));
  static const VerificationMeta _fazendaIdMeta =
      const VerificationMeta('fazendaId');
  @override
  late final GeneratedColumn<String> fazendaId = GeneratedColumn<String>(
      'fazenda_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES fazendas (uid)'));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _produtorNomeLivreMeta =
      const VerificationMeta('produtorNomeLivre');
  @override
  late final GeneratedColumn<String> produtorNomeLivre =
      GeneratedColumn<String>('produtor_nome_livre', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fazendaNomeLivreMeta =
      const VerificationMeta('fazendaNomeLivre');
  @override
  late final GeneratedColumn<String> fazendaNomeLivre = GeneratedColumn<String>(
      'fazenda_nome_livre', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cidadeUfMeta =
      const VerificationMeta('cidadeUf');
  @override
  late final GeneratedColumn<String> cidadeUf = GeneratedColumn<String>(
      'cidade_uf', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _consultorNomeMeta =
      const VerificationMeta('consultorNome');
  @override
  late final GeneratedColumn<String> consultorNome = GeneratedColumn<String>(
      'consultor_nome', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _consultorExibirNomeMeta =
      const VerificationMeta('consultorExibirNome');
  @override
  late final GeneratedColumn<bool> consultorExibirNome = GeneratedColumn<bool>(
      'consultor_exibir_nome', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("consultor_exibir_nome" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _logoLocalPathMeta =
      const VerificationMeta('logoLocalPath');
  @override
  late final GeneratedColumn<String> logoLocalPath = GeneratedColumn<String>(
      'logo_local_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _precoGraoSc60Meta =
      const VerificationMeta('precoGraoSc60');
  @override
  late final GeneratedColumn<double> precoGraoSc60 = GeneratedColumn<double>(
      'preco_grao_sc60', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _dataVencimentoMeta =
      const VerificationMeta('dataVencimento');
  @override
  late final GeneratedColumn<DateTime> dataVencimento =
      GeneratedColumn<DateTime>('data_vencimento', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _cultivarNomeMeta =
      const VerificationMeta('cultivarNome');
  @override
  late final GeneratedColumn<String> cultivarNome = GeneratedColumn<String>(
      'cultivar_nome', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cultivarObtentoraMeta =
      const VerificationMeta('cultivarObtentora');
  @override
  late final GeneratedColumn<String> cultivarObtentora =
      GeneratedColumn<String>('cultivar_obtentora', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cultivarGrupoMaturacaoMeta =
      const VerificationMeta('cultivarGrupoMaturacao');
  @override
  late final GeneratedColumn<String> cultivarGrupoMaturacao =
      GeneratedColumn<String>('cultivar_grupo_maturacao', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cultivarPopulacaoMeta =
      const VerificationMeta('cultivarPopulacao');
  @override
  late final GeneratedColumn<double> cultivarPopulacao =
      GeneratedColumn<double>('cultivar_populacao', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _cultivarPopulacaoUnidadeMeta =
      const VerificationMeta('cultivarPopulacaoUnidade');
  @override
  late final GeneratedColumn<String> cultivarPopulacaoUnidade =
      GeneratedColumn<String>('cultivar_populacao_unidade', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('plantas/ha'));
  static const VerificationMeta _cultivarObservacoesMeta =
      const VerificationMeta('cultivarObservacoes');
  @override
  late final GeneratedColumn<String> cultivarObservacoes =
      GeneratedColumn<String>('cultivar_observacoes', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _culturaMeta =
      const VerificationMeta('cultura');
  @override
  late final GeneratedColumn<String> cultura = GeneratedColumn<String>(
      'cultura', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _safraMeta = const VerificationMeta('safra');
  @override
  late final GeneratedColumn<String> safra = GeneratedColumn<String>(
      'safra', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _areaHaTotalMeta =
      const VerificationMeta('areaHaTotal');
  @override
  late final GeneratedColumn<double> areaHaTotal = GeneratedColumn<double>(
      'area_ha_total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        userId,
        clienteId,
        fazendaId,
        nome,
        produtorNomeLivre,
        fazendaNomeLivre,
        cidadeUf,
        consultorNome,
        consultorExibirNome,
        logoLocalPath,
        precoGraoSc60,
        dataVencimento,
        cultivarNome,
        cultivarObtentora,
        cultivarGrupoMaturacao,
        cultivarPopulacao,
        cultivarPopulacaoUnidade,
        cultivarObservacoes,
        cultura,
        safra,
        areaHaTotal,
        status,
        createdAt,
        updatedAt,
        syncState,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'planos';
  @override
  VerificationContext validateIntegrity(Insertable<Plano> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('cliente_id')) {
      context.handle(_clienteIdMeta,
          clienteId.isAcceptableOrUnknown(data['cliente_id']!, _clienteIdMeta));
    }
    if (data.containsKey('fazenda_id')) {
      context.handle(_fazendaIdMeta,
          fazendaId.isAcceptableOrUnknown(data['fazenda_id']!, _fazendaIdMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('produtor_nome_livre')) {
      context.handle(
          _produtorNomeLivreMeta,
          produtorNomeLivre.isAcceptableOrUnknown(
              data['produtor_nome_livre']!, _produtorNomeLivreMeta));
    }
    if (data.containsKey('fazenda_nome_livre')) {
      context.handle(
          _fazendaNomeLivreMeta,
          fazendaNomeLivre.isAcceptableOrUnknown(
              data['fazenda_nome_livre']!, _fazendaNomeLivreMeta));
    }
    if (data.containsKey('cidade_uf')) {
      context.handle(_cidadeUfMeta,
          cidadeUf.isAcceptableOrUnknown(data['cidade_uf']!, _cidadeUfMeta));
    }
    if (data.containsKey('consultor_nome')) {
      context.handle(
          _consultorNomeMeta,
          consultorNome.isAcceptableOrUnknown(
              data['consultor_nome']!, _consultorNomeMeta));
    }
    if (data.containsKey('consultor_exibir_nome')) {
      context.handle(
          _consultorExibirNomeMeta,
          consultorExibirNome.isAcceptableOrUnknown(
              data['consultor_exibir_nome']!, _consultorExibirNomeMeta));
    }
    if (data.containsKey('logo_local_path')) {
      context.handle(
          _logoLocalPathMeta,
          logoLocalPath.isAcceptableOrUnknown(
              data['logo_local_path']!, _logoLocalPathMeta));
    }
    if (data.containsKey('preco_grao_sc60')) {
      context.handle(
          _precoGraoSc60Meta,
          precoGraoSc60.isAcceptableOrUnknown(
              data['preco_grao_sc60']!, _precoGraoSc60Meta));
    }
    if (data.containsKey('data_vencimento')) {
      context.handle(
          _dataVencimentoMeta,
          dataVencimento.isAcceptableOrUnknown(
              data['data_vencimento']!, _dataVencimentoMeta));
    }
    if (data.containsKey('cultivar_nome')) {
      context.handle(
          _cultivarNomeMeta,
          cultivarNome.isAcceptableOrUnknown(
              data['cultivar_nome']!, _cultivarNomeMeta));
    }
    if (data.containsKey('cultivar_obtentora')) {
      context.handle(
          _cultivarObtentoraMeta,
          cultivarObtentora.isAcceptableOrUnknown(
              data['cultivar_obtentora']!, _cultivarObtentoraMeta));
    }
    if (data.containsKey('cultivar_grupo_maturacao')) {
      context.handle(
          _cultivarGrupoMaturacaoMeta,
          cultivarGrupoMaturacao.isAcceptableOrUnknown(
              data['cultivar_grupo_maturacao']!, _cultivarGrupoMaturacaoMeta));
    }
    if (data.containsKey('cultivar_populacao')) {
      context.handle(
          _cultivarPopulacaoMeta,
          cultivarPopulacao.isAcceptableOrUnknown(
              data['cultivar_populacao']!, _cultivarPopulacaoMeta));
    }
    if (data.containsKey('cultivar_populacao_unidade')) {
      context.handle(
          _cultivarPopulacaoUnidadeMeta,
          cultivarPopulacaoUnidade.isAcceptableOrUnknown(
              data['cultivar_populacao_unidade']!,
              _cultivarPopulacaoUnidadeMeta));
    }
    if (data.containsKey('cultivar_observacoes')) {
      context.handle(
          _cultivarObservacoesMeta,
          cultivarObservacoes.isAcceptableOrUnknown(
              data['cultivar_observacoes']!, _cultivarObservacoesMeta));
    }
    if (data.containsKey('cultura')) {
      context.handle(_culturaMeta,
          cultura.isAcceptableOrUnknown(data['cultura']!, _culturaMeta));
    } else if (isInserting) {
      context.missing(_culturaMeta);
    }
    if (data.containsKey('safra')) {
      context.handle(
          _safraMeta, safra.isAcceptableOrUnknown(data['safra']!, _safraMeta));
    } else if (isInserting) {
      context.missing(_safraMeta);
    }
    if (data.containsKey('area_ha_total')) {
      context.handle(
          _areaHaTotalMeta,
          areaHaTotal.isAcceptableOrUnknown(
              data['area_ha_total']!, _areaHaTotalMeta));
    } else if (isInserting) {
      context.missing(_areaHaTotalMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  Plano map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Plano(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      clienteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cliente_id']),
      fazendaId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fazenda_id']),
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      produtorNomeLivre: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}produtor_nome_livre']),
      fazendaNomeLivre: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}fazenda_nome_livre']),
      cidadeUf: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cidade_uf']),
      consultorNome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}consultor_nome']),
      consultorExibirNome: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}consultor_exibir_nome'])!,
      logoLocalPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo_local_path']),
      precoGraoSc60: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}preco_grao_sc60']),
      dataVencimento: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_vencimento']),
      cultivarNome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cultivar_nome']),
      cultivarObtentora: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}cultivar_obtentora']),
      cultivarGrupoMaturacao: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}cultivar_grupo_maturacao']),
      cultivarPopulacao: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}cultivar_populacao']),
      cultivarPopulacaoUnidade: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}cultivar_populacao_unidade'])!,
      cultivarObservacoes: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}cultivar_observacoes']),
      cultura: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cultura'])!,
      safra: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}safra'])!,
      areaHaTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}area_ha_total'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $PlanosTable createAlias(String alias) {
    return $PlanosTable(attachedDatabase, alias);
  }
}

class Plano extends DataClass implements Insertable<Plano> {
  final String uid;
  final String? userId;
  final String? clienteId;
  final String? fazendaId;
  final String nome;
  final String? produtorNomeLivre;
  final String? fazendaNomeLivre;
  final String? cidadeUf;
  final String? consultorNome;
  final bool consultorExibirNome;
  final String? logoLocalPath;
  final double? precoGraoSc60;
  final DateTime? dataVencimento;
  final String? cultivarNome;
  final String? cultivarObtentora;
  final String? cultivarGrupoMaturacao;
  final double? cultivarPopulacao;
  final String cultivarPopulacaoUnidade;
  final String? cultivarObservacoes;
  final String cultura;
  final String safra;
  final double areaHaTotal;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncState;
  final DateTime? deletedAt;
  const Plano(
      {required this.uid,
      this.userId,
      this.clienteId,
      this.fazendaId,
      required this.nome,
      this.produtorNomeLivre,
      this.fazendaNomeLivre,
      this.cidadeUf,
      this.consultorNome,
      required this.consultorExibirNome,
      this.logoLocalPath,
      this.precoGraoSc60,
      this.dataVencimento,
      this.cultivarNome,
      this.cultivarObtentora,
      this.cultivarGrupoMaturacao,
      this.cultivarPopulacao,
      required this.cultivarPopulacaoUnidade,
      this.cultivarObservacoes,
      required this.cultura,
      required this.safra,
      required this.areaHaTotal,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.syncState,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || clienteId != null) {
      map['cliente_id'] = Variable<String>(clienteId);
    }
    if (!nullToAbsent || fazendaId != null) {
      map['fazenda_id'] = Variable<String>(fazendaId);
    }
    map['nome'] = Variable<String>(nome);
    if (!nullToAbsent || produtorNomeLivre != null) {
      map['produtor_nome_livre'] = Variable<String>(produtorNomeLivre);
    }
    if (!nullToAbsent || fazendaNomeLivre != null) {
      map['fazenda_nome_livre'] = Variable<String>(fazendaNomeLivre);
    }
    if (!nullToAbsent || cidadeUf != null) {
      map['cidade_uf'] = Variable<String>(cidadeUf);
    }
    if (!nullToAbsent || consultorNome != null) {
      map['consultor_nome'] = Variable<String>(consultorNome);
    }
    map['consultor_exibir_nome'] = Variable<bool>(consultorExibirNome);
    if (!nullToAbsent || logoLocalPath != null) {
      map['logo_local_path'] = Variable<String>(logoLocalPath);
    }
    if (!nullToAbsent || precoGraoSc60 != null) {
      map['preco_grao_sc60'] = Variable<double>(precoGraoSc60);
    }
    if (!nullToAbsent || dataVencimento != null) {
      map['data_vencimento'] = Variable<DateTime>(dataVencimento);
    }
    if (!nullToAbsent || cultivarNome != null) {
      map['cultivar_nome'] = Variable<String>(cultivarNome);
    }
    if (!nullToAbsent || cultivarObtentora != null) {
      map['cultivar_obtentora'] = Variable<String>(cultivarObtentora);
    }
    if (!nullToAbsent || cultivarGrupoMaturacao != null) {
      map['cultivar_grupo_maturacao'] =
          Variable<String>(cultivarGrupoMaturacao);
    }
    if (!nullToAbsent || cultivarPopulacao != null) {
      map['cultivar_populacao'] = Variable<double>(cultivarPopulacao);
    }
    map['cultivar_populacao_unidade'] =
        Variable<String>(cultivarPopulacaoUnidade);
    if (!nullToAbsent || cultivarObservacoes != null) {
      map['cultivar_observacoes'] = Variable<String>(cultivarObservacoes);
    }
    map['cultura'] = Variable<String>(cultura);
    map['safra'] = Variable<String>(safra);
    map['area_ha_total'] = Variable<double>(areaHaTotal);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  PlanosCompanion toCompanion(bool nullToAbsent) {
    return PlanosCompanion(
      uid: Value(uid),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      clienteId: clienteId == null && nullToAbsent
          ? const Value.absent()
          : Value(clienteId),
      fazendaId: fazendaId == null && nullToAbsent
          ? const Value.absent()
          : Value(fazendaId),
      nome: Value(nome),
      produtorNomeLivre: produtorNomeLivre == null && nullToAbsent
          ? const Value.absent()
          : Value(produtorNomeLivre),
      fazendaNomeLivre: fazendaNomeLivre == null && nullToAbsent
          ? const Value.absent()
          : Value(fazendaNomeLivre),
      cidadeUf: cidadeUf == null && nullToAbsent
          ? const Value.absent()
          : Value(cidadeUf),
      consultorNome: consultorNome == null && nullToAbsent
          ? const Value.absent()
          : Value(consultorNome),
      consultorExibirNome: Value(consultorExibirNome),
      logoLocalPath: logoLocalPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoLocalPath),
      precoGraoSc60: precoGraoSc60 == null && nullToAbsent
          ? const Value.absent()
          : Value(precoGraoSc60),
      dataVencimento: dataVencimento == null && nullToAbsent
          ? const Value.absent()
          : Value(dataVencimento),
      cultivarNome: cultivarNome == null && nullToAbsent
          ? const Value.absent()
          : Value(cultivarNome),
      cultivarObtentora: cultivarObtentora == null && nullToAbsent
          ? const Value.absent()
          : Value(cultivarObtentora),
      cultivarGrupoMaturacao: cultivarGrupoMaturacao == null && nullToAbsent
          ? const Value.absent()
          : Value(cultivarGrupoMaturacao),
      cultivarPopulacao: cultivarPopulacao == null && nullToAbsent
          ? const Value.absent()
          : Value(cultivarPopulacao),
      cultivarPopulacaoUnidade: Value(cultivarPopulacaoUnidade),
      cultivarObservacoes: cultivarObservacoes == null && nullToAbsent
          ? const Value.absent()
          : Value(cultivarObservacoes),
      cultura: Value(cultura),
      safra: Value(safra),
      areaHaTotal: Value(areaHaTotal),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncState: Value(syncState),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Plano.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Plano(
      uid: serializer.fromJson<String>(json['uid']),
      userId: serializer.fromJson<String?>(json['userId']),
      clienteId: serializer.fromJson<String?>(json['clienteId']),
      fazendaId: serializer.fromJson<String?>(json['fazendaId']),
      nome: serializer.fromJson<String>(json['nome']),
      produtorNomeLivre:
          serializer.fromJson<String?>(json['produtorNomeLivre']),
      fazendaNomeLivre: serializer.fromJson<String?>(json['fazendaNomeLivre']),
      cidadeUf: serializer.fromJson<String?>(json['cidadeUf']),
      consultorNome: serializer.fromJson<String?>(json['consultorNome']),
      consultorExibirNome:
          serializer.fromJson<bool>(json['consultorExibirNome']),
      logoLocalPath: serializer.fromJson<String?>(json['logoLocalPath']),
      precoGraoSc60: serializer.fromJson<double?>(json['precoGraoSc60']),
      dataVencimento: serializer.fromJson<DateTime?>(json['dataVencimento']),
      cultivarNome: serializer.fromJson<String?>(json['cultivarNome']),
      cultivarObtentora:
          serializer.fromJson<String?>(json['cultivarObtentora']),
      cultivarGrupoMaturacao:
          serializer.fromJson<String?>(json['cultivarGrupoMaturacao']),
      cultivarPopulacao:
          serializer.fromJson<double?>(json['cultivarPopulacao']),
      cultivarPopulacaoUnidade:
          serializer.fromJson<String>(json['cultivarPopulacaoUnidade']),
      cultivarObservacoes:
          serializer.fromJson<String?>(json['cultivarObservacoes']),
      cultura: serializer.fromJson<String>(json['cultura']),
      safra: serializer.fromJson<String>(json['safra']),
      areaHaTotal: serializer.fromJson<double>(json['areaHaTotal']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'userId': serializer.toJson<String?>(userId),
      'clienteId': serializer.toJson<String?>(clienteId),
      'fazendaId': serializer.toJson<String?>(fazendaId),
      'nome': serializer.toJson<String>(nome),
      'produtorNomeLivre': serializer.toJson<String?>(produtorNomeLivre),
      'fazendaNomeLivre': serializer.toJson<String?>(fazendaNomeLivre),
      'cidadeUf': serializer.toJson<String?>(cidadeUf),
      'consultorNome': serializer.toJson<String?>(consultorNome),
      'consultorExibirNome': serializer.toJson<bool>(consultorExibirNome),
      'logoLocalPath': serializer.toJson<String?>(logoLocalPath),
      'precoGraoSc60': serializer.toJson<double?>(precoGraoSc60),
      'dataVencimento': serializer.toJson<DateTime?>(dataVencimento),
      'cultivarNome': serializer.toJson<String?>(cultivarNome),
      'cultivarObtentora': serializer.toJson<String?>(cultivarObtentora),
      'cultivarGrupoMaturacao':
          serializer.toJson<String?>(cultivarGrupoMaturacao),
      'cultivarPopulacao': serializer.toJson<double?>(cultivarPopulacao),
      'cultivarPopulacaoUnidade':
          serializer.toJson<String>(cultivarPopulacaoUnidade),
      'cultivarObservacoes': serializer.toJson<String?>(cultivarObservacoes),
      'cultura': serializer.toJson<String>(cultura),
      'safra': serializer.toJson<String>(safra),
      'areaHaTotal': serializer.toJson<double>(areaHaTotal),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncState': serializer.toJson<String>(syncState),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Plano copyWith(
          {String? uid,
          Value<String?> userId = const Value.absent(),
          Value<String?> clienteId = const Value.absent(),
          Value<String?> fazendaId = const Value.absent(),
          String? nome,
          Value<String?> produtorNomeLivre = const Value.absent(),
          Value<String?> fazendaNomeLivre = const Value.absent(),
          Value<String?> cidadeUf = const Value.absent(),
          Value<String?> consultorNome = const Value.absent(),
          bool? consultorExibirNome,
          Value<String?> logoLocalPath = const Value.absent(),
          Value<double?> precoGraoSc60 = const Value.absent(),
          Value<DateTime?> dataVencimento = const Value.absent(),
          Value<String?> cultivarNome = const Value.absent(),
          Value<String?> cultivarObtentora = const Value.absent(),
          Value<String?> cultivarGrupoMaturacao = const Value.absent(),
          Value<double?> cultivarPopulacao = const Value.absent(),
          String? cultivarPopulacaoUnidade,
          Value<String?> cultivarObservacoes = const Value.absent(),
          String? cultura,
          String? safra,
          double? areaHaTotal,
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncState,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      Plano(
        uid: uid ?? this.uid,
        userId: userId.present ? userId.value : this.userId,
        clienteId: clienteId.present ? clienteId.value : this.clienteId,
        fazendaId: fazendaId.present ? fazendaId.value : this.fazendaId,
        nome: nome ?? this.nome,
        produtorNomeLivre: produtorNomeLivre.present
            ? produtorNomeLivre.value
            : this.produtorNomeLivre,
        fazendaNomeLivre: fazendaNomeLivre.present
            ? fazendaNomeLivre.value
            : this.fazendaNomeLivre,
        cidadeUf: cidadeUf.present ? cidadeUf.value : this.cidadeUf,
        consultorNome:
            consultorNome.present ? consultorNome.value : this.consultorNome,
        consultorExibirNome: consultorExibirNome ?? this.consultorExibirNome,
        logoLocalPath:
            logoLocalPath.present ? logoLocalPath.value : this.logoLocalPath,
        precoGraoSc60:
            precoGraoSc60.present ? precoGraoSc60.value : this.precoGraoSc60,
        dataVencimento:
            dataVencimento.present ? dataVencimento.value : this.dataVencimento,
        cultivarNome:
            cultivarNome.present ? cultivarNome.value : this.cultivarNome,
        cultivarObtentora: cultivarObtentora.present
            ? cultivarObtentora.value
            : this.cultivarObtentora,
        cultivarGrupoMaturacao: cultivarGrupoMaturacao.present
            ? cultivarGrupoMaturacao.value
            : this.cultivarGrupoMaturacao,
        cultivarPopulacao: cultivarPopulacao.present
            ? cultivarPopulacao.value
            : this.cultivarPopulacao,
        cultivarPopulacaoUnidade:
            cultivarPopulacaoUnidade ?? this.cultivarPopulacaoUnidade,
        cultivarObservacoes: cultivarObservacoes.present
            ? cultivarObservacoes.value
            : this.cultivarObservacoes,
        cultura: cultura ?? this.cultura,
        safra: safra ?? this.safra,
        areaHaTotal: areaHaTotal ?? this.areaHaTotal,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncState: syncState ?? this.syncState,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  Plano copyWithCompanion(PlanosCompanion data) {
    return Plano(
      uid: data.uid.present ? data.uid.value : this.uid,
      userId: data.userId.present ? data.userId.value : this.userId,
      clienteId: data.clienteId.present ? data.clienteId.value : this.clienteId,
      fazendaId: data.fazendaId.present ? data.fazendaId.value : this.fazendaId,
      nome: data.nome.present ? data.nome.value : this.nome,
      produtorNomeLivre: data.produtorNomeLivre.present
          ? data.produtorNomeLivre.value
          : this.produtorNomeLivre,
      fazendaNomeLivre: data.fazendaNomeLivre.present
          ? data.fazendaNomeLivre.value
          : this.fazendaNomeLivre,
      cidadeUf: data.cidadeUf.present ? data.cidadeUf.value : this.cidadeUf,
      consultorNome: data.consultorNome.present
          ? data.consultorNome.value
          : this.consultorNome,
      consultorExibirNome: data.consultorExibirNome.present
          ? data.consultorExibirNome.value
          : this.consultorExibirNome,
      logoLocalPath: data.logoLocalPath.present
          ? data.logoLocalPath.value
          : this.logoLocalPath,
      precoGraoSc60: data.precoGraoSc60.present
          ? data.precoGraoSc60.value
          : this.precoGraoSc60,
      dataVencimento: data.dataVencimento.present
          ? data.dataVencimento.value
          : this.dataVencimento,
      cultivarNome: data.cultivarNome.present
          ? data.cultivarNome.value
          : this.cultivarNome,
      cultivarObtentora: data.cultivarObtentora.present
          ? data.cultivarObtentora.value
          : this.cultivarObtentora,
      cultivarGrupoMaturacao: data.cultivarGrupoMaturacao.present
          ? data.cultivarGrupoMaturacao.value
          : this.cultivarGrupoMaturacao,
      cultivarPopulacao: data.cultivarPopulacao.present
          ? data.cultivarPopulacao.value
          : this.cultivarPopulacao,
      cultivarPopulacaoUnidade: data.cultivarPopulacaoUnidade.present
          ? data.cultivarPopulacaoUnidade.value
          : this.cultivarPopulacaoUnidade,
      cultivarObservacoes: data.cultivarObservacoes.present
          ? data.cultivarObservacoes.value
          : this.cultivarObservacoes,
      cultura: data.cultura.present ? data.cultura.value : this.cultura,
      safra: data.safra.present ? data.safra.value : this.safra,
      areaHaTotal:
          data.areaHaTotal.present ? data.areaHaTotal.value : this.areaHaTotal,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Plano(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('clienteId: $clienteId, ')
          ..write('fazendaId: $fazendaId, ')
          ..write('nome: $nome, ')
          ..write('produtorNomeLivre: $produtorNomeLivre, ')
          ..write('fazendaNomeLivre: $fazendaNomeLivre, ')
          ..write('cidadeUf: $cidadeUf, ')
          ..write('consultorNome: $consultorNome, ')
          ..write('consultorExibirNome: $consultorExibirNome, ')
          ..write('logoLocalPath: $logoLocalPath, ')
          ..write('precoGraoSc60: $precoGraoSc60, ')
          ..write('dataVencimento: $dataVencimento, ')
          ..write('cultivarNome: $cultivarNome, ')
          ..write('cultivarObtentora: $cultivarObtentora, ')
          ..write('cultivarGrupoMaturacao: $cultivarGrupoMaturacao, ')
          ..write('cultivarPopulacao: $cultivarPopulacao, ')
          ..write('cultivarPopulacaoUnidade: $cultivarPopulacaoUnidade, ')
          ..write('cultivarObservacoes: $cultivarObservacoes, ')
          ..write('cultura: $cultura, ')
          ..write('safra: $safra, ')
          ..write('areaHaTotal: $areaHaTotal, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        uid,
        userId,
        clienteId,
        fazendaId,
        nome,
        produtorNomeLivre,
        fazendaNomeLivre,
        cidadeUf,
        consultorNome,
        consultorExibirNome,
        logoLocalPath,
        precoGraoSc60,
        dataVencimento,
        cultivarNome,
        cultivarObtentora,
        cultivarGrupoMaturacao,
        cultivarPopulacao,
        cultivarPopulacaoUnidade,
        cultivarObservacoes,
        cultura,
        safra,
        areaHaTotal,
        status,
        createdAt,
        updatedAt,
        syncState,
        deletedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Plano &&
          other.uid == this.uid &&
          other.userId == this.userId &&
          other.clienteId == this.clienteId &&
          other.fazendaId == this.fazendaId &&
          other.nome == this.nome &&
          other.produtorNomeLivre == this.produtorNomeLivre &&
          other.fazendaNomeLivre == this.fazendaNomeLivre &&
          other.cidadeUf == this.cidadeUf &&
          other.consultorNome == this.consultorNome &&
          other.consultorExibirNome == this.consultorExibirNome &&
          other.logoLocalPath == this.logoLocalPath &&
          other.precoGraoSc60 == this.precoGraoSc60 &&
          other.dataVencimento == this.dataVencimento &&
          other.cultivarNome == this.cultivarNome &&
          other.cultivarObtentora == this.cultivarObtentora &&
          other.cultivarGrupoMaturacao == this.cultivarGrupoMaturacao &&
          other.cultivarPopulacao == this.cultivarPopulacao &&
          other.cultivarPopulacaoUnidade == this.cultivarPopulacaoUnidade &&
          other.cultivarObservacoes == this.cultivarObservacoes &&
          other.cultura == this.cultura &&
          other.safra == this.safra &&
          other.areaHaTotal == this.areaHaTotal &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncState == this.syncState &&
          other.deletedAt == this.deletedAt);
}

class PlanosCompanion extends UpdateCompanion<Plano> {
  final Value<String> uid;
  final Value<String?> userId;
  final Value<String?> clienteId;
  final Value<String?> fazendaId;
  final Value<String> nome;
  final Value<String?> produtorNomeLivre;
  final Value<String?> fazendaNomeLivre;
  final Value<String?> cidadeUf;
  final Value<String?> consultorNome;
  final Value<bool> consultorExibirNome;
  final Value<String?> logoLocalPath;
  final Value<double?> precoGraoSc60;
  final Value<DateTime?> dataVencimento;
  final Value<String?> cultivarNome;
  final Value<String?> cultivarObtentora;
  final Value<String?> cultivarGrupoMaturacao;
  final Value<double?> cultivarPopulacao;
  final Value<String> cultivarPopulacaoUnidade;
  final Value<String?> cultivarObservacoes;
  final Value<String> cultura;
  final Value<String> safra;
  final Value<double> areaHaTotal;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncState;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const PlanosCompanion({
    this.uid = const Value.absent(),
    this.userId = const Value.absent(),
    this.clienteId = const Value.absent(),
    this.fazendaId = const Value.absent(),
    this.nome = const Value.absent(),
    this.produtorNomeLivre = const Value.absent(),
    this.fazendaNomeLivre = const Value.absent(),
    this.cidadeUf = const Value.absent(),
    this.consultorNome = const Value.absent(),
    this.consultorExibirNome = const Value.absent(),
    this.logoLocalPath = const Value.absent(),
    this.precoGraoSc60 = const Value.absent(),
    this.dataVencimento = const Value.absent(),
    this.cultivarNome = const Value.absent(),
    this.cultivarObtentora = const Value.absent(),
    this.cultivarGrupoMaturacao = const Value.absent(),
    this.cultivarPopulacao = const Value.absent(),
    this.cultivarPopulacaoUnidade = const Value.absent(),
    this.cultivarObservacoes = const Value.absent(),
    this.cultura = const Value.absent(),
    this.safra = const Value.absent(),
    this.areaHaTotal = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlanosCompanion.insert({
    required String uid,
    this.userId = const Value.absent(),
    this.clienteId = const Value.absent(),
    this.fazendaId = const Value.absent(),
    required String nome,
    this.produtorNomeLivre = const Value.absent(),
    this.fazendaNomeLivre = const Value.absent(),
    this.cidadeUf = const Value.absent(),
    this.consultorNome = const Value.absent(),
    this.consultorExibirNome = const Value.absent(),
    this.logoLocalPath = const Value.absent(),
    this.precoGraoSc60 = const Value.absent(),
    this.dataVencimento = const Value.absent(),
    this.cultivarNome = const Value.absent(),
    this.cultivarObtentora = const Value.absent(),
    this.cultivarGrupoMaturacao = const Value.absent(),
    this.cultivarPopulacao = const Value.absent(),
    this.cultivarPopulacaoUnidade = const Value.absent(),
    this.cultivarObservacoes = const Value.absent(),
    required String cultura,
    required String safra,
    required double areaHaTotal,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        nome = Value(nome),
        cultura = Value(cultura),
        safra = Value(safra),
        areaHaTotal = Value(areaHaTotal),
        status = Value(status),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Plano> custom({
    Expression<String>? uid,
    Expression<String>? userId,
    Expression<String>? clienteId,
    Expression<String>? fazendaId,
    Expression<String>? nome,
    Expression<String>? produtorNomeLivre,
    Expression<String>? fazendaNomeLivre,
    Expression<String>? cidadeUf,
    Expression<String>? consultorNome,
    Expression<bool>? consultorExibirNome,
    Expression<String>? logoLocalPath,
    Expression<double>? precoGraoSc60,
    Expression<DateTime>? dataVencimento,
    Expression<String>? cultivarNome,
    Expression<String>? cultivarObtentora,
    Expression<String>? cultivarGrupoMaturacao,
    Expression<double>? cultivarPopulacao,
    Expression<String>? cultivarPopulacaoUnidade,
    Expression<String>? cultivarObservacoes,
    Expression<String>? cultura,
    Expression<String>? safra,
    Expression<double>? areaHaTotal,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncState,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (userId != null) 'user_id': userId,
      if (clienteId != null) 'cliente_id': clienteId,
      if (fazendaId != null) 'fazenda_id': fazendaId,
      if (nome != null) 'nome': nome,
      if (produtorNomeLivre != null) 'produtor_nome_livre': produtorNomeLivre,
      if (fazendaNomeLivre != null) 'fazenda_nome_livre': fazendaNomeLivre,
      if (cidadeUf != null) 'cidade_uf': cidadeUf,
      if (consultorNome != null) 'consultor_nome': consultorNome,
      if (consultorExibirNome != null)
        'consultor_exibir_nome': consultorExibirNome,
      if (logoLocalPath != null) 'logo_local_path': logoLocalPath,
      if (precoGraoSc60 != null) 'preco_grao_sc60': precoGraoSc60,
      if (dataVencimento != null) 'data_vencimento': dataVencimento,
      if (cultivarNome != null) 'cultivar_nome': cultivarNome,
      if (cultivarObtentora != null) 'cultivar_obtentora': cultivarObtentora,
      if (cultivarGrupoMaturacao != null)
        'cultivar_grupo_maturacao': cultivarGrupoMaturacao,
      if (cultivarPopulacao != null) 'cultivar_populacao': cultivarPopulacao,
      if (cultivarPopulacaoUnidade != null)
        'cultivar_populacao_unidade': cultivarPopulacaoUnidade,
      if (cultivarObservacoes != null)
        'cultivar_observacoes': cultivarObservacoes,
      if (cultura != null) 'cultura': cultura,
      if (safra != null) 'safra': safra,
      if (areaHaTotal != null) 'area_ha_total': areaHaTotal,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncState != null) 'sync_state': syncState,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlanosCompanion copyWith(
      {Value<String>? uid,
      Value<String?>? userId,
      Value<String?>? clienteId,
      Value<String?>? fazendaId,
      Value<String>? nome,
      Value<String?>? produtorNomeLivre,
      Value<String?>? fazendaNomeLivre,
      Value<String?>? cidadeUf,
      Value<String?>? consultorNome,
      Value<bool>? consultorExibirNome,
      Value<String?>? logoLocalPath,
      Value<double?>? precoGraoSc60,
      Value<DateTime?>? dataVencimento,
      Value<String?>? cultivarNome,
      Value<String?>? cultivarObtentora,
      Value<String?>? cultivarGrupoMaturacao,
      Value<double?>? cultivarPopulacao,
      Value<String>? cultivarPopulacaoUnidade,
      Value<String?>? cultivarObservacoes,
      Value<String>? cultura,
      Value<String>? safra,
      Value<double>? areaHaTotal,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncState,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return PlanosCompanion(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      clienteId: clienteId ?? this.clienteId,
      fazendaId: fazendaId ?? this.fazendaId,
      nome: nome ?? this.nome,
      produtorNomeLivre: produtorNomeLivre ?? this.produtorNomeLivre,
      fazendaNomeLivre: fazendaNomeLivre ?? this.fazendaNomeLivre,
      cidadeUf: cidadeUf ?? this.cidadeUf,
      consultorNome: consultorNome ?? this.consultorNome,
      consultorExibirNome: consultorExibirNome ?? this.consultorExibirNome,
      logoLocalPath: logoLocalPath ?? this.logoLocalPath,
      precoGraoSc60: precoGraoSc60 ?? this.precoGraoSc60,
      dataVencimento: dataVencimento ?? this.dataVencimento,
      cultivarNome: cultivarNome ?? this.cultivarNome,
      cultivarObtentora: cultivarObtentora ?? this.cultivarObtentora,
      cultivarGrupoMaturacao:
          cultivarGrupoMaturacao ?? this.cultivarGrupoMaturacao,
      cultivarPopulacao: cultivarPopulacao ?? this.cultivarPopulacao,
      cultivarPopulacaoUnidade:
          cultivarPopulacaoUnidade ?? this.cultivarPopulacaoUnidade,
      cultivarObservacoes: cultivarObservacoes ?? this.cultivarObservacoes,
      cultura: cultura ?? this.cultura,
      safra: safra ?? this.safra,
      areaHaTotal: areaHaTotal ?? this.areaHaTotal,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncState: syncState ?? this.syncState,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (clienteId.present) {
      map['cliente_id'] = Variable<String>(clienteId.value);
    }
    if (fazendaId.present) {
      map['fazenda_id'] = Variable<String>(fazendaId.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (produtorNomeLivre.present) {
      map['produtor_nome_livre'] = Variable<String>(produtorNomeLivre.value);
    }
    if (fazendaNomeLivre.present) {
      map['fazenda_nome_livre'] = Variable<String>(fazendaNomeLivre.value);
    }
    if (cidadeUf.present) {
      map['cidade_uf'] = Variable<String>(cidadeUf.value);
    }
    if (consultorNome.present) {
      map['consultor_nome'] = Variable<String>(consultorNome.value);
    }
    if (consultorExibirNome.present) {
      map['consultor_exibir_nome'] = Variable<bool>(consultorExibirNome.value);
    }
    if (logoLocalPath.present) {
      map['logo_local_path'] = Variable<String>(logoLocalPath.value);
    }
    if (precoGraoSc60.present) {
      map['preco_grao_sc60'] = Variable<double>(precoGraoSc60.value);
    }
    if (dataVencimento.present) {
      map['data_vencimento'] = Variable<DateTime>(dataVencimento.value);
    }
    if (cultivarNome.present) {
      map['cultivar_nome'] = Variable<String>(cultivarNome.value);
    }
    if (cultivarObtentora.present) {
      map['cultivar_obtentora'] = Variable<String>(cultivarObtentora.value);
    }
    if (cultivarGrupoMaturacao.present) {
      map['cultivar_grupo_maturacao'] =
          Variable<String>(cultivarGrupoMaturacao.value);
    }
    if (cultivarPopulacao.present) {
      map['cultivar_populacao'] = Variable<double>(cultivarPopulacao.value);
    }
    if (cultivarPopulacaoUnidade.present) {
      map['cultivar_populacao_unidade'] =
          Variable<String>(cultivarPopulacaoUnidade.value);
    }
    if (cultivarObservacoes.present) {
      map['cultivar_observacoes'] = Variable<String>(cultivarObservacoes.value);
    }
    if (cultura.present) {
      map['cultura'] = Variable<String>(cultura.value);
    }
    if (safra.present) {
      map['safra'] = Variable<String>(safra.value);
    }
    if (areaHaTotal.present) {
      map['area_ha_total'] = Variable<double>(areaHaTotal.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanosCompanion(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('clienteId: $clienteId, ')
          ..write('fazendaId: $fazendaId, ')
          ..write('nome: $nome, ')
          ..write('produtorNomeLivre: $produtorNomeLivre, ')
          ..write('fazendaNomeLivre: $fazendaNomeLivre, ')
          ..write('cidadeUf: $cidadeUf, ')
          ..write('consultorNome: $consultorNome, ')
          ..write('consultorExibirNome: $consultorExibirNome, ')
          ..write('logoLocalPath: $logoLocalPath, ')
          ..write('precoGraoSc60: $precoGraoSc60, ')
          ..write('dataVencimento: $dataVencimento, ')
          ..write('cultivarNome: $cultivarNome, ')
          ..write('cultivarObtentora: $cultivarObtentora, ')
          ..write('cultivarGrupoMaturacao: $cultivarGrupoMaturacao, ')
          ..write('cultivarPopulacao: $cultivarPopulacao, ')
          ..write('cultivarPopulacaoUnidade: $cultivarPopulacaoUnidade, ')
          ..write('cultivarObservacoes: $cultivarObservacoes, ')
          ..write('cultura: $cultura, ')
          ..write('safra: $safra, ')
          ..write('areaHaTotal: $areaHaTotal, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EstadiosTable extends Estadios with TableInfo<$EstadiosTable, Estadio> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EstadiosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _planoIdMeta =
      const VerificationMeta('planoId');
  @override
  late final GeneratedColumn<String> planoId = GeneratedColumn<String>(
      'plano_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES planos (uid) ON DELETE CASCADE'));
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('fenologico'));
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ordemMeta = const VerificationMeta('ordem');
  @override
  late final GeneratedColumn<int> ordem = GeneratedColumn<int>(
      'ordem', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _dataAplicacaoMeta =
      const VerificationMeta('dataAplicacao');
  @override
  late final GeneratedColumn<DateTime> dataAplicacao =
      GeneratedColumn<DateTime>('data_aplicacao', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _imageLocalPathMeta =
      const VerificationMeta('imageLocalPath');
  @override
  late final GeneratedColumn<String> imageLocalPath = GeneratedColumn<String>(
      'image_local_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _observacaoMeta =
      const VerificationMeta('observacao');
  @override
  late final GeneratedColumn<String> observacao = GeneratedColumn<String>(
      'observacao', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tipoOperacionalMeta =
      const VerificationMeta('tipoOperacional');
  @override
  late final GeneratedColumn<String> tipoOperacional = GeneratedColumn<String>(
      'tipo_operacional', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _operacionalConfigMeta =
      const VerificationMeta('operacionalConfig');
  @override
  late final GeneratedColumn<String> operacionalConfig =
      GeneratedColumn<String>('operacional_config', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        userId,
        planoId,
        codigo,
        tipo,
        label,
        ordem,
        dataAplicacao,
        imageLocalPath,
        observacao,
        tipoOperacional,
        operacionalConfig,
        createdAt,
        updatedAt,
        syncState,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'estadios';
  @override
  VerificationContext validateIntegrity(Insertable<Estadio> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('plano_id')) {
      context.handle(_planoIdMeta,
          planoId.isAcceptableOrUnknown(data['plano_id']!, _planoIdMeta));
    } else if (isInserting) {
      context.missing(_planoIdMeta);
    }
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('ordem')) {
      context.handle(
          _ordemMeta, ordem.isAcceptableOrUnknown(data['ordem']!, _ordemMeta));
    }
    if (data.containsKey('data_aplicacao')) {
      context.handle(
          _dataAplicacaoMeta,
          dataAplicacao.isAcceptableOrUnknown(
              data['data_aplicacao']!, _dataAplicacaoMeta));
    }
    if (data.containsKey('image_local_path')) {
      context.handle(
          _imageLocalPathMeta,
          imageLocalPath.isAcceptableOrUnknown(
              data['image_local_path']!, _imageLocalPathMeta));
    }
    if (data.containsKey('observacao')) {
      context.handle(
          _observacaoMeta,
          observacao.isAcceptableOrUnknown(
              data['observacao']!, _observacaoMeta));
    }
    if (data.containsKey('tipo_operacional')) {
      context.handle(
          _tipoOperacionalMeta,
          tipoOperacional.isAcceptableOrUnknown(
              data['tipo_operacional']!, _tipoOperacionalMeta));
    }
    if (data.containsKey('operacional_config')) {
      context.handle(
          _operacionalConfigMeta,
          operacionalConfig.isAcceptableOrUnknown(
              data['operacional_config']!, _operacionalConfigMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  Estadio map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Estadio(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      planoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plano_id'])!,
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo'])!,
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      ordem: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordem'])!,
      dataAplicacao: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_aplicacao']),
      imageLocalPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}image_local_path']),
      observacao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacao']),
      tipoOperacional: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}tipo_operacional']),
      operacionalConfig: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}operacional_config']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $EstadiosTable createAlias(String alias) {
    return $EstadiosTable(attachedDatabase, alias);
  }
}

class Estadio extends DataClass implements Insertable<Estadio> {
  final String uid;
  final String? userId;
  final String planoId;
  final String codigo;
  final String tipo;
  final String label;
  final int ordem;
  final DateTime? dataAplicacao;
  final String? imageLocalPath;
  final String? observacao;
  final String? tipoOperacional;
  final String? operacionalConfig;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncState;
  final DateTime? deletedAt;
  const Estadio(
      {required this.uid,
      this.userId,
      required this.planoId,
      required this.codigo,
      required this.tipo,
      required this.label,
      required this.ordem,
      this.dataAplicacao,
      this.imageLocalPath,
      this.observacao,
      this.tipoOperacional,
      this.operacionalConfig,
      required this.createdAt,
      required this.updatedAt,
      required this.syncState,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['plano_id'] = Variable<String>(planoId);
    map['codigo'] = Variable<String>(codigo);
    map['tipo'] = Variable<String>(tipo);
    map['label'] = Variable<String>(label);
    map['ordem'] = Variable<int>(ordem);
    if (!nullToAbsent || dataAplicacao != null) {
      map['data_aplicacao'] = Variable<DateTime>(dataAplicacao);
    }
    if (!nullToAbsent || imageLocalPath != null) {
      map['image_local_path'] = Variable<String>(imageLocalPath);
    }
    if (!nullToAbsent || observacao != null) {
      map['observacao'] = Variable<String>(observacao);
    }
    if (!nullToAbsent || tipoOperacional != null) {
      map['tipo_operacional'] = Variable<String>(tipoOperacional);
    }
    if (!nullToAbsent || operacionalConfig != null) {
      map['operacional_config'] = Variable<String>(operacionalConfig);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  EstadiosCompanion toCompanion(bool nullToAbsent) {
    return EstadiosCompanion(
      uid: Value(uid),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      planoId: Value(planoId),
      codigo: Value(codigo),
      tipo: Value(tipo),
      label: Value(label),
      ordem: Value(ordem),
      dataAplicacao: dataAplicacao == null && nullToAbsent
          ? const Value.absent()
          : Value(dataAplicacao),
      imageLocalPath: imageLocalPath == null && nullToAbsent
          ? const Value.absent()
          : Value(imageLocalPath),
      observacao: observacao == null && nullToAbsent
          ? const Value.absent()
          : Value(observacao),
      tipoOperacional: tipoOperacional == null && nullToAbsent
          ? const Value.absent()
          : Value(tipoOperacional),
      operacionalConfig: operacionalConfig == null && nullToAbsent
          ? const Value.absent()
          : Value(operacionalConfig),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncState: Value(syncState),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Estadio.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Estadio(
      uid: serializer.fromJson<String>(json['uid']),
      userId: serializer.fromJson<String?>(json['userId']),
      planoId: serializer.fromJson<String>(json['planoId']),
      codigo: serializer.fromJson<String>(json['codigo']),
      tipo: serializer.fromJson<String>(json['tipo']),
      label: serializer.fromJson<String>(json['label']),
      ordem: serializer.fromJson<int>(json['ordem']),
      dataAplicacao: serializer.fromJson<DateTime?>(json['dataAplicacao']),
      imageLocalPath: serializer.fromJson<String?>(json['imageLocalPath']),
      observacao: serializer.fromJson<String?>(json['observacao']),
      tipoOperacional: serializer.fromJson<String?>(json['tipoOperacional']),
      operacionalConfig:
          serializer.fromJson<String?>(json['operacionalConfig']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'userId': serializer.toJson<String?>(userId),
      'planoId': serializer.toJson<String>(planoId),
      'codigo': serializer.toJson<String>(codigo),
      'tipo': serializer.toJson<String>(tipo),
      'label': serializer.toJson<String>(label),
      'ordem': serializer.toJson<int>(ordem),
      'dataAplicacao': serializer.toJson<DateTime?>(dataAplicacao),
      'imageLocalPath': serializer.toJson<String?>(imageLocalPath),
      'observacao': serializer.toJson<String?>(observacao),
      'tipoOperacional': serializer.toJson<String?>(tipoOperacional),
      'operacionalConfig': serializer.toJson<String?>(operacionalConfig),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncState': serializer.toJson<String>(syncState),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Estadio copyWith(
          {String? uid,
          Value<String?> userId = const Value.absent(),
          String? planoId,
          String? codigo,
          String? tipo,
          String? label,
          int? ordem,
          Value<DateTime?> dataAplicacao = const Value.absent(),
          Value<String?> imageLocalPath = const Value.absent(),
          Value<String?> observacao = const Value.absent(),
          Value<String?> tipoOperacional = const Value.absent(),
          Value<String?> operacionalConfig = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncState,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      Estadio(
        uid: uid ?? this.uid,
        userId: userId.present ? userId.value : this.userId,
        planoId: planoId ?? this.planoId,
        codigo: codigo ?? this.codigo,
        tipo: tipo ?? this.tipo,
        label: label ?? this.label,
        ordem: ordem ?? this.ordem,
        dataAplicacao:
            dataAplicacao.present ? dataAplicacao.value : this.dataAplicacao,
        imageLocalPath:
            imageLocalPath.present ? imageLocalPath.value : this.imageLocalPath,
        observacao: observacao.present ? observacao.value : this.observacao,
        tipoOperacional: tipoOperacional.present
            ? tipoOperacional.value
            : this.tipoOperacional,
        operacionalConfig: operacionalConfig.present
            ? operacionalConfig.value
            : this.operacionalConfig,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncState: syncState ?? this.syncState,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  Estadio copyWithCompanion(EstadiosCompanion data) {
    return Estadio(
      uid: data.uid.present ? data.uid.value : this.uid,
      userId: data.userId.present ? data.userId.value : this.userId,
      planoId: data.planoId.present ? data.planoId.value : this.planoId,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      label: data.label.present ? data.label.value : this.label,
      ordem: data.ordem.present ? data.ordem.value : this.ordem,
      dataAplicacao: data.dataAplicacao.present
          ? data.dataAplicacao.value
          : this.dataAplicacao,
      imageLocalPath: data.imageLocalPath.present
          ? data.imageLocalPath.value
          : this.imageLocalPath,
      observacao:
          data.observacao.present ? data.observacao.value : this.observacao,
      tipoOperacional: data.tipoOperacional.present
          ? data.tipoOperacional.value
          : this.tipoOperacional,
      operacionalConfig: data.operacionalConfig.present
          ? data.operacionalConfig.value
          : this.operacionalConfig,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Estadio(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('planoId: $planoId, ')
          ..write('codigo: $codigo, ')
          ..write('tipo: $tipo, ')
          ..write('label: $label, ')
          ..write('ordem: $ordem, ')
          ..write('dataAplicacao: $dataAplicacao, ')
          ..write('imageLocalPath: $imageLocalPath, ')
          ..write('observacao: $observacao, ')
          ..write('tipoOperacional: $tipoOperacional, ')
          ..write('operacionalConfig: $operacionalConfig, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      uid,
      userId,
      planoId,
      codigo,
      tipo,
      label,
      ordem,
      dataAplicacao,
      imageLocalPath,
      observacao,
      tipoOperacional,
      operacionalConfig,
      createdAt,
      updatedAt,
      syncState,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Estadio &&
          other.uid == this.uid &&
          other.userId == this.userId &&
          other.planoId == this.planoId &&
          other.codigo == this.codigo &&
          other.tipo == this.tipo &&
          other.label == this.label &&
          other.ordem == this.ordem &&
          other.dataAplicacao == this.dataAplicacao &&
          other.imageLocalPath == this.imageLocalPath &&
          other.observacao == this.observacao &&
          other.tipoOperacional == this.tipoOperacional &&
          other.operacionalConfig == this.operacionalConfig &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncState == this.syncState &&
          other.deletedAt == this.deletedAt);
}

class EstadiosCompanion extends UpdateCompanion<Estadio> {
  final Value<String> uid;
  final Value<String?> userId;
  final Value<String> planoId;
  final Value<String> codigo;
  final Value<String> tipo;
  final Value<String> label;
  final Value<int> ordem;
  final Value<DateTime?> dataAplicacao;
  final Value<String?> imageLocalPath;
  final Value<String?> observacao;
  final Value<String?> tipoOperacional;
  final Value<String?> operacionalConfig;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncState;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const EstadiosCompanion({
    this.uid = const Value.absent(),
    this.userId = const Value.absent(),
    this.planoId = const Value.absent(),
    this.codigo = const Value.absent(),
    this.tipo = const Value.absent(),
    this.label = const Value.absent(),
    this.ordem = const Value.absent(),
    this.dataAplicacao = const Value.absent(),
    this.imageLocalPath = const Value.absent(),
    this.observacao = const Value.absent(),
    this.tipoOperacional = const Value.absent(),
    this.operacionalConfig = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EstadiosCompanion.insert({
    required String uid,
    this.userId = const Value.absent(),
    required String planoId,
    required String codigo,
    this.tipo = const Value.absent(),
    required String label,
    this.ordem = const Value.absent(),
    this.dataAplicacao = const Value.absent(),
    this.imageLocalPath = const Value.absent(),
    this.observacao = const Value.absent(),
    this.tipoOperacional = const Value.absent(),
    this.operacionalConfig = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        planoId = Value(planoId),
        codigo = Value(codigo),
        label = Value(label),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Estadio> custom({
    Expression<String>? uid,
    Expression<String>? userId,
    Expression<String>? planoId,
    Expression<String>? codigo,
    Expression<String>? tipo,
    Expression<String>? label,
    Expression<int>? ordem,
    Expression<DateTime>? dataAplicacao,
    Expression<String>? imageLocalPath,
    Expression<String>? observacao,
    Expression<String>? tipoOperacional,
    Expression<String>? operacionalConfig,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncState,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (userId != null) 'user_id': userId,
      if (planoId != null) 'plano_id': planoId,
      if (codigo != null) 'codigo': codigo,
      if (tipo != null) 'tipo': tipo,
      if (label != null) 'label': label,
      if (ordem != null) 'ordem': ordem,
      if (dataAplicacao != null) 'data_aplicacao': dataAplicacao,
      if (imageLocalPath != null) 'image_local_path': imageLocalPath,
      if (observacao != null) 'observacao': observacao,
      if (tipoOperacional != null) 'tipo_operacional': tipoOperacional,
      if (operacionalConfig != null) 'operacional_config': operacionalConfig,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncState != null) 'sync_state': syncState,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EstadiosCompanion copyWith(
      {Value<String>? uid,
      Value<String?>? userId,
      Value<String>? planoId,
      Value<String>? codigo,
      Value<String>? tipo,
      Value<String>? label,
      Value<int>? ordem,
      Value<DateTime?>? dataAplicacao,
      Value<String?>? imageLocalPath,
      Value<String?>? observacao,
      Value<String?>? tipoOperacional,
      Value<String?>? operacionalConfig,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncState,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return EstadiosCompanion(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      planoId: planoId ?? this.planoId,
      codigo: codigo ?? this.codigo,
      tipo: tipo ?? this.tipo,
      label: label ?? this.label,
      ordem: ordem ?? this.ordem,
      dataAplicacao: dataAplicacao ?? this.dataAplicacao,
      imageLocalPath: imageLocalPath ?? this.imageLocalPath,
      observacao: observacao ?? this.observacao,
      tipoOperacional: tipoOperacional ?? this.tipoOperacional,
      operacionalConfig: operacionalConfig ?? this.operacionalConfig,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncState: syncState ?? this.syncState,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (planoId.present) {
      map['plano_id'] = Variable<String>(planoId.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (ordem.present) {
      map['ordem'] = Variable<int>(ordem.value);
    }
    if (dataAplicacao.present) {
      map['data_aplicacao'] = Variable<DateTime>(dataAplicacao.value);
    }
    if (imageLocalPath.present) {
      map['image_local_path'] = Variable<String>(imageLocalPath.value);
    }
    if (observacao.present) {
      map['observacao'] = Variable<String>(observacao.value);
    }
    if (tipoOperacional.present) {
      map['tipo_operacional'] = Variable<String>(tipoOperacional.value);
    }
    if (operacionalConfig.present) {
      map['operacional_config'] = Variable<String>(operacionalConfig.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EstadiosCompanion(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('planoId: $planoId, ')
          ..write('codigo: $codigo, ')
          ..write('tipo: $tipo, ')
          ..write('label: $label, ')
          ..write('ordem: $ordem, ')
          ..write('dataAplicacao: $dataAplicacao, ')
          ..write('imageLocalPath: $imageLocalPath, ')
          ..write('observacao: $observacao, ')
          ..write('tipoOperacional: $tipoOperacional, ')
          ..write('operacionalConfig: $operacionalConfig, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProdutosAplicacaoTable extends ProdutosAplicacao
    with TableInfo<$ProdutosAplicacaoTable, ProdutosAplicacaoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProdutosAplicacaoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _estadioIdMeta =
      const VerificationMeta('estadioId');
  @override
  late final GeneratedColumn<String> estadioId = GeneratedColumn<String>(
      'estadio_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES estadios (uid) ON DELETE CASCADE'));
  static const VerificationMeta _catalogoProdutoIdMeta =
      const VerificationMeta('catalogoProdutoId');
  @override
  late final GeneratedColumn<String> catalogoProdutoId =
      GeneratedColumn<String>('catalogo_produto_id', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES catalogo_produtos (uid)'));
  static const VerificationMeta _produtoNomeMeta =
      const VerificationMeta('produtoNome');
  @override
  late final GeneratedColumn<String> produtoNome = GeneratedColumn<String>(
      'produto_nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _produtoCategoriaMeta =
      const VerificationMeta('produtoCategoria');
  @override
  late final GeneratedColumn<String> produtoCategoria = GeneratedColumn<String>(
      'produto_categoria', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _doseMeta = const VerificationMeta('dose');
  @override
  late final GeneratedColumn<double> dose = GeneratedColumn<double>(
      'dose', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _doseUnidadeMeta =
      const VerificationMeta('doseUnidade');
  @override
  late final GeneratedColumn<String> doseUnidade = GeneratedColumn<String>(
      'dose_unidade', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _areaHaMeta = const VerificationMeta('areaHa');
  @override
  late final GeneratedColumn<double> areaHa = GeneratedColumn<double>(
      'area_ha', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _talhaoRefMeta =
      const VerificationMeta('talhaoRef');
  @override
  late final GeneratedColumn<String> talhaoRef = GeneratedColumn<String>(
      'talhao_ref', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _totalOverrideMeta =
      const VerificationMeta('totalOverride');
  @override
  late final GeneratedColumn<double> totalOverride = GeneratedColumn<double>(
      'total_override', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _overrideMotivoMeta =
      const VerificationMeta('overrideMotivo');
  @override
  late final GeneratedColumn<String> overrideMotivo = GeneratedColumn<String>(
      'override_motivo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _precoUnitarioMeta =
      const VerificationMeta('precoUnitario');
  @override
  late final GeneratedColumn<double> precoUnitario = GeneratedColumn<double>(
      'preco_unitario', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _observacaoMeta =
      const VerificationMeta('observacao');
  @override
  late final GeneratedColumn<String> observacao = GeneratedColumn<String>(
      'observacao', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dataPrevistaMeta =
      const VerificationMeta('dataPrevista');
  @override
  late final GeneratedColumn<DateTime> dataPrevista = GeneratedColumn<DateTime>(
      'data_prevista', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _ordemMeta = const VerificationMeta('ordem');
  @override
  late final GeneratedColumn<int> ordem = GeneratedColumn<int>(
      'ordem', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        userId,
        estadioId,
        catalogoProdutoId,
        produtoNome,
        produtoCategoria,
        dose,
        doseUnidade,
        areaHa,
        talhaoRef,
        totalOverride,
        overrideMotivo,
        precoUnitario,
        observacao,
        dataPrevista,
        ordem,
        createdAt,
        updatedAt,
        syncState,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'produtos_aplicacao';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProdutosAplicacaoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('estadio_id')) {
      context.handle(_estadioIdMeta,
          estadioId.isAcceptableOrUnknown(data['estadio_id']!, _estadioIdMeta));
    } else if (isInserting) {
      context.missing(_estadioIdMeta);
    }
    if (data.containsKey('catalogo_produto_id')) {
      context.handle(
          _catalogoProdutoIdMeta,
          catalogoProdutoId.isAcceptableOrUnknown(
              data['catalogo_produto_id']!, _catalogoProdutoIdMeta));
    }
    if (data.containsKey('produto_nome')) {
      context.handle(
          _produtoNomeMeta,
          produtoNome.isAcceptableOrUnknown(
              data['produto_nome']!, _produtoNomeMeta));
    } else if (isInserting) {
      context.missing(_produtoNomeMeta);
    }
    if (data.containsKey('produto_categoria')) {
      context.handle(
          _produtoCategoriaMeta,
          produtoCategoria.isAcceptableOrUnknown(
              data['produto_categoria']!, _produtoCategoriaMeta));
    } else if (isInserting) {
      context.missing(_produtoCategoriaMeta);
    }
    if (data.containsKey('dose')) {
      context.handle(
          _doseMeta, dose.isAcceptableOrUnknown(data['dose']!, _doseMeta));
    } else if (isInserting) {
      context.missing(_doseMeta);
    }
    if (data.containsKey('dose_unidade')) {
      context.handle(
          _doseUnidadeMeta,
          doseUnidade.isAcceptableOrUnknown(
              data['dose_unidade']!, _doseUnidadeMeta));
    } else if (isInserting) {
      context.missing(_doseUnidadeMeta);
    }
    if (data.containsKey('area_ha')) {
      context.handle(_areaHaMeta,
          areaHa.isAcceptableOrUnknown(data['area_ha']!, _areaHaMeta));
    } else if (isInserting) {
      context.missing(_areaHaMeta);
    }
    if (data.containsKey('talhao_ref')) {
      context.handle(_talhaoRefMeta,
          talhaoRef.isAcceptableOrUnknown(data['talhao_ref']!, _talhaoRefMeta));
    }
    if (data.containsKey('total_override')) {
      context.handle(
          _totalOverrideMeta,
          totalOverride.isAcceptableOrUnknown(
              data['total_override']!, _totalOverrideMeta));
    }
    if (data.containsKey('override_motivo')) {
      context.handle(
          _overrideMotivoMeta,
          overrideMotivo.isAcceptableOrUnknown(
              data['override_motivo']!, _overrideMotivoMeta));
    }
    if (data.containsKey('preco_unitario')) {
      context.handle(
          _precoUnitarioMeta,
          precoUnitario.isAcceptableOrUnknown(
              data['preco_unitario']!, _precoUnitarioMeta));
    }
    if (data.containsKey('observacao')) {
      context.handle(
          _observacaoMeta,
          observacao.isAcceptableOrUnknown(
              data['observacao']!, _observacaoMeta));
    }
    if (data.containsKey('data_prevista')) {
      context.handle(
          _dataPrevistaMeta,
          dataPrevista.isAcceptableOrUnknown(
              data['data_prevista']!, _dataPrevistaMeta));
    }
    if (data.containsKey('ordem')) {
      context.handle(
          _ordemMeta, ordem.isAcceptableOrUnknown(data['ordem']!, _ordemMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  ProdutosAplicacaoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProdutosAplicacaoData(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      estadioId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estadio_id'])!,
      catalogoProdutoId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}catalogo_produto_id']),
      produtoNome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}produto_nome'])!,
      produtoCategoria: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}produto_categoria'])!,
      dose: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}dose'])!,
      doseUnidade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dose_unidade'])!,
      areaHa: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}area_ha'])!,
      talhaoRef: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}talhao_ref']),
      totalOverride: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_override']),
      overrideMotivo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}override_motivo']),
      precoUnitario: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}preco_unitario']),
      observacao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacao']),
      dataPrevista: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_prevista']),
      ordem: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordem'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $ProdutosAplicacaoTable createAlias(String alias) {
    return $ProdutosAplicacaoTable(attachedDatabase, alias);
  }
}

class ProdutosAplicacaoData extends DataClass
    implements Insertable<ProdutosAplicacaoData> {
  final String uid;
  final String? userId;
  final String estadioId;
  final String? catalogoProdutoId;
  final String produtoNome;
  final String produtoCategoria;
  final double dose;
  final String doseUnidade;
  final double areaHa;
  final String? talhaoRef;
  final double? totalOverride;
  final String? overrideMotivo;
  final double? precoUnitario;
  final String? observacao;
  final DateTime? dataPrevista;
  final int ordem;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncState;
  final DateTime? deletedAt;
  const ProdutosAplicacaoData(
      {required this.uid,
      this.userId,
      required this.estadioId,
      this.catalogoProdutoId,
      required this.produtoNome,
      required this.produtoCategoria,
      required this.dose,
      required this.doseUnidade,
      required this.areaHa,
      this.talhaoRef,
      this.totalOverride,
      this.overrideMotivo,
      this.precoUnitario,
      this.observacao,
      this.dataPrevista,
      required this.ordem,
      required this.createdAt,
      required this.updatedAt,
      required this.syncState,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['estadio_id'] = Variable<String>(estadioId);
    if (!nullToAbsent || catalogoProdutoId != null) {
      map['catalogo_produto_id'] = Variable<String>(catalogoProdutoId);
    }
    map['produto_nome'] = Variable<String>(produtoNome);
    map['produto_categoria'] = Variable<String>(produtoCategoria);
    map['dose'] = Variable<double>(dose);
    map['dose_unidade'] = Variable<String>(doseUnidade);
    map['area_ha'] = Variable<double>(areaHa);
    if (!nullToAbsent || talhaoRef != null) {
      map['talhao_ref'] = Variable<String>(talhaoRef);
    }
    if (!nullToAbsent || totalOverride != null) {
      map['total_override'] = Variable<double>(totalOverride);
    }
    if (!nullToAbsent || overrideMotivo != null) {
      map['override_motivo'] = Variable<String>(overrideMotivo);
    }
    if (!nullToAbsent || precoUnitario != null) {
      map['preco_unitario'] = Variable<double>(precoUnitario);
    }
    if (!nullToAbsent || observacao != null) {
      map['observacao'] = Variable<String>(observacao);
    }
    if (!nullToAbsent || dataPrevista != null) {
      map['data_prevista'] = Variable<DateTime>(dataPrevista);
    }
    map['ordem'] = Variable<int>(ordem);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ProdutosAplicacaoCompanion toCompanion(bool nullToAbsent) {
    return ProdutosAplicacaoCompanion(
      uid: Value(uid),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      estadioId: Value(estadioId),
      catalogoProdutoId: catalogoProdutoId == null && nullToAbsent
          ? const Value.absent()
          : Value(catalogoProdutoId),
      produtoNome: Value(produtoNome),
      produtoCategoria: Value(produtoCategoria),
      dose: Value(dose),
      doseUnidade: Value(doseUnidade),
      areaHa: Value(areaHa),
      talhaoRef: talhaoRef == null && nullToAbsent
          ? const Value.absent()
          : Value(talhaoRef),
      totalOverride: totalOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(totalOverride),
      overrideMotivo: overrideMotivo == null && nullToAbsent
          ? const Value.absent()
          : Value(overrideMotivo),
      precoUnitario: precoUnitario == null && nullToAbsent
          ? const Value.absent()
          : Value(precoUnitario),
      observacao: observacao == null && nullToAbsent
          ? const Value.absent()
          : Value(observacao),
      dataPrevista: dataPrevista == null && nullToAbsent
          ? const Value.absent()
          : Value(dataPrevista),
      ordem: Value(ordem),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncState: Value(syncState),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory ProdutosAplicacaoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProdutosAplicacaoData(
      uid: serializer.fromJson<String>(json['uid']),
      userId: serializer.fromJson<String?>(json['userId']),
      estadioId: serializer.fromJson<String>(json['estadioId']),
      catalogoProdutoId:
          serializer.fromJson<String?>(json['catalogoProdutoId']),
      produtoNome: serializer.fromJson<String>(json['produtoNome']),
      produtoCategoria: serializer.fromJson<String>(json['produtoCategoria']),
      dose: serializer.fromJson<double>(json['dose']),
      doseUnidade: serializer.fromJson<String>(json['doseUnidade']),
      areaHa: serializer.fromJson<double>(json['areaHa']),
      talhaoRef: serializer.fromJson<String?>(json['talhaoRef']),
      totalOverride: serializer.fromJson<double?>(json['totalOverride']),
      overrideMotivo: serializer.fromJson<String?>(json['overrideMotivo']),
      precoUnitario: serializer.fromJson<double?>(json['precoUnitario']),
      observacao: serializer.fromJson<String?>(json['observacao']),
      dataPrevista: serializer.fromJson<DateTime?>(json['dataPrevista']),
      ordem: serializer.fromJson<int>(json['ordem']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'userId': serializer.toJson<String?>(userId),
      'estadioId': serializer.toJson<String>(estadioId),
      'catalogoProdutoId': serializer.toJson<String?>(catalogoProdutoId),
      'produtoNome': serializer.toJson<String>(produtoNome),
      'produtoCategoria': serializer.toJson<String>(produtoCategoria),
      'dose': serializer.toJson<double>(dose),
      'doseUnidade': serializer.toJson<String>(doseUnidade),
      'areaHa': serializer.toJson<double>(areaHa),
      'talhaoRef': serializer.toJson<String?>(talhaoRef),
      'totalOverride': serializer.toJson<double?>(totalOverride),
      'overrideMotivo': serializer.toJson<String?>(overrideMotivo),
      'precoUnitario': serializer.toJson<double?>(precoUnitario),
      'observacao': serializer.toJson<String?>(observacao),
      'dataPrevista': serializer.toJson<DateTime?>(dataPrevista),
      'ordem': serializer.toJson<int>(ordem),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncState': serializer.toJson<String>(syncState),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  ProdutosAplicacaoData copyWith(
          {String? uid,
          Value<String?> userId = const Value.absent(),
          String? estadioId,
          Value<String?> catalogoProdutoId = const Value.absent(),
          String? produtoNome,
          String? produtoCategoria,
          double? dose,
          String? doseUnidade,
          double? areaHa,
          Value<String?> talhaoRef = const Value.absent(),
          Value<double?> totalOverride = const Value.absent(),
          Value<String?> overrideMotivo = const Value.absent(),
          Value<double?> precoUnitario = const Value.absent(),
          Value<String?> observacao = const Value.absent(),
          Value<DateTime?> dataPrevista = const Value.absent(),
          int? ordem,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncState,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      ProdutosAplicacaoData(
        uid: uid ?? this.uid,
        userId: userId.present ? userId.value : this.userId,
        estadioId: estadioId ?? this.estadioId,
        catalogoProdutoId: catalogoProdutoId.present
            ? catalogoProdutoId.value
            : this.catalogoProdutoId,
        produtoNome: produtoNome ?? this.produtoNome,
        produtoCategoria: produtoCategoria ?? this.produtoCategoria,
        dose: dose ?? this.dose,
        doseUnidade: doseUnidade ?? this.doseUnidade,
        areaHa: areaHa ?? this.areaHa,
        talhaoRef: talhaoRef.present ? talhaoRef.value : this.talhaoRef,
        totalOverride:
            totalOverride.present ? totalOverride.value : this.totalOverride,
        overrideMotivo:
            overrideMotivo.present ? overrideMotivo.value : this.overrideMotivo,
        precoUnitario:
            precoUnitario.present ? precoUnitario.value : this.precoUnitario,
        observacao: observacao.present ? observacao.value : this.observacao,
        dataPrevista:
            dataPrevista.present ? dataPrevista.value : this.dataPrevista,
        ordem: ordem ?? this.ordem,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncState: syncState ?? this.syncState,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  ProdutosAplicacaoData copyWithCompanion(ProdutosAplicacaoCompanion data) {
    return ProdutosAplicacaoData(
      uid: data.uid.present ? data.uid.value : this.uid,
      userId: data.userId.present ? data.userId.value : this.userId,
      estadioId: data.estadioId.present ? data.estadioId.value : this.estadioId,
      catalogoProdutoId: data.catalogoProdutoId.present
          ? data.catalogoProdutoId.value
          : this.catalogoProdutoId,
      produtoNome:
          data.produtoNome.present ? data.produtoNome.value : this.produtoNome,
      produtoCategoria: data.produtoCategoria.present
          ? data.produtoCategoria.value
          : this.produtoCategoria,
      dose: data.dose.present ? data.dose.value : this.dose,
      doseUnidade:
          data.doseUnidade.present ? data.doseUnidade.value : this.doseUnidade,
      areaHa: data.areaHa.present ? data.areaHa.value : this.areaHa,
      talhaoRef: data.talhaoRef.present ? data.talhaoRef.value : this.talhaoRef,
      totalOverride: data.totalOverride.present
          ? data.totalOverride.value
          : this.totalOverride,
      overrideMotivo: data.overrideMotivo.present
          ? data.overrideMotivo.value
          : this.overrideMotivo,
      precoUnitario: data.precoUnitario.present
          ? data.precoUnitario.value
          : this.precoUnitario,
      observacao:
          data.observacao.present ? data.observacao.value : this.observacao,
      dataPrevista: data.dataPrevista.present
          ? data.dataPrevista.value
          : this.dataPrevista,
      ordem: data.ordem.present ? data.ordem.value : this.ordem,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProdutosAplicacaoData(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('estadioId: $estadioId, ')
          ..write('catalogoProdutoId: $catalogoProdutoId, ')
          ..write('produtoNome: $produtoNome, ')
          ..write('produtoCategoria: $produtoCategoria, ')
          ..write('dose: $dose, ')
          ..write('doseUnidade: $doseUnidade, ')
          ..write('areaHa: $areaHa, ')
          ..write('talhaoRef: $talhaoRef, ')
          ..write('totalOverride: $totalOverride, ')
          ..write('overrideMotivo: $overrideMotivo, ')
          ..write('precoUnitario: $precoUnitario, ')
          ..write('observacao: $observacao, ')
          ..write('dataPrevista: $dataPrevista, ')
          ..write('ordem: $ordem, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      uid,
      userId,
      estadioId,
      catalogoProdutoId,
      produtoNome,
      produtoCategoria,
      dose,
      doseUnidade,
      areaHa,
      talhaoRef,
      totalOverride,
      overrideMotivo,
      precoUnitario,
      observacao,
      dataPrevista,
      ordem,
      createdAt,
      updatedAt,
      syncState,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProdutosAplicacaoData &&
          other.uid == this.uid &&
          other.userId == this.userId &&
          other.estadioId == this.estadioId &&
          other.catalogoProdutoId == this.catalogoProdutoId &&
          other.produtoNome == this.produtoNome &&
          other.produtoCategoria == this.produtoCategoria &&
          other.dose == this.dose &&
          other.doseUnidade == this.doseUnidade &&
          other.areaHa == this.areaHa &&
          other.talhaoRef == this.talhaoRef &&
          other.totalOverride == this.totalOverride &&
          other.overrideMotivo == this.overrideMotivo &&
          other.precoUnitario == this.precoUnitario &&
          other.observacao == this.observacao &&
          other.dataPrevista == this.dataPrevista &&
          other.ordem == this.ordem &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncState == this.syncState &&
          other.deletedAt == this.deletedAt);
}

class ProdutosAplicacaoCompanion
    extends UpdateCompanion<ProdutosAplicacaoData> {
  final Value<String> uid;
  final Value<String?> userId;
  final Value<String> estadioId;
  final Value<String?> catalogoProdutoId;
  final Value<String> produtoNome;
  final Value<String> produtoCategoria;
  final Value<double> dose;
  final Value<String> doseUnidade;
  final Value<double> areaHa;
  final Value<String?> talhaoRef;
  final Value<double?> totalOverride;
  final Value<String?> overrideMotivo;
  final Value<double?> precoUnitario;
  final Value<String?> observacao;
  final Value<DateTime?> dataPrevista;
  final Value<int> ordem;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncState;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const ProdutosAplicacaoCompanion({
    this.uid = const Value.absent(),
    this.userId = const Value.absent(),
    this.estadioId = const Value.absent(),
    this.catalogoProdutoId = const Value.absent(),
    this.produtoNome = const Value.absent(),
    this.produtoCategoria = const Value.absent(),
    this.dose = const Value.absent(),
    this.doseUnidade = const Value.absent(),
    this.areaHa = const Value.absent(),
    this.talhaoRef = const Value.absent(),
    this.totalOverride = const Value.absent(),
    this.overrideMotivo = const Value.absent(),
    this.precoUnitario = const Value.absent(),
    this.observacao = const Value.absent(),
    this.dataPrevista = const Value.absent(),
    this.ordem = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProdutosAplicacaoCompanion.insert({
    required String uid,
    this.userId = const Value.absent(),
    required String estadioId,
    this.catalogoProdutoId = const Value.absent(),
    required String produtoNome,
    required String produtoCategoria,
    required double dose,
    required String doseUnidade,
    required double areaHa,
    this.talhaoRef = const Value.absent(),
    this.totalOverride = const Value.absent(),
    this.overrideMotivo = const Value.absent(),
    this.precoUnitario = const Value.absent(),
    this.observacao = const Value.absent(),
    this.dataPrevista = const Value.absent(),
    this.ordem = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        estadioId = Value(estadioId),
        produtoNome = Value(produtoNome),
        produtoCategoria = Value(produtoCategoria),
        dose = Value(dose),
        doseUnidade = Value(doseUnidade),
        areaHa = Value(areaHa),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<ProdutosAplicacaoData> custom({
    Expression<String>? uid,
    Expression<String>? userId,
    Expression<String>? estadioId,
    Expression<String>? catalogoProdutoId,
    Expression<String>? produtoNome,
    Expression<String>? produtoCategoria,
    Expression<double>? dose,
    Expression<String>? doseUnidade,
    Expression<double>? areaHa,
    Expression<String>? talhaoRef,
    Expression<double>? totalOverride,
    Expression<String>? overrideMotivo,
    Expression<double>? precoUnitario,
    Expression<String>? observacao,
    Expression<DateTime>? dataPrevista,
    Expression<int>? ordem,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncState,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (userId != null) 'user_id': userId,
      if (estadioId != null) 'estadio_id': estadioId,
      if (catalogoProdutoId != null) 'catalogo_produto_id': catalogoProdutoId,
      if (produtoNome != null) 'produto_nome': produtoNome,
      if (produtoCategoria != null) 'produto_categoria': produtoCategoria,
      if (dose != null) 'dose': dose,
      if (doseUnidade != null) 'dose_unidade': doseUnidade,
      if (areaHa != null) 'area_ha': areaHa,
      if (talhaoRef != null) 'talhao_ref': talhaoRef,
      if (totalOverride != null) 'total_override': totalOverride,
      if (overrideMotivo != null) 'override_motivo': overrideMotivo,
      if (precoUnitario != null) 'preco_unitario': precoUnitario,
      if (observacao != null) 'observacao': observacao,
      if (dataPrevista != null) 'data_prevista': dataPrevista,
      if (ordem != null) 'ordem': ordem,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncState != null) 'sync_state': syncState,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProdutosAplicacaoCompanion copyWith(
      {Value<String>? uid,
      Value<String?>? userId,
      Value<String>? estadioId,
      Value<String?>? catalogoProdutoId,
      Value<String>? produtoNome,
      Value<String>? produtoCategoria,
      Value<double>? dose,
      Value<String>? doseUnidade,
      Value<double>? areaHa,
      Value<String?>? talhaoRef,
      Value<double?>? totalOverride,
      Value<String?>? overrideMotivo,
      Value<double?>? precoUnitario,
      Value<String?>? observacao,
      Value<DateTime?>? dataPrevista,
      Value<int>? ordem,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncState,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return ProdutosAplicacaoCompanion(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      estadioId: estadioId ?? this.estadioId,
      catalogoProdutoId: catalogoProdutoId ?? this.catalogoProdutoId,
      produtoNome: produtoNome ?? this.produtoNome,
      produtoCategoria: produtoCategoria ?? this.produtoCategoria,
      dose: dose ?? this.dose,
      doseUnidade: doseUnidade ?? this.doseUnidade,
      areaHa: areaHa ?? this.areaHa,
      talhaoRef: talhaoRef ?? this.talhaoRef,
      totalOverride: totalOverride ?? this.totalOverride,
      overrideMotivo: overrideMotivo ?? this.overrideMotivo,
      precoUnitario: precoUnitario ?? this.precoUnitario,
      observacao: observacao ?? this.observacao,
      dataPrevista: dataPrevista ?? this.dataPrevista,
      ordem: ordem ?? this.ordem,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncState: syncState ?? this.syncState,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (estadioId.present) {
      map['estadio_id'] = Variable<String>(estadioId.value);
    }
    if (catalogoProdutoId.present) {
      map['catalogo_produto_id'] = Variable<String>(catalogoProdutoId.value);
    }
    if (produtoNome.present) {
      map['produto_nome'] = Variable<String>(produtoNome.value);
    }
    if (produtoCategoria.present) {
      map['produto_categoria'] = Variable<String>(produtoCategoria.value);
    }
    if (dose.present) {
      map['dose'] = Variable<double>(dose.value);
    }
    if (doseUnidade.present) {
      map['dose_unidade'] = Variable<String>(doseUnidade.value);
    }
    if (areaHa.present) {
      map['area_ha'] = Variable<double>(areaHa.value);
    }
    if (talhaoRef.present) {
      map['talhao_ref'] = Variable<String>(talhaoRef.value);
    }
    if (totalOverride.present) {
      map['total_override'] = Variable<double>(totalOverride.value);
    }
    if (overrideMotivo.present) {
      map['override_motivo'] = Variable<String>(overrideMotivo.value);
    }
    if (precoUnitario.present) {
      map['preco_unitario'] = Variable<double>(precoUnitario.value);
    }
    if (observacao.present) {
      map['observacao'] = Variable<String>(observacao.value);
    }
    if (dataPrevista.present) {
      map['data_prevista'] = Variable<DateTime>(dataPrevista.value);
    }
    if (ordem.present) {
      map['ordem'] = Variable<int>(ordem.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProdutosAplicacaoCompanion(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('estadioId: $estadioId, ')
          ..write('catalogoProdutoId: $catalogoProdutoId, ')
          ..write('produtoNome: $produtoNome, ')
          ..write('produtoCategoria: $produtoCategoria, ')
          ..write('dose: $dose, ')
          ..write('doseUnidade: $doseUnidade, ')
          ..write('areaHa: $areaHa, ')
          ..write('talhaoRef: $talhaoRef, ')
          ..write('totalOverride: $totalOverride, ')
          ..write('overrideMotivo: $overrideMotivo, ')
          ..write('precoUnitario: $precoUnitario, ')
          ..write('observacao: $observacao, ')
          ..write('dataPrevista: $dataPrevista, ')
          ..write('ordem: $ordem, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EscoposAlocacaoTable extends EscoposAlocacao
    with TableInfo<$EscoposAlocacaoTable, EscoposAlocacaoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EscoposAlocacaoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _produtoAplicacaoIdMeta =
      const VerificationMeta('produtoAplicacaoId');
  @override
  late final GeneratedColumn<String> produtoAplicacaoId =
      GeneratedColumn<String>('produto_aplicacao_id', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES produtos_aplicacao (uid) ON DELETE CASCADE'));
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _talhoesIdsJsonMeta =
      const VerificationMeta('talhoesIdsJson');
  @override
  late final GeneratedColumn<String> talhoesIdsJson = GeneratedColumn<String>(
      'talhoes_ids_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantidadeTotalMeta =
      const VerificationMeta('quantidadeTotal');
  @override
  late final GeneratedColumn<double> quantidadeTotal = GeneratedColumn<double>(
      'quantidade_total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dataCriacaoMeta =
      const VerificationMeta('dataCriacao');
  @override
  late final GeneratedColumn<DateTime> dataCriacao = GeneratedColumn<DateTime>(
      'data_criacao', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        userId,
        produtoAplicacaoId,
        tipo,
        talhoesIdsJson,
        quantidadeTotal,
        dataCriacao,
        syncState,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'escopos_alocacao';
  @override
  VerificationContext validateIntegrity(
      Insertable<EscoposAlocacaoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('produto_aplicacao_id')) {
      context.handle(
          _produtoAplicacaoIdMeta,
          produtoAplicacaoId.isAcceptableOrUnknown(
              data['produto_aplicacao_id']!, _produtoAplicacaoIdMeta));
    } else if (isInserting) {
      context.missing(_produtoAplicacaoIdMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('talhoes_ids_json')) {
      context.handle(
          _talhoesIdsJsonMeta,
          talhoesIdsJson.isAcceptableOrUnknown(
              data['talhoes_ids_json']!, _talhoesIdsJsonMeta));
    } else if (isInserting) {
      context.missing(_talhoesIdsJsonMeta);
    }
    if (data.containsKey('quantidade_total')) {
      context.handle(
          _quantidadeTotalMeta,
          quantidadeTotal.isAcceptableOrUnknown(
              data['quantidade_total']!, _quantidadeTotalMeta));
    } else if (isInserting) {
      context.missing(_quantidadeTotalMeta);
    }
    if (data.containsKey('data_criacao')) {
      context.handle(
          _dataCriacaoMeta,
          dataCriacao.isAcceptableOrUnknown(
              data['data_criacao']!, _dataCriacaoMeta));
    } else if (isInserting) {
      context.missing(_dataCriacaoMeta);
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  EscoposAlocacaoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EscoposAlocacaoData(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      produtoAplicacaoId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}produto_aplicacao_id'])!,
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo'])!,
      talhoesIdsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}talhoes_ids_json'])!,
      quantidadeTotal: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}quantidade_total'])!,
      dataCriacao: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_criacao'])!,
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $EscoposAlocacaoTable createAlias(String alias) {
    return $EscoposAlocacaoTable(attachedDatabase, alias);
  }
}

class EscoposAlocacaoData extends DataClass
    implements Insertable<EscoposAlocacaoData> {
  final String uid;
  final String? userId;
  final String produtoAplicacaoId;
  final String tipo;
  final String talhoesIdsJson;
  final double quantidadeTotal;
  final DateTime dataCriacao;
  final String syncState;
  final DateTime? deletedAt;
  const EscoposAlocacaoData(
      {required this.uid,
      this.userId,
      required this.produtoAplicacaoId,
      required this.tipo,
      required this.talhoesIdsJson,
      required this.quantidadeTotal,
      required this.dataCriacao,
      required this.syncState,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['produto_aplicacao_id'] = Variable<String>(produtoAplicacaoId);
    map['tipo'] = Variable<String>(tipo);
    map['talhoes_ids_json'] = Variable<String>(talhoesIdsJson);
    map['quantidade_total'] = Variable<double>(quantidadeTotal);
    map['data_criacao'] = Variable<DateTime>(dataCriacao);
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  EscoposAlocacaoCompanion toCompanion(bool nullToAbsent) {
    return EscoposAlocacaoCompanion(
      uid: Value(uid),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      produtoAplicacaoId: Value(produtoAplicacaoId),
      tipo: Value(tipo),
      talhoesIdsJson: Value(talhoesIdsJson),
      quantidadeTotal: Value(quantidadeTotal),
      dataCriacao: Value(dataCriacao),
      syncState: Value(syncState),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory EscoposAlocacaoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EscoposAlocacaoData(
      uid: serializer.fromJson<String>(json['uid']),
      userId: serializer.fromJson<String?>(json['userId']),
      produtoAplicacaoId:
          serializer.fromJson<String>(json['produtoAplicacaoId']),
      tipo: serializer.fromJson<String>(json['tipo']),
      talhoesIdsJson: serializer.fromJson<String>(json['talhoesIdsJson']),
      quantidadeTotal: serializer.fromJson<double>(json['quantidadeTotal']),
      dataCriacao: serializer.fromJson<DateTime>(json['dataCriacao']),
      syncState: serializer.fromJson<String>(json['syncState']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'userId': serializer.toJson<String?>(userId),
      'produtoAplicacaoId': serializer.toJson<String>(produtoAplicacaoId),
      'tipo': serializer.toJson<String>(tipo),
      'talhoesIdsJson': serializer.toJson<String>(talhoesIdsJson),
      'quantidadeTotal': serializer.toJson<double>(quantidadeTotal),
      'dataCriacao': serializer.toJson<DateTime>(dataCriacao),
      'syncState': serializer.toJson<String>(syncState),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  EscoposAlocacaoData copyWith(
          {String? uid,
          Value<String?> userId = const Value.absent(),
          String? produtoAplicacaoId,
          String? tipo,
          String? talhoesIdsJson,
          double? quantidadeTotal,
          DateTime? dataCriacao,
          String? syncState,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      EscoposAlocacaoData(
        uid: uid ?? this.uid,
        userId: userId.present ? userId.value : this.userId,
        produtoAplicacaoId: produtoAplicacaoId ?? this.produtoAplicacaoId,
        tipo: tipo ?? this.tipo,
        talhoesIdsJson: talhoesIdsJson ?? this.talhoesIdsJson,
        quantidadeTotal: quantidadeTotal ?? this.quantidadeTotal,
        dataCriacao: dataCriacao ?? this.dataCriacao,
        syncState: syncState ?? this.syncState,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  EscoposAlocacaoData copyWithCompanion(EscoposAlocacaoCompanion data) {
    return EscoposAlocacaoData(
      uid: data.uid.present ? data.uid.value : this.uid,
      userId: data.userId.present ? data.userId.value : this.userId,
      produtoAplicacaoId: data.produtoAplicacaoId.present
          ? data.produtoAplicacaoId.value
          : this.produtoAplicacaoId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      talhoesIdsJson: data.talhoesIdsJson.present
          ? data.talhoesIdsJson.value
          : this.talhoesIdsJson,
      quantidadeTotal: data.quantidadeTotal.present
          ? data.quantidadeTotal.value
          : this.quantidadeTotal,
      dataCriacao:
          data.dataCriacao.present ? data.dataCriacao.value : this.dataCriacao,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EscoposAlocacaoData(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('produtoAplicacaoId: $produtoAplicacaoId, ')
          ..write('tipo: $tipo, ')
          ..write('talhoesIdsJson: $talhoesIdsJson, ')
          ..write('quantidadeTotal: $quantidadeTotal, ')
          ..write('dataCriacao: $dataCriacao, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uid, userId, produtoAplicacaoId, tipo,
      talhoesIdsJson, quantidadeTotal, dataCriacao, syncState, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EscoposAlocacaoData &&
          other.uid == this.uid &&
          other.userId == this.userId &&
          other.produtoAplicacaoId == this.produtoAplicacaoId &&
          other.tipo == this.tipo &&
          other.talhoesIdsJson == this.talhoesIdsJson &&
          other.quantidadeTotal == this.quantidadeTotal &&
          other.dataCriacao == this.dataCriacao &&
          other.syncState == this.syncState &&
          other.deletedAt == this.deletedAt);
}

class EscoposAlocacaoCompanion extends UpdateCompanion<EscoposAlocacaoData> {
  final Value<String> uid;
  final Value<String?> userId;
  final Value<String> produtoAplicacaoId;
  final Value<String> tipo;
  final Value<String> talhoesIdsJson;
  final Value<double> quantidadeTotal;
  final Value<DateTime> dataCriacao;
  final Value<String> syncState;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const EscoposAlocacaoCompanion({
    this.uid = const Value.absent(),
    this.userId = const Value.absent(),
    this.produtoAplicacaoId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.talhoesIdsJson = const Value.absent(),
    this.quantidadeTotal = const Value.absent(),
    this.dataCriacao = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EscoposAlocacaoCompanion.insert({
    required String uid,
    this.userId = const Value.absent(),
    required String produtoAplicacaoId,
    required String tipo,
    required String talhoesIdsJson,
    required double quantidadeTotal,
    required DateTime dataCriacao,
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        produtoAplicacaoId = Value(produtoAplicacaoId),
        tipo = Value(tipo),
        talhoesIdsJson = Value(talhoesIdsJson),
        quantidadeTotal = Value(quantidadeTotal),
        dataCriacao = Value(dataCriacao);
  static Insertable<EscoposAlocacaoData> custom({
    Expression<String>? uid,
    Expression<String>? userId,
    Expression<String>? produtoAplicacaoId,
    Expression<String>? tipo,
    Expression<String>? talhoesIdsJson,
    Expression<double>? quantidadeTotal,
    Expression<DateTime>? dataCriacao,
    Expression<String>? syncState,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (userId != null) 'user_id': userId,
      if (produtoAplicacaoId != null)
        'produto_aplicacao_id': produtoAplicacaoId,
      if (tipo != null) 'tipo': tipo,
      if (talhoesIdsJson != null) 'talhoes_ids_json': talhoesIdsJson,
      if (quantidadeTotal != null) 'quantidade_total': quantidadeTotal,
      if (dataCriacao != null) 'data_criacao': dataCriacao,
      if (syncState != null) 'sync_state': syncState,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EscoposAlocacaoCompanion copyWith(
      {Value<String>? uid,
      Value<String?>? userId,
      Value<String>? produtoAplicacaoId,
      Value<String>? tipo,
      Value<String>? talhoesIdsJson,
      Value<double>? quantidadeTotal,
      Value<DateTime>? dataCriacao,
      Value<String>? syncState,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return EscoposAlocacaoCompanion(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      produtoAplicacaoId: produtoAplicacaoId ?? this.produtoAplicacaoId,
      tipo: tipo ?? this.tipo,
      talhoesIdsJson: talhoesIdsJson ?? this.talhoesIdsJson,
      quantidadeTotal: quantidadeTotal ?? this.quantidadeTotal,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      syncState: syncState ?? this.syncState,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (produtoAplicacaoId.present) {
      map['produto_aplicacao_id'] = Variable<String>(produtoAplicacaoId.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (talhoesIdsJson.present) {
      map['talhoes_ids_json'] = Variable<String>(talhoesIdsJson.value);
    }
    if (quantidadeTotal.present) {
      map['quantidade_total'] = Variable<double>(quantidadeTotal.value);
    }
    if (dataCriacao.present) {
      map['data_criacao'] = Variable<DateTime>(dataCriacao.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EscoposAlocacaoCompanion(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('produtoAplicacaoId: $produtoAplicacaoId, ')
          ..write('tipo: $tipo, ')
          ..write('talhoesIdsJson: $talhoesIdsJson, ')
          ..write('quantidadeTotal: $quantidadeTotal, ')
          ..write('dataCriacao: $dataCriacao, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AlocacoesTalhaoTable extends AlocacoesTalhao
    with TableInfo<$AlocacoesTalhaoTable, AlocacoesTalhaoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlocacoesTalhaoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _produtoAplicacaoIdMeta =
      const VerificationMeta('produtoAplicacaoId');
  @override
  late final GeneratedColumn<String> produtoAplicacaoId =
      GeneratedColumn<String>('produto_aplicacao_id', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES produtos_aplicacao (uid) ON DELETE CASCADE'));
  static const VerificationMeta _talhaoIdMeta =
      const VerificationMeta('talhaoId');
  @override
  late final GeneratedColumn<String> talhaoId = GeneratedColumn<String>(
      'talhao_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES talhoes (uid) ON DELETE CASCADE'));
  static const VerificationMeta _quantidadeAlocadaMeta =
      const VerificationMeta('quantidadeAlocada');
  @override
  late final GeneratedColumn<double> quantidadeAlocada =
      GeneratedColumn<double>('quantidade_alocada', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _origemEscopoIdMeta =
      const VerificationMeta('origemEscopoId');
  @override
  late final GeneratedColumn<String> origemEscopoId = GeneratedColumn<String>(
      'origem_escopo_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES escopos_alocacao (uid) ON DELETE CASCADE'));
  static const VerificationMeta _dataLancamentoMeta =
      const VerificationMeta('dataLancamento');
  @override
  late final GeneratedColumn<DateTime> dataLancamento =
      GeneratedColumn<DateTime>('data_lancamento', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _foiAjustadoManualmenteMeta =
      const VerificationMeta('foiAjustadoManualmente');
  @override
  late final GeneratedColumn<bool> foiAjustadoManualmente =
      GeneratedColumn<bool>('foi_ajustado_manualmente', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("foi_ajustado_manualmente" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        userId,
        produtoAplicacaoId,
        talhaoId,
        quantidadeAlocada,
        origemEscopoId,
        dataLancamento,
        foiAjustadoManualmente,
        syncState,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alocacoes_talhao';
  @override
  VerificationContext validateIntegrity(
      Insertable<AlocacoesTalhaoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('produto_aplicacao_id')) {
      context.handle(
          _produtoAplicacaoIdMeta,
          produtoAplicacaoId.isAcceptableOrUnknown(
              data['produto_aplicacao_id']!, _produtoAplicacaoIdMeta));
    } else if (isInserting) {
      context.missing(_produtoAplicacaoIdMeta);
    }
    if (data.containsKey('talhao_id')) {
      context.handle(_talhaoIdMeta,
          talhaoId.isAcceptableOrUnknown(data['talhao_id']!, _talhaoIdMeta));
    } else if (isInserting) {
      context.missing(_talhaoIdMeta);
    }
    if (data.containsKey('quantidade_alocada')) {
      context.handle(
          _quantidadeAlocadaMeta,
          quantidadeAlocada.isAcceptableOrUnknown(
              data['quantidade_alocada']!, _quantidadeAlocadaMeta));
    } else if (isInserting) {
      context.missing(_quantidadeAlocadaMeta);
    }
    if (data.containsKey('origem_escopo_id')) {
      context.handle(
          _origemEscopoIdMeta,
          origemEscopoId.isAcceptableOrUnknown(
              data['origem_escopo_id']!, _origemEscopoIdMeta));
    } else if (isInserting) {
      context.missing(_origemEscopoIdMeta);
    }
    if (data.containsKey('data_lancamento')) {
      context.handle(
          _dataLancamentoMeta,
          dataLancamento.isAcceptableOrUnknown(
              data['data_lancamento']!, _dataLancamentoMeta));
    } else if (isInserting) {
      context.missing(_dataLancamentoMeta);
    }
    if (data.containsKey('foi_ajustado_manualmente')) {
      context.handle(
          _foiAjustadoManualmenteMeta,
          foiAjustadoManualmente.isAcceptableOrUnknown(
              data['foi_ajustado_manualmente']!, _foiAjustadoManualmenteMeta));
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  AlocacoesTalhaoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlocacoesTalhaoData(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      produtoAplicacaoId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}produto_aplicacao_id'])!,
      talhaoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}talhao_id'])!,
      quantidadeAlocada: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}quantidade_alocada'])!,
      origemEscopoId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}origem_escopo_id'])!,
      dataLancamento: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_lancamento'])!,
      foiAjustadoManualmente: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}foi_ajustado_manualmente'])!,
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $AlocacoesTalhaoTable createAlias(String alias) {
    return $AlocacoesTalhaoTable(attachedDatabase, alias);
  }
}

class AlocacoesTalhaoData extends DataClass
    implements Insertable<AlocacoesTalhaoData> {
  final String uid;
  final String? userId;
  final String produtoAplicacaoId;
  final String talhaoId;
  final double quantidadeAlocada;
  final String origemEscopoId;
  final DateTime dataLancamento;
  final bool foiAjustadoManualmente;
  final String syncState;
  final DateTime? deletedAt;
  const AlocacoesTalhaoData(
      {required this.uid,
      this.userId,
      required this.produtoAplicacaoId,
      required this.talhaoId,
      required this.quantidadeAlocada,
      required this.origemEscopoId,
      required this.dataLancamento,
      required this.foiAjustadoManualmente,
      required this.syncState,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['produto_aplicacao_id'] = Variable<String>(produtoAplicacaoId);
    map['talhao_id'] = Variable<String>(talhaoId);
    map['quantidade_alocada'] = Variable<double>(quantidadeAlocada);
    map['origem_escopo_id'] = Variable<String>(origemEscopoId);
    map['data_lancamento'] = Variable<DateTime>(dataLancamento);
    map['foi_ajustado_manualmente'] = Variable<bool>(foiAjustadoManualmente);
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  AlocacoesTalhaoCompanion toCompanion(bool nullToAbsent) {
    return AlocacoesTalhaoCompanion(
      uid: Value(uid),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      produtoAplicacaoId: Value(produtoAplicacaoId),
      talhaoId: Value(talhaoId),
      quantidadeAlocada: Value(quantidadeAlocada),
      origemEscopoId: Value(origemEscopoId),
      dataLancamento: Value(dataLancamento),
      foiAjustadoManualmente: Value(foiAjustadoManualmente),
      syncState: Value(syncState),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory AlocacoesTalhaoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlocacoesTalhaoData(
      uid: serializer.fromJson<String>(json['uid']),
      userId: serializer.fromJson<String?>(json['userId']),
      produtoAplicacaoId:
          serializer.fromJson<String>(json['produtoAplicacaoId']),
      talhaoId: serializer.fromJson<String>(json['talhaoId']),
      quantidadeAlocada: serializer.fromJson<double>(json['quantidadeAlocada']),
      origemEscopoId: serializer.fromJson<String>(json['origemEscopoId']),
      dataLancamento: serializer.fromJson<DateTime>(json['dataLancamento']),
      foiAjustadoManualmente:
          serializer.fromJson<bool>(json['foiAjustadoManualmente']),
      syncState: serializer.fromJson<String>(json['syncState']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'userId': serializer.toJson<String?>(userId),
      'produtoAplicacaoId': serializer.toJson<String>(produtoAplicacaoId),
      'talhaoId': serializer.toJson<String>(talhaoId),
      'quantidadeAlocada': serializer.toJson<double>(quantidadeAlocada),
      'origemEscopoId': serializer.toJson<String>(origemEscopoId),
      'dataLancamento': serializer.toJson<DateTime>(dataLancamento),
      'foiAjustadoManualmente': serializer.toJson<bool>(foiAjustadoManualmente),
      'syncState': serializer.toJson<String>(syncState),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  AlocacoesTalhaoData copyWith(
          {String? uid,
          Value<String?> userId = const Value.absent(),
          String? produtoAplicacaoId,
          String? talhaoId,
          double? quantidadeAlocada,
          String? origemEscopoId,
          DateTime? dataLancamento,
          bool? foiAjustadoManualmente,
          String? syncState,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      AlocacoesTalhaoData(
        uid: uid ?? this.uid,
        userId: userId.present ? userId.value : this.userId,
        produtoAplicacaoId: produtoAplicacaoId ?? this.produtoAplicacaoId,
        talhaoId: talhaoId ?? this.talhaoId,
        quantidadeAlocada: quantidadeAlocada ?? this.quantidadeAlocada,
        origemEscopoId: origemEscopoId ?? this.origemEscopoId,
        dataLancamento: dataLancamento ?? this.dataLancamento,
        foiAjustadoManualmente:
            foiAjustadoManualmente ?? this.foiAjustadoManualmente,
        syncState: syncState ?? this.syncState,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  AlocacoesTalhaoData copyWithCompanion(AlocacoesTalhaoCompanion data) {
    return AlocacoesTalhaoData(
      uid: data.uid.present ? data.uid.value : this.uid,
      userId: data.userId.present ? data.userId.value : this.userId,
      produtoAplicacaoId: data.produtoAplicacaoId.present
          ? data.produtoAplicacaoId.value
          : this.produtoAplicacaoId,
      talhaoId: data.talhaoId.present ? data.talhaoId.value : this.talhaoId,
      quantidadeAlocada: data.quantidadeAlocada.present
          ? data.quantidadeAlocada.value
          : this.quantidadeAlocada,
      origemEscopoId: data.origemEscopoId.present
          ? data.origemEscopoId.value
          : this.origemEscopoId,
      dataLancamento: data.dataLancamento.present
          ? data.dataLancamento.value
          : this.dataLancamento,
      foiAjustadoManualmente: data.foiAjustadoManualmente.present
          ? data.foiAjustadoManualmente.value
          : this.foiAjustadoManualmente,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlocacoesTalhaoData(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('produtoAplicacaoId: $produtoAplicacaoId, ')
          ..write('talhaoId: $talhaoId, ')
          ..write('quantidadeAlocada: $quantidadeAlocada, ')
          ..write('origemEscopoId: $origemEscopoId, ')
          ..write('dataLancamento: $dataLancamento, ')
          ..write('foiAjustadoManualmente: $foiAjustadoManualmente, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      uid,
      userId,
      produtoAplicacaoId,
      talhaoId,
      quantidadeAlocada,
      origemEscopoId,
      dataLancamento,
      foiAjustadoManualmente,
      syncState,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlocacoesTalhaoData &&
          other.uid == this.uid &&
          other.userId == this.userId &&
          other.produtoAplicacaoId == this.produtoAplicacaoId &&
          other.talhaoId == this.talhaoId &&
          other.quantidadeAlocada == this.quantidadeAlocada &&
          other.origemEscopoId == this.origemEscopoId &&
          other.dataLancamento == this.dataLancamento &&
          other.foiAjustadoManualmente == this.foiAjustadoManualmente &&
          other.syncState == this.syncState &&
          other.deletedAt == this.deletedAt);
}

class AlocacoesTalhaoCompanion extends UpdateCompanion<AlocacoesTalhaoData> {
  final Value<String> uid;
  final Value<String?> userId;
  final Value<String> produtoAplicacaoId;
  final Value<String> talhaoId;
  final Value<double> quantidadeAlocada;
  final Value<String> origemEscopoId;
  final Value<DateTime> dataLancamento;
  final Value<bool> foiAjustadoManualmente;
  final Value<String> syncState;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const AlocacoesTalhaoCompanion({
    this.uid = const Value.absent(),
    this.userId = const Value.absent(),
    this.produtoAplicacaoId = const Value.absent(),
    this.talhaoId = const Value.absent(),
    this.quantidadeAlocada = const Value.absent(),
    this.origemEscopoId = const Value.absent(),
    this.dataLancamento = const Value.absent(),
    this.foiAjustadoManualmente = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlocacoesTalhaoCompanion.insert({
    required String uid,
    this.userId = const Value.absent(),
    required String produtoAplicacaoId,
    required String talhaoId,
    required double quantidadeAlocada,
    required String origemEscopoId,
    required DateTime dataLancamento,
    this.foiAjustadoManualmente = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        produtoAplicacaoId = Value(produtoAplicacaoId),
        talhaoId = Value(talhaoId),
        quantidadeAlocada = Value(quantidadeAlocada),
        origemEscopoId = Value(origemEscopoId),
        dataLancamento = Value(dataLancamento);
  static Insertable<AlocacoesTalhaoData> custom({
    Expression<String>? uid,
    Expression<String>? userId,
    Expression<String>? produtoAplicacaoId,
    Expression<String>? talhaoId,
    Expression<double>? quantidadeAlocada,
    Expression<String>? origemEscopoId,
    Expression<DateTime>? dataLancamento,
    Expression<bool>? foiAjustadoManualmente,
    Expression<String>? syncState,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (userId != null) 'user_id': userId,
      if (produtoAplicacaoId != null)
        'produto_aplicacao_id': produtoAplicacaoId,
      if (talhaoId != null) 'talhao_id': talhaoId,
      if (quantidadeAlocada != null) 'quantidade_alocada': quantidadeAlocada,
      if (origemEscopoId != null) 'origem_escopo_id': origemEscopoId,
      if (dataLancamento != null) 'data_lancamento': dataLancamento,
      if (foiAjustadoManualmente != null)
        'foi_ajustado_manualmente': foiAjustadoManualmente,
      if (syncState != null) 'sync_state': syncState,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlocacoesTalhaoCompanion copyWith(
      {Value<String>? uid,
      Value<String?>? userId,
      Value<String>? produtoAplicacaoId,
      Value<String>? talhaoId,
      Value<double>? quantidadeAlocada,
      Value<String>? origemEscopoId,
      Value<DateTime>? dataLancamento,
      Value<bool>? foiAjustadoManualmente,
      Value<String>? syncState,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return AlocacoesTalhaoCompanion(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      produtoAplicacaoId: produtoAplicacaoId ?? this.produtoAplicacaoId,
      talhaoId: talhaoId ?? this.talhaoId,
      quantidadeAlocada: quantidadeAlocada ?? this.quantidadeAlocada,
      origemEscopoId: origemEscopoId ?? this.origemEscopoId,
      dataLancamento: dataLancamento ?? this.dataLancamento,
      foiAjustadoManualmente:
          foiAjustadoManualmente ?? this.foiAjustadoManualmente,
      syncState: syncState ?? this.syncState,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (produtoAplicacaoId.present) {
      map['produto_aplicacao_id'] = Variable<String>(produtoAplicacaoId.value);
    }
    if (talhaoId.present) {
      map['talhao_id'] = Variable<String>(talhaoId.value);
    }
    if (quantidadeAlocada.present) {
      map['quantidade_alocada'] = Variable<double>(quantidadeAlocada.value);
    }
    if (origemEscopoId.present) {
      map['origem_escopo_id'] = Variable<String>(origemEscopoId.value);
    }
    if (dataLancamento.present) {
      map['data_lancamento'] = Variable<DateTime>(dataLancamento.value);
    }
    if (foiAjustadoManualmente.present) {
      map['foi_ajustado_manualmente'] =
          Variable<bool>(foiAjustadoManualmente.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlocacoesTalhaoCompanion(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('produtoAplicacaoId: $produtoAplicacaoId, ')
          ..write('talhaoId: $talhaoId, ')
          ..write('quantidadeAlocada: $quantidadeAlocada, ')
          ..write('origemEscopoId: $origemEscopoId, ')
          ..write('dataLancamento: $dataLancamento, ')
          ..write('foiAjustadoManualmente: $foiAjustadoManualmente, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SementesTalhaoTable extends SementesTalhao
    with TableInfo<$SementesTalhaoTable, SementesTalhaoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SementesTalhaoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _planoIdMeta =
      const VerificationMeta('planoId');
  @override
  late final GeneratedColumn<String> planoId = GeneratedColumn<String>(
      'plano_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES planos (uid) ON DELETE CASCADE'));
  static const VerificationMeta _estadioIdMeta =
      const VerificationMeta('estadioId');
  @override
  late final GeneratedColumn<String> estadioId = GeneratedColumn<String>(
      'estadio_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES estadios (uid) ON DELETE CASCADE'));
  static const VerificationMeta _talhaoIdMeta =
      const VerificationMeta('talhaoId');
  @override
  late final GeneratedColumn<String> talhaoId = GeneratedColumn<String>(
      'talhao_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES talhoes (uid) ON DELETE CASCADE'));
  static const VerificationMeta _cultivarMeta =
      const VerificationMeta('cultivar');
  @override
  late final GeneratedColumn<String> cultivar = GeneratedColumn<String>(
      'cultivar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _populacaoSementesPorHaMeta =
      const VerificationMeta('populacaoSementesPorHa');
  @override
  late final GeneratedColumn<double> populacaoSementesPorHa =
      GeneratedColumn<double>('populacao_sementes_por_ha', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _sementesPorEmbalagemMeta =
      const VerificationMeta('sementesPorEmbalagem');
  @override
  late final GeneratedColumn<int> sementesPorEmbalagem = GeneratedColumn<int>(
      'sementes_por_embalagem', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _espacamentoPlantioCmMeta =
      const VerificationMeta('espacamentoPlantioCm');
  @override
  late final GeneratedColumn<double> espacamentoPlantioCm =
      GeneratedColumn<double>('espacamento_plantio_cm', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _embalagensManualMeta =
      const VerificationMeta('embalagensManual');
  @override
  late final GeneratedColumn<int> embalagensManual = GeneratedColumn<int>(
      'embalagens_manual', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        userId,
        planoId,
        estadioId,
        talhaoId,
        cultivar,
        populacaoSementesPorHa,
        sementesPorEmbalagem,
        espacamentoPlantioCm,
        embalagensManual,
        createdAt,
        updatedAt,
        syncState,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sementes_talhao';
  @override
  VerificationContext validateIntegrity(Insertable<SementesTalhaoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('plano_id')) {
      context.handle(_planoIdMeta,
          planoId.isAcceptableOrUnknown(data['plano_id']!, _planoIdMeta));
    } else if (isInserting) {
      context.missing(_planoIdMeta);
    }
    if (data.containsKey('estadio_id')) {
      context.handle(_estadioIdMeta,
          estadioId.isAcceptableOrUnknown(data['estadio_id']!, _estadioIdMeta));
    } else if (isInserting) {
      context.missing(_estadioIdMeta);
    }
    if (data.containsKey('talhao_id')) {
      context.handle(_talhaoIdMeta,
          talhaoId.isAcceptableOrUnknown(data['talhao_id']!, _talhaoIdMeta));
    }
    if (data.containsKey('cultivar')) {
      context.handle(_cultivarMeta,
          cultivar.isAcceptableOrUnknown(data['cultivar']!, _cultivarMeta));
    } else if (isInserting) {
      context.missing(_cultivarMeta);
    }
    if (data.containsKey('populacao_sementes_por_ha')) {
      context.handle(
          _populacaoSementesPorHaMeta,
          populacaoSementesPorHa.isAcceptableOrUnknown(
              data['populacao_sementes_por_ha']!, _populacaoSementesPorHaMeta));
    } else if (isInserting) {
      context.missing(_populacaoSementesPorHaMeta);
    }
    if (data.containsKey('sementes_por_embalagem')) {
      context.handle(
          _sementesPorEmbalagemMeta,
          sementesPorEmbalagem.isAcceptableOrUnknown(
              data['sementes_por_embalagem']!, _sementesPorEmbalagemMeta));
    } else if (isInserting) {
      context.missing(_sementesPorEmbalagemMeta);
    }
    if (data.containsKey('espacamento_plantio_cm')) {
      context.handle(
          _espacamentoPlantioCmMeta,
          espacamentoPlantioCm.isAcceptableOrUnknown(
              data['espacamento_plantio_cm']!, _espacamentoPlantioCmMeta));
    } else if (isInserting) {
      context.missing(_espacamentoPlantioCmMeta);
    }
    if (data.containsKey('embalagens_manual')) {
      context.handle(
          _embalagensManualMeta,
          embalagensManual.isAcceptableOrUnknown(
              data['embalagens_manual']!, _embalagensManualMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  SementesTalhaoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SementesTalhaoData(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      planoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plano_id'])!,
      estadioId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estadio_id'])!,
      talhaoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}talhao_id']),
      cultivar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cultivar'])!,
      populacaoSementesPorHa: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}populacao_sementes_por_ha'])!,
      sementesPorEmbalagem: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}sementes_por_embalagem'])!,
      espacamentoPlantioCm: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}espacamento_plantio_cm'])!,
      embalagensManual: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}embalagens_manual']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $SementesTalhaoTable createAlias(String alias) {
    return $SementesTalhaoTable(attachedDatabase, alias);
  }
}

class SementesTalhaoData extends DataClass
    implements Insertable<SementesTalhaoData> {
  final String uid;
  final String? userId;
  final String planoId;
  final String estadioId;
  final String? talhaoId;
  final String cultivar;
  final double populacaoSementesPorHa;
  final int sementesPorEmbalagem;
  final double espacamentoPlantioCm;
  final int? embalagensManual;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncState;
  final DateTime? deletedAt;
  const SementesTalhaoData(
      {required this.uid,
      this.userId,
      required this.planoId,
      required this.estadioId,
      this.talhaoId,
      required this.cultivar,
      required this.populacaoSementesPorHa,
      required this.sementesPorEmbalagem,
      required this.espacamentoPlantioCm,
      this.embalagensManual,
      required this.createdAt,
      required this.updatedAt,
      required this.syncState,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['plano_id'] = Variable<String>(planoId);
    map['estadio_id'] = Variable<String>(estadioId);
    if (!nullToAbsent || talhaoId != null) {
      map['talhao_id'] = Variable<String>(talhaoId);
    }
    map['cultivar'] = Variable<String>(cultivar);
    map['populacao_sementes_por_ha'] = Variable<double>(populacaoSementesPorHa);
    map['sementes_por_embalagem'] = Variable<int>(sementesPorEmbalagem);
    map['espacamento_plantio_cm'] = Variable<double>(espacamentoPlantioCm);
    if (!nullToAbsent || embalagensManual != null) {
      map['embalagens_manual'] = Variable<int>(embalagensManual);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  SementesTalhaoCompanion toCompanion(bool nullToAbsent) {
    return SementesTalhaoCompanion(
      uid: Value(uid),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      planoId: Value(planoId),
      estadioId: Value(estadioId),
      talhaoId: talhaoId == null && nullToAbsent
          ? const Value.absent()
          : Value(talhaoId),
      cultivar: Value(cultivar),
      populacaoSementesPorHa: Value(populacaoSementesPorHa),
      sementesPorEmbalagem: Value(sementesPorEmbalagem),
      espacamentoPlantioCm: Value(espacamentoPlantioCm),
      embalagensManual: embalagensManual == null && nullToAbsent
          ? const Value.absent()
          : Value(embalagensManual),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncState: Value(syncState),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory SementesTalhaoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SementesTalhaoData(
      uid: serializer.fromJson<String>(json['uid']),
      userId: serializer.fromJson<String?>(json['userId']),
      planoId: serializer.fromJson<String>(json['planoId']),
      estadioId: serializer.fromJson<String>(json['estadioId']),
      talhaoId: serializer.fromJson<String?>(json['talhaoId']),
      cultivar: serializer.fromJson<String>(json['cultivar']),
      populacaoSementesPorHa:
          serializer.fromJson<double>(json['populacaoSementesPorHa']),
      sementesPorEmbalagem:
          serializer.fromJson<int>(json['sementesPorEmbalagem']),
      espacamentoPlantioCm:
          serializer.fromJson<double>(json['espacamentoPlantioCm']),
      embalagensManual: serializer.fromJson<int?>(json['embalagensManual']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'userId': serializer.toJson<String?>(userId),
      'planoId': serializer.toJson<String>(planoId),
      'estadioId': serializer.toJson<String>(estadioId),
      'talhaoId': serializer.toJson<String?>(talhaoId),
      'cultivar': serializer.toJson<String>(cultivar),
      'populacaoSementesPorHa':
          serializer.toJson<double>(populacaoSementesPorHa),
      'sementesPorEmbalagem': serializer.toJson<int>(sementesPorEmbalagem),
      'espacamentoPlantioCm': serializer.toJson<double>(espacamentoPlantioCm),
      'embalagensManual': serializer.toJson<int?>(embalagensManual),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncState': serializer.toJson<String>(syncState),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  SementesTalhaoData copyWith(
          {String? uid,
          Value<String?> userId = const Value.absent(),
          String? planoId,
          String? estadioId,
          Value<String?> talhaoId = const Value.absent(),
          String? cultivar,
          double? populacaoSementesPorHa,
          int? sementesPorEmbalagem,
          double? espacamentoPlantioCm,
          Value<int?> embalagensManual = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncState,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      SementesTalhaoData(
        uid: uid ?? this.uid,
        userId: userId.present ? userId.value : this.userId,
        planoId: planoId ?? this.planoId,
        estadioId: estadioId ?? this.estadioId,
        talhaoId: talhaoId.present ? talhaoId.value : this.talhaoId,
        cultivar: cultivar ?? this.cultivar,
        populacaoSementesPorHa:
            populacaoSementesPorHa ?? this.populacaoSementesPorHa,
        sementesPorEmbalagem: sementesPorEmbalagem ?? this.sementesPorEmbalagem,
        espacamentoPlantioCm: espacamentoPlantioCm ?? this.espacamentoPlantioCm,
        embalagensManual: embalagensManual.present
            ? embalagensManual.value
            : this.embalagensManual,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncState: syncState ?? this.syncState,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  SementesTalhaoData copyWithCompanion(SementesTalhaoCompanion data) {
    return SementesTalhaoData(
      uid: data.uid.present ? data.uid.value : this.uid,
      userId: data.userId.present ? data.userId.value : this.userId,
      planoId: data.planoId.present ? data.planoId.value : this.planoId,
      estadioId: data.estadioId.present ? data.estadioId.value : this.estadioId,
      talhaoId: data.talhaoId.present ? data.talhaoId.value : this.talhaoId,
      cultivar: data.cultivar.present ? data.cultivar.value : this.cultivar,
      populacaoSementesPorHa: data.populacaoSementesPorHa.present
          ? data.populacaoSementesPorHa.value
          : this.populacaoSementesPorHa,
      sementesPorEmbalagem: data.sementesPorEmbalagem.present
          ? data.sementesPorEmbalagem.value
          : this.sementesPorEmbalagem,
      espacamentoPlantioCm: data.espacamentoPlantioCm.present
          ? data.espacamentoPlantioCm.value
          : this.espacamentoPlantioCm,
      embalagensManual: data.embalagensManual.present
          ? data.embalagensManual.value
          : this.embalagensManual,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SementesTalhaoData(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('planoId: $planoId, ')
          ..write('estadioId: $estadioId, ')
          ..write('talhaoId: $talhaoId, ')
          ..write('cultivar: $cultivar, ')
          ..write('populacaoSementesPorHa: $populacaoSementesPorHa, ')
          ..write('sementesPorEmbalagem: $sementesPorEmbalagem, ')
          ..write('espacamentoPlantioCm: $espacamentoPlantioCm, ')
          ..write('embalagensManual: $embalagensManual, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      uid,
      userId,
      planoId,
      estadioId,
      talhaoId,
      cultivar,
      populacaoSementesPorHa,
      sementesPorEmbalagem,
      espacamentoPlantioCm,
      embalagensManual,
      createdAt,
      updatedAt,
      syncState,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SementesTalhaoData &&
          other.uid == this.uid &&
          other.userId == this.userId &&
          other.planoId == this.planoId &&
          other.estadioId == this.estadioId &&
          other.talhaoId == this.talhaoId &&
          other.cultivar == this.cultivar &&
          other.populacaoSementesPorHa == this.populacaoSementesPorHa &&
          other.sementesPorEmbalagem == this.sementesPorEmbalagem &&
          other.espacamentoPlantioCm == this.espacamentoPlantioCm &&
          other.embalagensManual == this.embalagensManual &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncState == this.syncState &&
          other.deletedAt == this.deletedAt);
}

class SementesTalhaoCompanion extends UpdateCompanion<SementesTalhaoData> {
  final Value<String> uid;
  final Value<String?> userId;
  final Value<String> planoId;
  final Value<String> estadioId;
  final Value<String?> talhaoId;
  final Value<String> cultivar;
  final Value<double> populacaoSementesPorHa;
  final Value<int> sementesPorEmbalagem;
  final Value<double> espacamentoPlantioCm;
  final Value<int?> embalagensManual;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncState;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const SementesTalhaoCompanion({
    this.uid = const Value.absent(),
    this.userId = const Value.absent(),
    this.planoId = const Value.absent(),
    this.estadioId = const Value.absent(),
    this.talhaoId = const Value.absent(),
    this.cultivar = const Value.absent(),
    this.populacaoSementesPorHa = const Value.absent(),
    this.sementesPorEmbalagem = const Value.absent(),
    this.espacamentoPlantioCm = const Value.absent(),
    this.embalagensManual = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SementesTalhaoCompanion.insert({
    required String uid,
    this.userId = const Value.absent(),
    required String planoId,
    required String estadioId,
    this.talhaoId = const Value.absent(),
    required String cultivar,
    required double populacaoSementesPorHa,
    required int sementesPorEmbalagem,
    required double espacamentoPlantioCm,
    this.embalagensManual = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        planoId = Value(planoId),
        estadioId = Value(estadioId),
        cultivar = Value(cultivar),
        populacaoSementesPorHa = Value(populacaoSementesPorHa),
        sementesPorEmbalagem = Value(sementesPorEmbalagem),
        espacamentoPlantioCm = Value(espacamentoPlantioCm),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<SementesTalhaoData> custom({
    Expression<String>? uid,
    Expression<String>? userId,
    Expression<String>? planoId,
    Expression<String>? estadioId,
    Expression<String>? talhaoId,
    Expression<String>? cultivar,
    Expression<double>? populacaoSementesPorHa,
    Expression<int>? sementesPorEmbalagem,
    Expression<double>? espacamentoPlantioCm,
    Expression<int>? embalagensManual,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncState,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (userId != null) 'user_id': userId,
      if (planoId != null) 'plano_id': planoId,
      if (estadioId != null) 'estadio_id': estadioId,
      if (talhaoId != null) 'talhao_id': talhaoId,
      if (cultivar != null) 'cultivar': cultivar,
      if (populacaoSementesPorHa != null)
        'populacao_sementes_por_ha': populacaoSementesPorHa,
      if (sementesPorEmbalagem != null)
        'sementes_por_embalagem': sementesPorEmbalagem,
      if (espacamentoPlantioCm != null)
        'espacamento_plantio_cm': espacamentoPlantioCm,
      if (embalagensManual != null) 'embalagens_manual': embalagensManual,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncState != null) 'sync_state': syncState,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SementesTalhaoCompanion copyWith(
      {Value<String>? uid,
      Value<String?>? userId,
      Value<String>? planoId,
      Value<String>? estadioId,
      Value<String?>? talhaoId,
      Value<String>? cultivar,
      Value<double>? populacaoSementesPorHa,
      Value<int>? sementesPorEmbalagem,
      Value<double>? espacamentoPlantioCm,
      Value<int?>? embalagensManual,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncState,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return SementesTalhaoCompanion(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      planoId: planoId ?? this.planoId,
      estadioId: estadioId ?? this.estadioId,
      talhaoId: talhaoId ?? this.talhaoId,
      cultivar: cultivar ?? this.cultivar,
      populacaoSementesPorHa:
          populacaoSementesPorHa ?? this.populacaoSementesPorHa,
      sementesPorEmbalagem: sementesPorEmbalagem ?? this.sementesPorEmbalagem,
      espacamentoPlantioCm: espacamentoPlantioCm ?? this.espacamentoPlantioCm,
      embalagensManual: embalagensManual ?? this.embalagensManual,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncState: syncState ?? this.syncState,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (planoId.present) {
      map['plano_id'] = Variable<String>(planoId.value);
    }
    if (estadioId.present) {
      map['estadio_id'] = Variable<String>(estadioId.value);
    }
    if (talhaoId.present) {
      map['talhao_id'] = Variable<String>(talhaoId.value);
    }
    if (cultivar.present) {
      map['cultivar'] = Variable<String>(cultivar.value);
    }
    if (populacaoSementesPorHa.present) {
      map['populacao_sementes_por_ha'] =
          Variable<double>(populacaoSementesPorHa.value);
    }
    if (sementesPorEmbalagem.present) {
      map['sementes_por_embalagem'] = Variable<int>(sementesPorEmbalagem.value);
    }
    if (espacamentoPlantioCm.present) {
      map['espacamento_plantio_cm'] =
          Variable<double>(espacamentoPlantioCm.value);
    }
    if (embalagensManual.present) {
      map['embalagens_manual'] = Variable<int>(embalagensManual.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SementesTalhaoCompanion(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('planoId: $planoId, ')
          ..write('estadioId: $estadioId, ')
          ..write('talhaoId: $talhaoId, ')
          ..write('cultivar: $cultivar, ')
          ..write('populacaoSementesPorHa: $populacaoSementesPorHa, ')
          ..write('sementesPorEmbalagem: $sementesPorEmbalagem, ')
          ..write('espacamentoPlantioCm: $espacamentoPlantioCm, ')
          ..write('embalagensManual: $embalagensManual, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CronogramasSojaTalhaoTable extends CronogramasSojaTalhao
    with TableInfo<$CronogramasSojaTalhaoTable, CronogramasSojaTalhaoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CronogramasSojaTalhaoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _talhaoIdMeta =
      const VerificationMeta('talhaoId');
  @override
  late final GeneratedColumn<String> talhaoId = GeneratedColumn<String>(
      'talhao_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES talhoes (uid) ON DELETE CASCADE'));
  static const VerificationMeta _culturaMeta =
      const VerificationMeta('cultura');
  @override
  late final GeneratedColumn<String> cultura = GeneratedColumn<String>(
      'cultura', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _materialCultivarMeta =
      const VerificationMeta('materialCultivar');
  @override
  late final GeneratedColumn<String> materialCultivar = GeneratedColumn<String>(
      'material_cultivar', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _dataPlantioMeta =
      const VerificationMeta('dataPlantio');
  @override
  late final GeneratedColumn<DateTime> dataPlantio = GeneratedColumn<DateTime>(
      'data_plantio', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _diasEmergenciaMeta =
      const VerificationMeta('diasEmergencia');
  @override
  late final GeneratedColumn<int> diasEmergencia = GeneratedColumn<int>(
      'dias_emergencia', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(5));
  static const VerificationMeta _daePosEmergenteMeta =
      const VerificationMeta('daePosEmergente');
  @override
  late final GeneratedColumn<int> daePosEmergente = GeneratedColumn<int>(
      'dae_pos_emergente', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(25));
  static const VerificationMeta _diasRecuperacaoPosEmergenteMeta =
      const VerificationMeta('diasRecuperacaoPosEmergente');
  @override
  late final GeneratedColumn<int> diasRecuperacaoPosEmergente =
      GeneratedColumn<int>('dias_recuperacao_pos_emergente', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(5));
  static const VerificationMeta _intervaloFungicidaDiasMeta =
      const VerificationMeta('intervaloFungicidaDias');
  @override
  late final GeneratedColumn<int> intervaloFungicidaDias = GeneratedColumn<int>(
      'intervalo_fungicida_dias', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(15));
  static const VerificationMeta _totalAplicacoesFungicidaMeta =
      const VerificationMeta('totalAplicacoesFungicida');
  @override
  late final GeneratedColumn<int> totalAplicacoesFungicida =
      GeneratedColumn<int>('total_aplicacoes_fungicida', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(4));
  static const VerificationMeta _daeMaturacaoCicloMeta =
      const VerificationMeta('daeMaturacaoCiclo');
  @override
  late final GeneratedColumn<int> daeMaturacaoCiclo = GeneratedColumn<int>(
      'dae_maturacao_ciclo', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(110));
  static const VerificationMeta _diasAntesR8DessecanteMeta =
      const VerificationMeta('diasAntesR8Dessecante');
  @override
  late final GeneratedColumn<int> diasAntesR8Dessecante = GeneratedColumn<int>(
      'dias_antes_r8_dessecante', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(12));
  static const VerificationMeta _diasAntecipacaoColheitaRealMeta =
      const VerificationMeta('diasAntecipacaoColheitaReal');
  @override
  late final GeneratedColumn<int> diasAntecipacaoColheitaReal =
      GeneratedColumn<int>('dias_antecipacao_colheita_real', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(5));
  static const VerificationMeta _diasDessecacaoPrePlantioMeta =
      const VerificationMeta('diasDessecacaoPrePlantio');
  @override
  late final GeneratedColumn<int> diasDessecacaoPrePlantio =
      GeneratedColumn<int>('dias_dessecacao_pre_plantio', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(15));
  static const VerificationMeta _grupoRegulagemIdMeta =
      const VerificationMeta('grupoRegulagemId');
  @override
  late final GeneratedColumn<String> grupoRegulagemId = GeneratedColumn<String>(
      'grupo_regulagem_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _plantioDefinidoMeta =
      const VerificationMeta('plantioDefinido');
  @override
  late final GeneratedColumn<bool> plantioDefinido = GeneratedColumn<bool>(
      'plantio_definido', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("plantio_definido" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _ordemMeta = const VerificationMeta('ordem');
  @override
  late final GeneratedColumn<int> ordem = GeneratedColumn<int>(
      'ordem', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        userId,
        talhaoId,
        cultura,
        materialCultivar,
        dataPlantio,
        diasEmergencia,
        daePosEmergente,
        diasRecuperacaoPosEmergente,
        intervaloFungicidaDias,
        totalAplicacoesFungicida,
        daeMaturacaoCiclo,
        diasAntesR8Dessecante,
        diasAntecipacaoColheitaReal,
        diasDessecacaoPrePlantio,
        grupoRegulagemId,
        plantioDefinido,
        ordem,
        createdAt,
        updatedAt,
        syncState,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cronogramas_soja_talhao';
  @override
  VerificationContext validateIntegrity(
      Insertable<CronogramasSojaTalhaoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('talhao_id')) {
      context.handle(_talhaoIdMeta,
          talhaoId.isAcceptableOrUnknown(data['talhao_id']!, _talhaoIdMeta));
    } else if (isInserting) {
      context.missing(_talhaoIdMeta);
    }
    if (data.containsKey('cultura')) {
      context.handle(_culturaMeta,
          cultura.isAcceptableOrUnknown(data['cultura']!, _culturaMeta));
    } else if (isInserting) {
      context.missing(_culturaMeta);
    }
    if (data.containsKey('material_cultivar')) {
      context.handle(
          _materialCultivarMeta,
          materialCultivar.isAcceptableOrUnknown(
              data['material_cultivar']!, _materialCultivarMeta));
    }
    if (data.containsKey('data_plantio')) {
      context.handle(
          _dataPlantioMeta,
          dataPlantio.isAcceptableOrUnknown(
              data['data_plantio']!, _dataPlantioMeta));
    } else if (isInserting) {
      context.missing(_dataPlantioMeta);
    }
    if (data.containsKey('dias_emergencia')) {
      context.handle(
          _diasEmergenciaMeta,
          diasEmergencia.isAcceptableOrUnknown(
              data['dias_emergencia']!, _diasEmergenciaMeta));
    }
    if (data.containsKey('dae_pos_emergente')) {
      context.handle(
          _daePosEmergenteMeta,
          daePosEmergente.isAcceptableOrUnknown(
              data['dae_pos_emergente']!, _daePosEmergenteMeta));
    }
    if (data.containsKey('dias_recuperacao_pos_emergente')) {
      context.handle(
          _diasRecuperacaoPosEmergenteMeta,
          diasRecuperacaoPosEmergente.isAcceptableOrUnknown(
              data['dias_recuperacao_pos_emergente']!,
              _diasRecuperacaoPosEmergenteMeta));
    }
    if (data.containsKey('intervalo_fungicida_dias')) {
      context.handle(
          _intervaloFungicidaDiasMeta,
          intervaloFungicidaDias.isAcceptableOrUnknown(
              data['intervalo_fungicida_dias']!, _intervaloFungicidaDiasMeta));
    }
    if (data.containsKey('total_aplicacoes_fungicida')) {
      context.handle(
          _totalAplicacoesFungicidaMeta,
          totalAplicacoesFungicida.isAcceptableOrUnknown(
              data['total_aplicacoes_fungicida']!,
              _totalAplicacoesFungicidaMeta));
    }
    if (data.containsKey('dae_maturacao_ciclo')) {
      context.handle(
          _daeMaturacaoCicloMeta,
          daeMaturacaoCiclo.isAcceptableOrUnknown(
              data['dae_maturacao_ciclo']!, _daeMaturacaoCicloMeta));
    }
    if (data.containsKey('dias_antes_r8_dessecante')) {
      context.handle(
          _diasAntesR8DessecanteMeta,
          diasAntesR8Dessecante.isAcceptableOrUnknown(
              data['dias_antes_r8_dessecante']!, _diasAntesR8DessecanteMeta));
    }
    if (data.containsKey('dias_antecipacao_colheita_real')) {
      context.handle(
          _diasAntecipacaoColheitaRealMeta,
          diasAntecipacaoColheitaReal.isAcceptableOrUnknown(
              data['dias_antecipacao_colheita_real']!,
              _diasAntecipacaoColheitaRealMeta));
    }
    if (data.containsKey('dias_dessecacao_pre_plantio')) {
      context.handle(
          _diasDessecacaoPrePlantioMeta,
          diasDessecacaoPrePlantio.isAcceptableOrUnknown(
              data['dias_dessecacao_pre_plantio']!,
              _diasDessecacaoPrePlantioMeta));
    }
    if (data.containsKey('grupo_regulagem_id')) {
      context.handle(
          _grupoRegulagemIdMeta,
          grupoRegulagemId.isAcceptableOrUnknown(
              data['grupo_regulagem_id']!, _grupoRegulagemIdMeta));
    }
    if (data.containsKey('plantio_definido')) {
      context.handle(
          _plantioDefinidoMeta,
          plantioDefinido.isAcceptableOrUnknown(
              data['plantio_definido']!, _plantioDefinidoMeta));
    }
    if (data.containsKey('ordem')) {
      context.handle(
          _ordemMeta, ordem.isAcceptableOrUnknown(data['ordem']!, _ordemMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  CronogramasSojaTalhaoData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CronogramasSojaTalhaoData(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      talhaoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}talhao_id'])!,
      cultura: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cultura'])!,
      materialCultivar: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}material_cultivar'])!,
      dataPlantio: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_plantio'])!,
      diasEmergencia: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dias_emergencia'])!,
      daePosEmergente: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dae_pos_emergente'])!,
      diasRecuperacaoPosEmergente: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}dias_recuperacao_pos_emergente'])!,
      intervaloFungicidaDias: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}intervalo_fungicida_dias'])!,
      totalAplicacoesFungicida: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}total_aplicacoes_fungicida'])!,
      daeMaturacaoCiclo: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}dae_maturacao_ciclo'])!,
      diasAntesR8Dessecante: attachedDatabase.typeMapping.read(DriftSqlType.int,
          data['${effectivePrefix}dias_antes_r8_dessecante'])!,
      diasAntecipacaoColheitaReal: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}dias_antecipacao_colheita_real'])!,
      diasDessecacaoPrePlantio: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}dias_dessecacao_pre_plantio'])!,
      grupoRegulagemId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}grupo_regulagem_id'])!,
      plantioDefinido: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}plantio_definido'])!,
      ordem: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordem'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $CronogramasSojaTalhaoTable createAlias(String alias) {
    return $CronogramasSojaTalhaoTable(attachedDatabase, alias);
  }
}

class CronogramasSojaTalhaoData extends DataClass
    implements Insertable<CronogramasSojaTalhaoData> {
  final String uid;
  final String? userId;
  final String talhaoId;
  final String cultura;
  final String materialCultivar;
  final DateTime dataPlantio;
  final int diasEmergencia;
  final int daePosEmergente;
  final int diasRecuperacaoPosEmergente;
  final int intervaloFungicidaDias;
  final int totalAplicacoesFungicida;
  final int daeMaturacaoCiclo;
  final int diasAntesR8Dessecante;
  final int diasAntecipacaoColheitaReal;
  final int diasDessecacaoPrePlantio;
  final String grupoRegulagemId;
  final bool plantioDefinido;
  final int ordem;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncState;
  final DateTime? deletedAt;
  const CronogramasSojaTalhaoData(
      {required this.uid,
      this.userId,
      required this.talhaoId,
      required this.cultura,
      required this.materialCultivar,
      required this.dataPlantio,
      required this.diasEmergencia,
      required this.daePosEmergente,
      required this.diasRecuperacaoPosEmergente,
      required this.intervaloFungicidaDias,
      required this.totalAplicacoesFungicida,
      required this.daeMaturacaoCiclo,
      required this.diasAntesR8Dessecante,
      required this.diasAntecipacaoColheitaReal,
      required this.diasDessecacaoPrePlantio,
      required this.grupoRegulagemId,
      required this.plantioDefinido,
      required this.ordem,
      required this.createdAt,
      required this.updatedAt,
      required this.syncState,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['talhao_id'] = Variable<String>(talhaoId);
    map['cultura'] = Variable<String>(cultura);
    map['material_cultivar'] = Variable<String>(materialCultivar);
    map['data_plantio'] = Variable<DateTime>(dataPlantio);
    map['dias_emergencia'] = Variable<int>(diasEmergencia);
    map['dae_pos_emergente'] = Variable<int>(daePosEmergente);
    map['dias_recuperacao_pos_emergente'] =
        Variable<int>(diasRecuperacaoPosEmergente);
    map['intervalo_fungicida_dias'] = Variable<int>(intervaloFungicidaDias);
    map['total_aplicacoes_fungicida'] = Variable<int>(totalAplicacoesFungicida);
    map['dae_maturacao_ciclo'] = Variable<int>(daeMaturacaoCiclo);
    map['dias_antes_r8_dessecante'] = Variable<int>(diasAntesR8Dessecante);
    map['dias_antecipacao_colheita_real'] =
        Variable<int>(diasAntecipacaoColheitaReal);
    map['dias_dessecacao_pre_plantio'] =
        Variable<int>(diasDessecacaoPrePlantio);
    map['grupo_regulagem_id'] = Variable<String>(grupoRegulagemId);
    map['plantio_definido'] = Variable<bool>(plantioDefinido);
    map['ordem'] = Variable<int>(ordem);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  CronogramasSojaTalhaoCompanion toCompanion(bool nullToAbsent) {
    return CronogramasSojaTalhaoCompanion(
      uid: Value(uid),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      talhaoId: Value(talhaoId),
      cultura: Value(cultura),
      materialCultivar: Value(materialCultivar),
      dataPlantio: Value(dataPlantio),
      diasEmergencia: Value(diasEmergencia),
      daePosEmergente: Value(daePosEmergente),
      diasRecuperacaoPosEmergente: Value(diasRecuperacaoPosEmergente),
      intervaloFungicidaDias: Value(intervaloFungicidaDias),
      totalAplicacoesFungicida: Value(totalAplicacoesFungicida),
      daeMaturacaoCiclo: Value(daeMaturacaoCiclo),
      diasAntesR8Dessecante: Value(diasAntesR8Dessecante),
      diasAntecipacaoColheitaReal: Value(diasAntecipacaoColheitaReal),
      diasDessecacaoPrePlantio: Value(diasDessecacaoPrePlantio),
      grupoRegulagemId: Value(grupoRegulagemId),
      plantioDefinido: Value(plantioDefinido),
      ordem: Value(ordem),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncState: Value(syncState),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory CronogramasSojaTalhaoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CronogramasSojaTalhaoData(
      uid: serializer.fromJson<String>(json['uid']),
      userId: serializer.fromJson<String?>(json['userId']),
      talhaoId: serializer.fromJson<String>(json['talhaoId']),
      cultura: serializer.fromJson<String>(json['cultura']),
      materialCultivar: serializer.fromJson<String>(json['materialCultivar']),
      dataPlantio: serializer.fromJson<DateTime>(json['dataPlantio']),
      diasEmergencia: serializer.fromJson<int>(json['diasEmergencia']),
      daePosEmergente: serializer.fromJson<int>(json['daePosEmergente']),
      diasRecuperacaoPosEmergente:
          serializer.fromJson<int>(json['diasRecuperacaoPosEmergente']),
      intervaloFungicidaDias:
          serializer.fromJson<int>(json['intervaloFungicidaDias']),
      totalAplicacoesFungicida:
          serializer.fromJson<int>(json['totalAplicacoesFungicida']),
      daeMaturacaoCiclo: serializer.fromJson<int>(json['daeMaturacaoCiclo']),
      diasAntesR8Dessecante:
          serializer.fromJson<int>(json['diasAntesR8Dessecante']),
      diasAntecipacaoColheitaReal:
          serializer.fromJson<int>(json['diasAntecipacaoColheitaReal']),
      diasDessecacaoPrePlantio:
          serializer.fromJson<int>(json['diasDessecacaoPrePlantio']),
      grupoRegulagemId: serializer.fromJson<String>(json['grupoRegulagemId']),
      plantioDefinido: serializer.fromJson<bool>(json['plantioDefinido']),
      ordem: serializer.fromJson<int>(json['ordem']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'userId': serializer.toJson<String?>(userId),
      'talhaoId': serializer.toJson<String>(talhaoId),
      'cultura': serializer.toJson<String>(cultura),
      'materialCultivar': serializer.toJson<String>(materialCultivar),
      'dataPlantio': serializer.toJson<DateTime>(dataPlantio),
      'diasEmergencia': serializer.toJson<int>(diasEmergencia),
      'daePosEmergente': serializer.toJson<int>(daePosEmergente),
      'diasRecuperacaoPosEmergente':
          serializer.toJson<int>(diasRecuperacaoPosEmergente),
      'intervaloFungicidaDias': serializer.toJson<int>(intervaloFungicidaDias),
      'totalAplicacoesFungicida':
          serializer.toJson<int>(totalAplicacoesFungicida),
      'daeMaturacaoCiclo': serializer.toJson<int>(daeMaturacaoCiclo),
      'diasAntesR8Dessecante': serializer.toJson<int>(diasAntesR8Dessecante),
      'diasAntecipacaoColheitaReal':
          serializer.toJson<int>(diasAntecipacaoColheitaReal),
      'diasDessecacaoPrePlantio':
          serializer.toJson<int>(diasDessecacaoPrePlantio),
      'grupoRegulagemId': serializer.toJson<String>(grupoRegulagemId),
      'plantioDefinido': serializer.toJson<bool>(plantioDefinido),
      'ordem': serializer.toJson<int>(ordem),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncState': serializer.toJson<String>(syncState),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  CronogramasSojaTalhaoData copyWith(
          {String? uid,
          Value<String?> userId = const Value.absent(),
          String? talhaoId,
          String? cultura,
          String? materialCultivar,
          DateTime? dataPlantio,
          int? diasEmergencia,
          int? daePosEmergente,
          int? diasRecuperacaoPosEmergente,
          int? intervaloFungicidaDias,
          int? totalAplicacoesFungicida,
          int? daeMaturacaoCiclo,
          int? diasAntesR8Dessecante,
          int? diasAntecipacaoColheitaReal,
          int? diasDessecacaoPrePlantio,
          String? grupoRegulagemId,
          bool? plantioDefinido,
          int? ordem,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncState,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      CronogramasSojaTalhaoData(
        uid: uid ?? this.uid,
        userId: userId.present ? userId.value : this.userId,
        talhaoId: talhaoId ?? this.talhaoId,
        cultura: cultura ?? this.cultura,
        materialCultivar: materialCultivar ?? this.materialCultivar,
        dataPlantio: dataPlantio ?? this.dataPlantio,
        diasEmergencia: diasEmergencia ?? this.diasEmergencia,
        daePosEmergente: daePosEmergente ?? this.daePosEmergente,
        diasRecuperacaoPosEmergente:
            diasRecuperacaoPosEmergente ?? this.diasRecuperacaoPosEmergente,
        intervaloFungicidaDias:
            intervaloFungicidaDias ?? this.intervaloFungicidaDias,
        totalAplicacoesFungicida:
            totalAplicacoesFungicida ?? this.totalAplicacoesFungicida,
        daeMaturacaoCiclo: daeMaturacaoCiclo ?? this.daeMaturacaoCiclo,
        diasAntesR8Dessecante:
            diasAntesR8Dessecante ?? this.diasAntesR8Dessecante,
        diasAntecipacaoColheitaReal:
            diasAntecipacaoColheitaReal ?? this.diasAntecipacaoColheitaReal,
        diasDessecacaoPrePlantio:
            diasDessecacaoPrePlantio ?? this.diasDessecacaoPrePlantio,
        grupoRegulagemId: grupoRegulagemId ?? this.grupoRegulagemId,
        plantioDefinido: plantioDefinido ?? this.plantioDefinido,
        ordem: ordem ?? this.ordem,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncState: syncState ?? this.syncState,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  CronogramasSojaTalhaoData copyWithCompanion(
      CronogramasSojaTalhaoCompanion data) {
    return CronogramasSojaTalhaoData(
      uid: data.uid.present ? data.uid.value : this.uid,
      userId: data.userId.present ? data.userId.value : this.userId,
      talhaoId: data.talhaoId.present ? data.talhaoId.value : this.talhaoId,
      cultura: data.cultura.present ? data.cultura.value : this.cultura,
      materialCultivar: data.materialCultivar.present
          ? data.materialCultivar.value
          : this.materialCultivar,
      dataPlantio:
          data.dataPlantio.present ? data.dataPlantio.value : this.dataPlantio,
      diasEmergencia: data.diasEmergencia.present
          ? data.diasEmergencia.value
          : this.diasEmergencia,
      daePosEmergente: data.daePosEmergente.present
          ? data.daePosEmergente.value
          : this.daePosEmergente,
      diasRecuperacaoPosEmergente: data.diasRecuperacaoPosEmergente.present
          ? data.diasRecuperacaoPosEmergente.value
          : this.diasRecuperacaoPosEmergente,
      intervaloFungicidaDias: data.intervaloFungicidaDias.present
          ? data.intervaloFungicidaDias.value
          : this.intervaloFungicidaDias,
      totalAplicacoesFungicida: data.totalAplicacoesFungicida.present
          ? data.totalAplicacoesFungicida.value
          : this.totalAplicacoesFungicida,
      daeMaturacaoCiclo: data.daeMaturacaoCiclo.present
          ? data.daeMaturacaoCiclo.value
          : this.daeMaturacaoCiclo,
      diasAntesR8Dessecante: data.diasAntesR8Dessecante.present
          ? data.diasAntesR8Dessecante.value
          : this.diasAntesR8Dessecante,
      diasAntecipacaoColheitaReal: data.diasAntecipacaoColheitaReal.present
          ? data.diasAntecipacaoColheitaReal.value
          : this.diasAntecipacaoColheitaReal,
      diasDessecacaoPrePlantio: data.diasDessecacaoPrePlantio.present
          ? data.diasDessecacaoPrePlantio.value
          : this.diasDessecacaoPrePlantio,
      grupoRegulagemId: data.grupoRegulagemId.present
          ? data.grupoRegulagemId.value
          : this.grupoRegulagemId,
      plantioDefinido: data.plantioDefinido.present
          ? data.plantioDefinido.value
          : this.plantioDefinido,
      ordem: data.ordem.present ? data.ordem.value : this.ordem,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CronogramasSojaTalhaoData(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('talhaoId: $talhaoId, ')
          ..write('cultura: $cultura, ')
          ..write('materialCultivar: $materialCultivar, ')
          ..write('dataPlantio: $dataPlantio, ')
          ..write('diasEmergencia: $diasEmergencia, ')
          ..write('daePosEmergente: $daePosEmergente, ')
          ..write('diasRecuperacaoPosEmergente: $diasRecuperacaoPosEmergente, ')
          ..write('intervaloFungicidaDias: $intervaloFungicidaDias, ')
          ..write('totalAplicacoesFungicida: $totalAplicacoesFungicida, ')
          ..write('daeMaturacaoCiclo: $daeMaturacaoCiclo, ')
          ..write('diasAntesR8Dessecante: $diasAntesR8Dessecante, ')
          ..write('diasAntecipacaoColheitaReal: $diasAntecipacaoColheitaReal, ')
          ..write('diasDessecacaoPrePlantio: $diasDessecacaoPrePlantio, ')
          ..write('grupoRegulagemId: $grupoRegulagemId, ')
          ..write('plantioDefinido: $plantioDefinido, ')
          ..write('ordem: $ordem, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        uid,
        userId,
        talhaoId,
        cultura,
        materialCultivar,
        dataPlantio,
        diasEmergencia,
        daePosEmergente,
        diasRecuperacaoPosEmergente,
        intervaloFungicidaDias,
        totalAplicacoesFungicida,
        daeMaturacaoCiclo,
        diasAntesR8Dessecante,
        diasAntecipacaoColheitaReal,
        diasDessecacaoPrePlantio,
        grupoRegulagemId,
        plantioDefinido,
        ordem,
        createdAt,
        updatedAt,
        syncState,
        deletedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CronogramasSojaTalhaoData &&
          other.uid == this.uid &&
          other.userId == this.userId &&
          other.talhaoId == this.talhaoId &&
          other.cultura == this.cultura &&
          other.materialCultivar == this.materialCultivar &&
          other.dataPlantio == this.dataPlantio &&
          other.diasEmergencia == this.diasEmergencia &&
          other.daePosEmergente == this.daePosEmergente &&
          other.diasRecuperacaoPosEmergente ==
              this.diasRecuperacaoPosEmergente &&
          other.intervaloFungicidaDias == this.intervaloFungicidaDias &&
          other.totalAplicacoesFungicida == this.totalAplicacoesFungicida &&
          other.daeMaturacaoCiclo == this.daeMaturacaoCiclo &&
          other.diasAntesR8Dessecante == this.diasAntesR8Dessecante &&
          other.diasAntecipacaoColheitaReal ==
              this.diasAntecipacaoColheitaReal &&
          other.diasDessecacaoPrePlantio == this.diasDessecacaoPrePlantio &&
          other.grupoRegulagemId == this.grupoRegulagemId &&
          other.plantioDefinido == this.plantioDefinido &&
          other.ordem == this.ordem &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncState == this.syncState &&
          other.deletedAt == this.deletedAt);
}

class CronogramasSojaTalhaoCompanion
    extends UpdateCompanion<CronogramasSojaTalhaoData> {
  final Value<String> uid;
  final Value<String?> userId;
  final Value<String> talhaoId;
  final Value<String> cultura;
  final Value<String> materialCultivar;
  final Value<DateTime> dataPlantio;
  final Value<int> diasEmergencia;
  final Value<int> daePosEmergente;
  final Value<int> diasRecuperacaoPosEmergente;
  final Value<int> intervaloFungicidaDias;
  final Value<int> totalAplicacoesFungicida;
  final Value<int> daeMaturacaoCiclo;
  final Value<int> diasAntesR8Dessecante;
  final Value<int> diasAntecipacaoColheitaReal;
  final Value<int> diasDessecacaoPrePlantio;
  final Value<String> grupoRegulagemId;
  final Value<bool> plantioDefinido;
  final Value<int> ordem;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncState;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const CronogramasSojaTalhaoCompanion({
    this.uid = const Value.absent(),
    this.userId = const Value.absent(),
    this.talhaoId = const Value.absent(),
    this.cultura = const Value.absent(),
    this.materialCultivar = const Value.absent(),
    this.dataPlantio = const Value.absent(),
    this.diasEmergencia = const Value.absent(),
    this.daePosEmergente = const Value.absent(),
    this.diasRecuperacaoPosEmergente = const Value.absent(),
    this.intervaloFungicidaDias = const Value.absent(),
    this.totalAplicacoesFungicida = const Value.absent(),
    this.daeMaturacaoCiclo = const Value.absent(),
    this.diasAntesR8Dessecante = const Value.absent(),
    this.diasAntecipacaoColheitaReal = const Value.absent(),
    this.diasDessecacaoPrePlantio = const Value.absent(),
    this.grupoRegulagemId = const Value.absent(),
    this.plantioDefinido = const Value.absent(),
    this.ordem = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CronogramasSojaTalhaoCompanion.insert({
    required String uid,
    this.userId = const Value.absent(),
    required String talhaoId,
    required String cultura,
    this.materialCultivar = const Value.absent(),
    required DateTime dataPlantio,
    this.diasEmergencia = const Value.absent(),
    this.daePosEmergente = const Value.absent(),
    this.diasRecuperacaoPosEmergente = const Value.absent(),
    this.intervaloFungicidaDias = const Value.absent(),
    this.totalAplicacoesFungicida = const Value.absent(),
    this.daeMaturacaoCiclo = const Value.absent(),
    this.diasAntesR8Dessecante = const Value.absent(),
    this.diasAntecipacaoColheitaReal = const Value.absent(),
    this.diasDessecacaoPrePlantio = const Value.absent(),
    this.grupoRegulagemId = const Value.absent(),
    this.plantioDefinido = const Value.absent(),
    this.ordem = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        talhaoId = Value(talhaoId),
        cultura = Value(cultura),
        dataPlantio = Value(dataPlantio),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CronogramasSojaTalhaoData> custom({
    Expression<String>? uid,
    Expression<String>? userId,
    Expression<String>? talhaoId,
    Expression<String>? cultura,
    Expression<String>? materialCultivar,
    Expression<DateTime>? dataPlantio,
    Expression<int>? diasEmergencia,
    Expression<int>? daePosEmergente,
    Expression<int>? diasRecuperacaoPosEmergente,
    Expression<int>? intervaloFungicidaDias,
    Expression<int>? totalAplicacoesFungicida,
    Expression<int>? daeMaturacaoCiclo,
    Expression<int>? diasAntesR8Dessecante,
    Expression<int>? diasAntecipacaoColheitaReal,
    Expression<int>? diasDessecacaoPrePlantio,
    Expression<String>? grupoRegulagemId,
    Expression<bool>? plantioDefinido,
    Expression<int>? ordem,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncState,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (userId != null) 'user_id': userId,
      if (talhaoId != null) 'talhao_id': talhaoId,
      if (cultura != null) 'cultura': cultura,
      if (materialCultivar != null) 'material_cultivar': materialCultivar,
      if (dataPlantio != null) 'data_plantio': dataPlantio,
      if (diasEmergencia != null) 'dias_emergencia': diasEmergencia,
      if (daePosEmergente != null) 'dae_pos_emergente': daePosEmergente,
      if (diasRecuperacaoPosEmergente != null)
        'dias_recuperacao_pos_emergente': diasRecuperacaoPosEmergente,
      if (intervaloFungicidaDias != null)
        'intervalo_fungicida_dias': intervaloFungicidaDias,
      if (totalAplicacoesFungicida != null)
        'total_aplicacoes_fungicida': totalAplicacoesFungicida,
      if (daeMaturacaoCiclo != null) 'dae_maturacao_ciclo': daeMaturacaoCiclo,
      if (diasAntesR8Dessecante != null)
        'dias_antes_r8_dessecante': diasAntesR8Dessecante,
      if (diasAntecipacaoColheitaReal != null)
        'dias_antecipacao_colheita_real': diasAntecipacaoColheitaReal,
      if (diasDessecacaoPrePlantio != null)
        'dias_dessecacao_pre_plantio': diasDessecacaoPrePlantio,
      if (grupoRegulagemId != null) 'grupo_regulagem_id': grupoRegulagemId,
      if (plantioDefinido != null) 'plantio_definido': plantioDefinido,
      if (ordem != null) 'ordem': ordem,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncState != null) 'sync_state': syncState,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CronogramasSojaTalhaoCompanion copyWith(
      {Value<String>? uid,
      Value<String?>? userId,
      Value<String>? talhaoId,
      Value<String>? cultura,
      Value<String>? materialCultivar,
      Value<DateTime>? dataPlantio,
      Value<int>? diasEmergencia,
      Value<int>? daePosEmergente,
      Value<int>? diasRecuperacaoPosEmergente,
      Value<int>? intervaloFungicidaDias,
      Value<int>? totalAplicacoesFungicida,
      Value<int>? daeMaturacaoCiclo,
      Value<int>? diasAntesR8Dessecante,
      Value<int>? diasAntecipacaoColheitaReal,
      Value<int>? diasDessecacaoPrePlantio,
      Value<String>? grupoRegulagemId,
      Value<bool>? plantioDefinido,
      Value<int>? ordem,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncState,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return CronogramasSojaTalhaoCompanion(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      talhaoId: talhaoId ?? this.talhaoId,
      cultura: cultura ?? this.cultura,
      materialCultivar: materialCultivar ?? this.materialCultivar,
      dataPlantio: dataPlantio ?? this.dataPlantio,
      diasEmergencia: diasEmergencia ?? this.diasEmergencia,
      daePosEmergente: daePosEmergente ?? this.daePosEmergente,
      diasRecuperacaoPosEmergente:
          diasRecuperacaoPosEmergente ?? this.diasRecuperacaoPosEmergente,
      intervaloFungicidaDias:
          intervaloFungicidaDias ?? this.intervaloFungicidaDias,
      totalAplicacoesFungicida:
          totalAplicacoesFungicida ?? this.totalAplicacoesFungicida,
      daeMaturacaoCiclo: daeMaturacaoCiclo ?? this.daeMaturacaoCiclo,
      diasAntesR8Dessecante:
          diasAntesR8Dessecante ?? this.diasAntesR8Dessecante,
      diasAntecipacaoColheitaReal:
          diasAntecipacaoColheitaReal ?? this.diasAntecipacaoColheitaReal,
      diasDessecacaoPrePlantio:
          diasDessecacaoPrePlantio ?? this.diasDessecacaoPrePlantio,
      grupoRegulagemId: grupoRegulagemId ?? this.grupoRegulagemId,
      plantioDefinido: plantioDefinido ?? this.plantioDefinido,
      ordem: ordem ?? this.ordem,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncState: syncState ?? this.syncState,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (talhaoId.present) {
      map['talhao_id'] = Variable<String>(talhaoId.value);
    }
    if (cultura.present) {
      map['cultura'] = Variable<String>(cultura.value);
    }
    if (materialCultivar.present) {
      map['material_cultivar'] = Variable<String>(materialCultivar.value);
    }
    if (dataPlantio.present) {
      map['data_plantio'] = Variable<DateTime>(dataPlantio.value);
    }
    if (diasEmergencia.present) {
      map['dias_emergencia'] = Variable<int>(diasEmergencia.value);
    }
    if (daePosEmergente.present) {
      map['dae_pos_emergente'] = Variable<int>(daePosEmergente.value);
    }
    if (diasRecuperacaoPosEmergente.present) {
      map['dias_recuperacao_pos_emergente'] =
          Variable<int>(diasRecuperacaoPosEmergente.value);
    }
    if (intervaloFungicidaDias.present) {
      map['intervalo_fungicida_dias'] =
          Variable<int>(intervaloFungicidaDias.value);
    }
    if (totalAplicacoesFungicida.present) {
      map['total_aplicacoes_fungicida'] =
          Variable<int>(totalAplicacoesFungicida.value);
    }
    if (daeMaturacaoCiclo.present) {
      map['dae_maturacao_ciclo'] = Variable<int>(daeMaturacaoCiclo.value);
    }
    if (diasAntesR8Dessecante.present) {
      map['dias_antes_r8_dessecante'] =
          Variable<int>(diasAntesR8Dessecante.value);
    }
    if (diasAntecipacaoColheitaReal.present) {
      map['dias_antecipacao_colheita_real'] =
          Variable<int>(diasAntecipacaoColheitaReal.value);
    }
    if (diasDessecacaoPrePlantio.present) {
      map['dias_dessecacao_pre_plantio'] =
          Variable<int>(diasDessecacaoPrePlantio.value);
    }
    if (grupoRegulagemId.present) {
      map['grupo_regulagem_id'] = Variable<String>(grupoRegulagemId.value);
    }
    if (plantioDefinido.present) {
      map['plantio_definido'] = Variable<bool>(plantioDefinido.value);
    }
    if (ordem.present) {
      map['ordem'] = Variable<int>(ordem.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CronogramasSojaTalhaoCompanion(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('talhaoId: $talhaoId, ')
          ..write('cultura: $cultura, ')
          ..write('materialCultivar: $materialCultivar, ')
          ..write('dataPlantio: $dataPlantio, ')
          ..write('diasEmergencia: $diasEmergencia, ')
          ..write('daePosEmergente: $daePosEmergente, ')
          ..write('diasRecuperacaoPosEmergente: $diasRecuperacaoPosEmergente, ')
          ..write('intervaloFungicidaDias: $intervaloFungicidaDias, ')
          ..write('totalAplicacoesFungicida: $totalAplicacoesFungicida, ')
          ..write('daeMaturacaoCiclo: $daeMaturacaoCiclo, ')
          ..write('diasAntesR8Dessecante: $diasAntesR8Dessecante, ')
          ..write('diasAntecipacaoColheitaReal: $diasAntecipacaoColheitaReal, ')
          ..write('diasDessecacaoPrePlantio: $diasDessecacaoPrePlantio, ')
          ..write('grupoRegulagemId: $grupoRegulagemId, ')
          ..write('plantioDefinido: $plantioDefinido, ')
          ..write('ordem: $ordem, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TalhoesSafraTable extends TalhoesSafra
    with TableInfo<$TalhoesSafraTable, TalhoesSafraData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TalhoesSafraTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _planoIdMeta =
      const VerificationMeta('planoId');
  @override
  late final GeneratedColumn<String> planoId = GeneratedColumn<String>(
      'plano_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES planos (uid) ON DELETE CASCADE'));
  static const VerificationMeta _talhaoIdMeta =
      const VerificationMeta('talhaoId');
  @override
  late final GeneratedColumn<String> talhaoId = GeneratedColumn<String>(
      'talhao_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES talhoes (uid) ON DELETE CASCADE'));
  static const VerificationMeta _culturaMeta =
      const VerificationMeta('cultura');
  @override
  late final GeneratedColumn<String> cultura = GeneratedColumn<String>(
      'cultura', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _materialCultivarMeta =
      const VerificationMeta('materialCultivar');
  @override
  late final GeneratedColumn<String> materialCultivar = GeneratedColumn<String>(
      'material_cultivar', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _dataPlantioMeta =
      const VerificationMeta('dataPlantio');
  @override
  late final GeneratedColumn<DateTime> dataPlantio = GeneratedColumn<DateTime>(
      'data_plantio', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _diasEmergenciaMeta =
      const VerificationMeta('diasEmergencia');
  @override
  late final GeneratedColumn<int> diasEmergencia = GeneratedColumn<int>(
      'dias_emergencia', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(5));
  static const VerificationMeta _daePosEmergenteMeta =
      const VerificationMeta('daePosEmergente');
  @override
  late final GeneratedColumn<int> daePosEmergente = GeneratedColumn<int>(
      'dae_pos_emergente', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(25));
  static const VerificationMeta _diasRecuperacaoPosEmergenteMeta =
      const VerificationMeta('diasRecuperacaoPosEmergente');
  @override
  late final GeneratedColumn<int> diasRecuperacaoPosEmergente =
      GeneratedColumn<int>('dias_recuperacao_pos_emergente', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(5));
  static const VerificationMeta _intervaloFungicidaDiasMeta =
      const VerificationMeta('intervaloFungicidaDias');
  @override
  late final GeneratedColumn<int> intervaloFungicidaDias = GeneratedColumn<int>(
      'intervalo_fungicida_dias', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(15));
  static const VerificationMeta _totalAplicacoesFungicidaMeta =
      const VerificationMeta('totalAplicacoesFungicida');
  @override
  late final GeneratedColumn<int> totalAplicacoesFungicida =
      GeneratedColumn<int>('total_aplicacoes_fungicida', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(4));
  static const VerificationMeta _daeMaturacaoCicloMeta =
      const VerificationMeta('daeMaturacaoCiclo');
  @override
  late final GeneratedColumn<int> daeMaturacaoCiclo = GeneratedColumn<int>(
      'dae_maturacao_ciclo', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(110));
  static const VerificationMeta _diasAntesR8DessecanteMeta =
      const VerificationMeta('diasAntesR8Dessecante');
  @override
  late final GeneratedColumn<int> diasAntesR8Dessecante = GeneratedColumn<int>(
      'dias_antes_r8_dessecante', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(12));
  static const VerificationMeta _diasAntecipacaoColheitaRealMeta =
      const VerificationMeta('diasAntecipacaoColheitaReal');
  @override
  late final GeneratedColumn<int> diasAntecipacaoColheitaReal =
      GeneratedColumn<int>('dias_antecipacao_colheita_real', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(5));
  static const VerificationMeta _diasDessecacaoPrePlantioMeta =
      const VerificationMeta('diasDessecacaoPrePlantio');
  @override
  late final GeneratedColumn<int> diasDessecacaoPrePlantio =
      GeneratedColumn<int>('dias_dessecacao_pre_plantio', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(15));
  static const VerificationMeta _grupoRegulagemIdMeta =
      const VerificationMeta('grupoRegulagemId');
  @override
  late final GeneratedColumn<String> grupoRegulagemId = GeneratedColumn<String>(
      'grupo_regulagem_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _plantioDefinidoMeta =
      const VerificationMeta('plantioDefinido');
  @override
  late final GeneratedColumn<bool> plantioDefinido = GeneratedColumn<bool>(
      'plantio_definido', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("plantio_definido" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _ordemMeta = const VerificationMeta('ordem');
  @override
  late final GeneratedColumn<int> ordem = GeneratedColumn<int>(
      'ordem', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _programaOperacionalIdsMeta =
      const VerificationMeta('programaOperacionalIds');
  @override
  late final GeneratedColumn<String> programaOperacionalIds =
      GeneratedColumn<String>('programa_operacional_ids', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        userId,
        planoId,
        talhaoId,
        cultura,
        materialCultivar,
        dataPlantio,
        diasEmergencia,
        daePosEmergente,
        diasRecuperacaoPosEmergente,
        intervaloFungicidaDias,
        totalAplicacoesFungicida,
        daeMaturacaoCiclo,
        diasAntesR8Dessecante,
        diasAntecipacaoColheitaReal,
        diasDessecacaoPrePlantio,
        grupoRegulagemId,
        plantioDefinido,
        ordem,
        programaOperacionalIds,
        createdAt,
        updatedAt,
        syncState,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'talhoes_safra';
  @override
  VerificationContext validateIntegrity(Insertable<TalhoesSafraData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('plano_id')) {
      context.handle(_planoIdMeta,
          planoId.isAcceptableOrUnknown(data['plano_id']!, _planoIdMeta));
    } else if (isInserting) {
      context.missing(_planoIdMeta);
    }
    if (data.containsKey('talhao_id')) {
      context.handle(_talhaoIdMeta,
          talhaoId.isAcceptableOrUnknown(data['talhao_id']!, _talhaoIdMeta));
    } else if (isInserting) {
      context.missing(_talhaoIdMeta);
    }
    if (data.containsKey('cultura')) {
      context.handle(_culturaMeta,
          cultura.isAcceptableOrUnknown(data['cultura']!, _culturaMeta));
    } else if (isInserting) {
      context.missing(_culturaMeta);
    }
    if (data.containsKey('material_cultivar')) {
      context.handle(
          _materialCultivarMeta,
          materialCultivar.isAcceptableOrUnknown(
              data['material_cultivar']!, _materialCultivarMeta));
    }
    if (data.containsKey('data_plantio')) {
      context.handle(
          _dataPlantioMeta,
          dataPlantio.isAcceptableOrUnknown(
              data['data_plantio']!, _dataPlantioMeta));
    } else if (isInserting) {
      context.missing(_dataPlantioMeta);
    }
    if (data.containsKey('dias_emergencia')) {
      context.handle(
          _diasEmergenciaMeta,
          diasEmergencia.isAcceptableOrUnknown(
              data['dias_emergencia']!, _diasEmergenciaMeta));
    }
    if (data.containsKey('dae_pos_emergente')) {
      context.handle(
          _daePosEmergenteMeta,
          daePosEmergente.isAcceptableOrUnknown(
              data['dae_pos_emergente']!, _daePosEmergenteMeta));
    }
    if (data.containsKey('dias_recuperacao_pos_emergente')) {
      context.handle(
          _diasRecuperacaoPosEmergenteMeta,
          diasRecuperacaoPosEmergente.isAcceptableOrUnknown(
              data['dias_recuperacao_pos_emergente']!,
              _diasRecuperacaoPosEmergenteMeta));
    }
    if (data.containsKey('intervalo_fungicida_dias')) {
      context.handle(
          _intervaloFungicidaDiasMeta,
          intervaloFungicidaDias.isAcceptableOrUnknown(
              data['intervalo_fungicida_dias']!, _intervaloFungicidaDiasMeta));
    }
    if (data.containsKey('total_aplicacoes_fungicida')) {
      context.handle(
          _totalAplicacoesFungicidaMeta,
          totalAplicacoesFungicida.isAcceptableOrUnknown(
              data['total_aplicacoes_fungicida']!,
              _totalAplicacoesFungicidaMeta));
    }
    if (data.containsKey('dae_maturacao_ciclo')) {
      context.handle(
          _daeMaturacaoCicloMeta,
          daeMaturacaoCiclo.isAcceptableOrUnknown(
              data['dae_maturacao_ciclo']!, _daeMaturacaoCicloMeta));
    }
    if (data.containsKey('dias_antes_r8_dessecante')) {
      context.handle(
          _diasAntesR8DessecanteMeta,
          diasAntesR8Dessecante.isAcceptableOrUnknown(
              data['dias_antes_r8_dessecante']!, _diasAntesR8DessecanteMeta));
    }
    if (data.containsKey('dias_antecipacao_colheita_real')) {
      context.handle(
          _diasAntecipacaoColheitaRealMeta,
          diasAntecipacaoColheitaReal.isAcceptableOrUnknown(
              data['dias_antecipacao_colheita_real']!,
              _diasAntecipacaoColheitaRealMeta));
    }
    if (data.containsKey('dias_dessecacao_pre_plantio')) {
      context.handle(
          _diasDessecacaoPrePlantioMeta,
          diasDessecacaoPrePlantio.isAcceptableOrUnknown(
              data['dias_dessecacao_pre_plantio']!,
              _diasDessecacaoPrePlantioMeta));
    }
    if (data.containsKey('grupo_regulagem_id')) {
      context.handle(
          _grupoRegulagemIdMeta,
          grupoRegulagemId.isAcceptableOrUnknown(
              data['grupo_regulagem_id']!, _grupoRegulagemIdMeta));
    }
    if (data.containsKey('plantio_definido')) {
      context.handle(
          _plantioDefinidoMeta,
          plantioDefinido.isAcceptableOrUnknown(
              data['plantio_definido']!, _plantioDefinidoMeta));
    }
    if (data.containsKey('ordem')) {
      context.handle(
          _ordemMeta, ordem.isAcceptableOrUnknown(data['ordem']!, _ordemMeta));
    }
    if (data.containsKey('programa_operacional_ids')) {
      context.handle(
          _programaOperacionalIdsMeta,
          programaOperacionalIds.isAcceptableOrUnknown(
              data['programa_operacional_ids']!, _programaOperacionalIdsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  TalhoesSafraData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TalhoesSafraData(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      planoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plano_id'])!,
      talhaoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}talhao_id'])!,
      cultura: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cultura'])!,
      materialCultivar: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}material_cultivar'])!,
      dataPlantio: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_plantio'])!,
      diasEmergencia: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dias_emergencia'])!,
      daePosEmergente: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dae_pos_emergente'])!,
      diasRecuperacaoPosEmergente: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}dias_recuperacao_pos_emergente'])!,
      intervaloFungicidaDias: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}intervalo_fungicida_dias'])!,
      totalAplicacoesFungicida: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}total_aplicacoes_fungicida'])!,
      daeMaturacaoCiclo: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}dae_maturacao_ciclo'])!,
      diasAntesR8Dessecante: attachedDatabase.typeMapping.read(DriftSqlType.int,
          data['${effectivePrefix}dias_antes_r8_dessecante'])!,
      diasAntecipacaoColheitaReal: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}dias_antecipacao_colheita_real'])!,
      diasDessecacaoPrePlantio: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}dias_dessecacao_pre_plantio'])!,
      grupoRegulagemId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}grupo_regulagem_id'])!,
      plantioDefinido: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}plantio_definido'])!,
      ordem: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordem'])!,
      programaOperacionalIds: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}programa_operacional_ids'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $TalhoesSafraTable createAlias(String alias) {
    return $TalhoesSafraTable(attachedDatabase, alias);
  }
}

class TalhoesSafraData extends DataClass
    implements Insertable<TalhoesSafraData> {
  final String uid;
  final String? userId;
  final String planoId;
  final String talhaoId;
  final String cultura;
  final String materialCultivar;
  final DateTime dataPlantio;
  final int diasEmergencia;
  final int daePosEmergente;
  final int diasRecuperacaoPosEmergente;
  final int intervaloFungicidaDias;
  final int totalAplicacoesFungicida;
  final int daeMaturacaoCiclo;
  final int diasAntesR8Dessecante;
  final int diasAntecipacaoColheitaReal;
  final int diasDessecacaoPrePlantio;
  final String grupoRegulagemId;
  final bool plantioDefinido;
  final int ordem;

  /// JSON array de [ProgramasOperacionais.uid] vinculados a este talhão na safra.
  final String programaOperacionalIds;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncState;
  final DateTime? deletedAt;
  const TalhoesSafraData(
      {required this.uid,
      this.userId,
      required this.planoId,
      required this.talhaoId,
      required this.cultura,
      required this.materialCultivar,
      required this.dataPlantio,
      required this.diasEmergencia,
      required this.daePosEmergente,
      required this.diasRecuperacaoPosEmergente,
      required this.intervaloFungicidaDias,
      required this.totalAplicacoesFungicida,
      required this.daeMaturacaoCiclo,
      required this.diasAntesR8Dessecante,
      required this.diasAntecipacaoColheitaReal,
      required this.diasDessecacaoPrePlantio,
      required this.grupoRegulagemId,
      required this.plantioDefinido,
      required this.ordem,
      required this.programaOperacionalIds,
      required this.createdAt,
      required this.updatedAt,
      required this.syncState,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['plano_id'] = Variable<String>(planoId);
    map['talhao_id'] = Variable<String>(talhaoId);
    map['cultura'] = Variable<String>(cultura);
    map['material_cultivar'] = Variable<String>(materialCultivar);
    map['data_plantio'] = Variable<DateTime>(dataPlantio);
    map['dias_emergencia'] = Variable<int>(diasEmergencia);
    map['dae_pos_emergente'] = Variable<int>(daePosEmergente);
    map['dias_recuperacao_pos_emergente'] =
        Variable<int>(diasRecuperacaoPosEmergente);
    map['intervalo_fungicida_dias'] = Variable<int>(intervaloFungicidaDias);
    map['total_aplicacoes_fungicida'] = Variable<int>(totalAplicacoesFungicida);
    map['dae_maturacao_ciclo'] = Variable<int>(daeMaturacaoCiclo);
    map['dias_antes_r8_dessecante'] = Variable<int>(diasAntesR8Dessecante);
    map['dias_antecipacao_colheita_real'] =
        Variable<int>(diasAntecipacaoColheitaReal);
    map['dias_dessecacao_pre_plantio'] =
        Variable<int>(diasDessecacaoPrePlantio);
    map['grupo_regulagem_id'] = Variable<String>(grupoRegulagemId);
    map['plantio_definido'] = Variable<bool>(plantioDefinido);
    map['ordem'] = Variable<int>(ordem);
    map['programa_operacional_ids'] = Variable<String>(programaOperacionalIds);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  TalhoesSafraCompanion toCompanion(bool nullToAbsent) {
    return TalhoesSafraCompanion(
      uid: Value(uid),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      planoId: Value(planoId),
      talhaoId: Value(talhaoId),
      cultura: Value(cultura),
      materialCultivar: Value(materialCultivar),
      dataPlantio: Value(dataPlantio),
      diasEmergencia: Value(diasEmergencia),
      daePosEmergente: Value(daePosEmergente),
      diasRecuperacaoPosEmergente: Value(diasRecuperacaoPosEmergente),
      intervaloFungicidaDias: Value(intervaloFungicidaDias),
      totalAplicacoesFungicida: Value(totalAplicacoesFungicida),
      daeMaturacaoCiclo: Value(daeMaturacaoCiclo),
      diasAntesR8Dessecante: Value(diasAntesR8Dessecante),
      diasAntecipacaoColheitaReal: Value(diasAntecipacaoColheitaReal),
      diasDessecacaoPrePlantio: Value(diasDessecacaoPrePlantio),
      grupoRegulagemId: Value(grupoRegulagemId),
      plantioDefinido: Value(plantioDefinido),
      ordem: Value(ordem),
      programaOperacionalIds: Value(programaOperacionalIds),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncState: Value(syncState),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory TalhoesSafraData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TalhoesSafraData(
      uid: serializer.fromJson<String>(json['uid']),
      userId: serializer.fromJson<String?>(json['userId']),
      planoId: serializer.fromJson<String>(json['planoId']),
      talhaoId: serializer.fromJson<String>(json['talhaoId']),
      cultura: serializer.fromJson<String>(json['cultura']),
      materialCultivar: serializer.fromJson<String>(json['materialCultivar']),
      dataPlantio: serializer.fromJson<DateTime>(json['dataPlantio']),
      diasEmergencia: serializer.fromJson<int>(json['diasEmergencia']),
      daePosEmergente: serializer.fromJson<int>(json['daePosEmergente']),
      diasRecuperacaoPosEmergente:
          serializer.fromJson<int>(json['diasRecuperacaoPosEmergente']),
      intervaloFungicidaDias:
          serializer.fromJson<int>(json['intervaloFungicidaDias']),
      totalAplicacoesFungicida:
          serializer.fromJson<int>(json['totalAplicacoesFungicida']),
      daeMaturacaoCiclo: serializer.fromJson<int>(json['daeMaturacaoCiclo']),
      diasAntesR8Dessecante:
          serializer.fromJson<int>(json['diasAntesR8Dessecante']),
      diasAntecipacaoColheitaReal:
          serializer.fromJson<int>(json['diasAntecipacaoColheitaReal']),
      diasDessecacaoPrePlantio:
          serializer.fromJson<int>(json['diasDessecacaoPrePlantio']),
      grupoRegulagemId: serializer.fromJson<String>(json['grupoRegulagemId']),
      plantioDefinido: serializer.fromJson<bool>(json['plantioDefinido']),
      ordem: serializer.fromJson<int>(json['ordem']),
      programaOperacionalIds:
          serializer.fromJson<String>(json['programaOperacionalIds']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'userId': serializer.toJson<String?>(userId),
      'planoId': serializer.toJson<String>(planoId),
      'talhaoId': serializer.toJson<String>(talhaoId),
      'cultura': serializer.toJson<String>(cultura),
      'materialCultivar': serializer.toJson<String>(materialCultivar),
      'dataPlantio': serializer.toJson<DateTime>(dataPlantio),
      'diasEmergencia': serializer.toJson<int>(diasEmergencia),
      'daePosEmergente': serializer.toJson<int>(daePosEmergente),
      'diasRecuperacaoPosEmergente':
          serializer.toJson<int>(diasRecuperacaoPosEmergente),
      'intervaloFungicidaDias': serializer.toJson<int>(intervaloFungicidaDias),
      'totalAplicacoesFungicida':
          serializer.toJson<int>(totalAplicacoesFungicida),
      'daeMaturacaoCiclo': serializer.toJson<int>(daeMaturacaoCiclo),
      'diasAntesR8Dessecante': serializer.toJson<int>(diasAntesR8Dessecante),
      'diasAntecipacaoColheitaReal':
          serializer.toJson<int>(diasAntecipacaoColheitaReal),
      'diasDessecacaoPrePlantio':
          serializer.toJson<int>(diasDessecacaoPrePlantio),
      'grupoRegulagemId': serializer.toJson<String>(grupoRegulagemId),
      'plantioDefinido': serializer.toJson<bool>(plantioDefinido),
      'ordem': serializer.toJson<int>(ordem),
      'programaOperacionalIds':
          serializer.toJson<String>(programaOperacionalIds),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncState': serializer.toJson<String>(syncState),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  TalhoesSafraData copyWith(
          {String? uid,
          Value<String?> userId = const Value.absent(),
          String? planoId,
          String? talhaoId,
          String? cultura,
          String? materialCultivar,
          DateTime? dataPlantio,
          int? diasEmergencia,
          int? daePosEmergente,
          int? diasRecuperacaoPosEmergente,
          int? intervaloFungicidaDias,
          int? totalAplicacoesFungicida,
          int? daeMaturacaoCiclo,
          int? diasAntesR8Dessecante,
          int? diasAntecipacaoColheitaReal,
          int? diasDessecacaoPrePlantio,
          String? grupoRegulagemId,
          bool? plantioDefinido,
          int? ordem,
          String? programaOperacionalIds,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncState,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      TalhoesSafraData(
        uid: uid ?? this.uid,
        userId: userId.present ? userId.value : this.userId,
        planoId: planoId ?? this.planoId,
        talhaoId: talhaoId ?? this.talhaoId,
        cultura: cultura ?? this.cultura,
        materialCultivar: materialCultivar ?? this.materialCultivar,
        dataPlantio: dataPlantio ?? this.dataPlantio,
        diasEmergencia: diasEmergencia ?? this.diasEmergencia,
        daePosEmergente: daePosEmergente ?? this.daePosEmergente,
        diasRecuperacaoPosEmergente:
            diasRecuperacaoPosEmergente ?? this.diasRecuperacaoPosEmergente,
        intervaloFungicidaDias:
            intervaloFungicidaDias ?? this.intervaloFungicidaDias,
        totalAplicacoesFungicida:
            totalAplicacoesFungicida ?? this.totalAplicacoesFungicida,
        daeMaturacaoCiclo: daeMaturacaoCiclo ?? this.daeMaturacaoCiclo,
        diasAntesR8Dessecante:
            diasAntesR8Dessecante ?? this.diasAntesR8Dessecante,
        diasAntecipacaoColheitaReal:
            diasAntecipacaoColheitaReal ?? this.diasAntecipacaoColheitaReal,
        diasDessecacaoPrePlantio:
            diasDessecacaoPrePlantio ?? this.diasDessecacaoPrePlantio,
        grupoRegulagemId: grupoRegulagemId ?? this.grupoRegulagemId,
        plantioDefinido: plantioDefinido ?? this.plantioDefinido,
        ordem: ordem ?? this.ordem,
        programaOperacionalIds:
            programaOperacionalIds ?? this.programaOperacionalIds,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncState: syncState ?? this.syncState,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  TalhoesSafraData copyWithCompanion(TalhoesSafraCompanion data) {
    return TalhoesSafraData(
      uid: data.uid.present ? data.uid.value : this.uid,
      userId: data.userId.present ? data.userId.value : this.userId,
      planoId: data.planoId.present ? data.planoId.value : this.planoId,
      talhaoId: data.talhaoId.present ? data.talhaoId.value : this.talhaoId,
      cultura: data.cultura.present ? data.cultura.value : this.cultura,
      materialCultivar: data.materialCultivar.present
          ? data.materialCultivar.value
          : this.materialCultivar,
      dataPlantio:
          data.dataPlantio.present ? data.dataPlantio.value : this.dataPlantio,
      diasEmergencia: data.diasEmergencia.present
          ? data.diasEmergencia.value
          : this.diasEmergencia,
      daePosEmergente: data.daePosEmergente.present
          ? data.daePosEmergente.value
          : this.daePosEmergente,
      diasRecuperacaoPosEmergente: data.diasRecuperacaoPosEmergente.present
          ? data.diasRecuperacaoPosEmergente.value
          : this.diasRecuperacaoPosEmergente,
      intervaloFungicidaDias: data.intervaloFungicidaDias.present
          ? data.intervaloFungicidaDias.value
          : this.intervaloFungicidaDias,
      totalAplicacoesFungicida: data.totalAplicacoesFungicida.present
          ? data.totalAplicacoesFungicida.value
          : this.totalAplicacoesFungicida,
      daeMaturacaoCiclo: data.daeMaturacaoCiclo.present
          ? data.daeMaturacaoCiclo.value
          : this.daeMaturacaoCiclo,
      diasAntesR8Dessecante: data.diasAntesR8Dessecante.present
          ? data.diasAntesR8Dessecante.value
          : this.diasAntesR8Dessecante,
      diasAntecipacaoColheitaReal: data.diasAntecipacaoColheitaReal.present
          ? data.diasAntecipacaoColheitaReal.value
          : this.diasAntecipacaoColheitaReal,
      diasDessecacaoPrePlantio: data.diasDessecacaoPrePlantio.present
          ? data.diasDessecacaoPrePlantio.value
          : this.diasDessecacaoPrePlantio,
      grupoRegulagemId: data.grupoRegulagemId.present
          ? data.grupoRegulagemId.value
          : this.grupoRegulagemId,
      plantioDefinido: data.plantioDefinido.present
          ? data.plantioDefinido.value
          : this.plantioDefinido,
      ordem: data.ordem.present ? data.ordem.value : this.ordem,
      programaOperacionalIds: data.programaOperacionalIds.present
          ? data.programaOperacionalIds.value
          : this.programaOperacionalIds,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TalhoesSafraData(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('planoId: $planoId, ')
          ..write('talhaoId: $talhaoId, ')
          ..write('cultura: $cultura, ')
          ..write('materialCultivar: $materialCultivar, ')
          ..write('dataPlantio: $dataPlantio, ')
          ..write('diasEmergencia: $diasEmergencia, ')
          ..write('daePosEmergente: $daePosEmergente, ')
          ..write('diasRecuperacaoPosEmergente: $diasRecuperacaoPosEmergente, ')
          ..write('intervaloFungicidaDias: $intervaloFungicidaDias, ')
          ..write('totalAplicacoesFungicida: $totalAplicacoesFungicida, ')
          ..write('daeMaturacaoCiclo: $daeMaturacaoCiclo, ')
          ..write('diasAntesR8Dessecante: $diasAntesR8Dessecante, ')
          ..write('diasAntecipacaoColheitaReal: $diasAntecipacaoColheitaReal, ')
          ..write('diasDessecacaoPrePlantio: $diasDessecacaoPrePlantio, ')
          ..write('grupoRegulagemId: $grupoRegulagemId, ')
          ..write('plantioDefinido: $plantioDefinido, ')
          ..write('ordem: $ordem, ')
          ..write('programaOperacionalIds: $programaOperacionalIds, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        uid,
        userId,
        planoId,
        talhaoId,
        cultura,
        materialCultivar,
        dataPlantio,
        diasEmergencia,
        daePosEmergente,
        diasRecuperacaoPosEmergente,
        intervaloFungicidaDias,
        totalAplicacoesFungicida,
        daeMaturacaoCiclo,
        diasAntesR8Dessecante,
        diasAntecipacaoColheitaReal,
        diasDessecacaoPrePlantio,
        grupoRegulagemId,
        plantioDefinido,
        ordem,
        programaOperacionalIds,
        createdAt,
        updatedAt,
        syncState,
        deletedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TalhoesSafraData &&
          other.uid == this.uid &&
          other.userId == this.userId &&
          other.planoId == this.planoId &&
          other.talhaoId == this.talhaoId &&
          other.cultura == this.cultura &&
          other.materialCultivar == this.materialCultivar &&
          other.dataPlantio == this.dataPlantio &&
          other.diasEmergencia == this.diasEmergencia &&
          other.daePosEmergente == this.daePosEmergente &&
          other.diasRecuperacaoPosEmergente ==
              this.diasRecuperacaoPosEmergente &&
          other.intervaloFungicidaDias == this.intervaloFungicidaDias &&
          other.totalAplicacoesFungicida == this.totalAplicacoesFungicida &&
          other.daeMaturacaoCiclo == this.daeMaturacaoCiclo &&
          other.diasAntesR8Dessecante == this.diasAntesR8Dessecante &&
          other.diasAntecipacaoColheitaReal ==
              this.diasAntecipacaoColheitaReal &&
          other.diasDessecacaoPrePlantio == this.diasDessecacaoPrePlantio &&
          other.grupoRegulagemId == this.grupoRegulagemId &&
          other.plantioDefinido == this.plantioDefinido &&
          other.ordem == this.ordem &&
          other.programaOperacionalIds == this.programaOperacionalIds &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncState == this.syncState &&
          other.deletedAt == this.deletedAt);
}

class TalhoesSafraCompanion extends UpdateCompanion<TalhoesSafraData> {
  final Value<String> uid;
  final Value<String?> userId;
  final Value<String> planoId;
  final Value<String> talhaoId;
  final Value<String> cultura;
  final Value<String> materialCultivar;
  final Value<DateTime> dataPlantio;
  final Value<int> diasEmergencia;
  final Value<int> daePosEmergente;
  final Value<int> diasRecuperacaoPosEmergente;
  final Value<int> intervaloFungicidaDias;
  final Value<int> totalAplicacoesFungicida;
  final Value<int> daeMaturacaoCiclo;
  final Value<int> diasAntesR8Dessecante;
  final Value<int> diasAntecipacaoColheitaReal;
  final Value<int> diasDessecacaoPrePlantio;
  final Value<String> grupoRegulagemId;
  final Value<bool> plantioDefinido;
  final Value<int> ordem;
  final Value<String> programaOperacionalIds;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncState;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const TalhoesSafraCompanion({
    this.uid = const Value.absent(),
    this.userId = const Value.absent(),
    this.planoId = const Value.absent(),
    this.talhaoId = const Value.absent(),
    this.cultura = const Value.absent(),
    this.materialCultivar = const Value.absent(),
    this.dataPlantio = const Value.absent(),
    this.diasEmergencia = const Value.absent(),
    this.daePosEmergente = const Value.absent(),
    this.diasRecuperacaoPosEmergente = const Value.absent(),
    this.intervaloFungicidaDias = const Value.absent(),
    this.totalAplicacoesFungicida = const Value.absent(),
    this.daeMaturacaoCiclo = const Value.absent(),
    this.diasAntesR8Dessecante = const Value.absent(),
    this.diasAntecipacaoColheitaReal = const Value.absent(),
    this.diasDessecacaoPrePlantio = const Value.absent(),
    this.grupoRegulagemId = const Value.absent(),
    this.plantioDefinido = const Value.absent(),
    this.ordem = const Value.absent(),
    this.programaOperacionalIds = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TalhoesSafraCompanion.insert({
    required String uid,
    this.userId = const Value.absent(),
    required String planoId,
    required String talhaoId,
    required String cultura,
    this.materialCultivar = const Value.absent(),
    required DateTime dataPlantio,
    this.diasEmergencia = const Value.absent(),
    this.daePosEmergente = const Value.absent(),
    this.diasRecuperacaoPosEmergente = const Value.absent(),
    this.intervaloFungicidaDias = const Value.absent(),
    this.totalAplicacoesFungicida = const Value.absent(),
    this.daeMaturacaoCiclo = const Value.absent(),
    this.diasAntesR8Dessecante = const Value.absent(),
    this.diasAntecipacaoColheitaReal = const Value.absent(),
    this.diasDessecacaoPrePlantio = const Value.absent(),
    this.grupoRegulagemId = const Value.absent(),
    this.plantioDefinido = const Value.absent(),
    this.ordem = const Value.absent(),
    this.programaOperacionalIds = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        planoId = Value(planoId),
        talhaoId = Value(talhaoId),
        cultura = Value(cultura),
        dataPlantio = Value(dataPlantio),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<TalhoesSafraData> custom({
    Expression<String>? uid,
    Expression<String>? userId,
    Expression<String>? planoId,
    Expression<String>? talhaoId,
    Expression<String>? cultura,
    Expression<String>? materialCultivar,
    Expression<DateTime>? dataPlantio,
    Expression<int>? diasEmergencia,
    Expression<int>? daePosEmergente,
    Expression<int>? diasRecuperacaoPosEmergente,
    Expression<int>? intervaloFungicidaDias,
    Expression<int>? totalAplicacoesFungicida,
    Expression<int>? daeMaturacaoCiclo,
    Expression<int>? diasAntesR8Dessecante,
    Expression<int>? diasAntecipacaoColheitaReal,
    Expression<int>? diasDessecacaoPrePlantio,
    Expression<String>? grupoRegulagemId,
    Expression<bool>? plantioDefinido,
    Expression<int>? ordem,
    Expression<String>? programaOperacionalIds,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncState,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (userId != null) 'user_id': userId,
      if (planoId != null) 'plano_id': planoId,
      if (talhaoId != null) 'talhao_id': talhaoId,
      if (cultura != null) 'cultura': cultura,
      if (materialCultivar != null) 'material_cultivar': materialCultivar,
      if (dataPlantio != null) 'data_plantio': dataPlantio,
      if (diasEmergencia != null) 'dias_emergencia': diasEmergencia,
      if (daePosEmergente != null) 'dae_pos_emergente': daePosEmergente,
      if (diasRecuperacaoPosEmergente != null)
        'dias_recuperacao_pos_emergente': diasRecuperacaoPosEmergente,
      if (intervaloFungicidaDias != null)
        'intervalo_fungicida_dias': intervaloFungicidaDias,
      if (totalAplicacoesFungicida != null)
        'total_aplicacoes_fungicida': totalAplicacoesFungicida,
      if (daeMaturacaoCiclo != null) 'dae_maturacao_ciclo': daeMaturacaoCiclo,
      if (diasAntesR8Dessecante != null)
        'dias_antes_r8_dessecante': diasAntesR8Dessecante,
      if (diasAntecipacaoColheitaReal != null)
        'dias_antecipacao_colheita_real': diasAntecipacaoColheitaReal,
      if (diasDessecacaoPrePlantio != null)
        'dias_dessecacao_pre_plantio': diasDessecacaoPrePlantio,
      if (grupoRegulagemId != null) 'grupo_regulagem_id': grupoRegulagemId,
      if (plantioDefinido != null) 'plantio_definido': plantioDefinido,
      if (ordem != null) 'ordem': ordem,
      if (programaOperacionalIds != null)
        'programa_operacional_ids': programaOperacionalIds,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncState != null) 'sync_state': syncState,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TalhoesSafraCompanion copyWith(
      {Value<String>? uid,
      Value<String?>? userId,
      Value<String>? planoId,
      Value<String>? talhaoId,
      Value<String>? cultura,
      Value<String>? materialCultivar,
      Value<DateTime>? dataPlantio,
      Value<int>? diasEmergencia,
      Value<int>? daePosEmergente,
      Value<int>? diasRecuperacaoPosEmergente,
      Value<int>? intervaloFungicidaDias,
      Value<int>? totalAplicacoesFungicida,
      Value<int>? daeMaturacaoCiclo,
      Value<int>? diasAntesR8Dessecante,
      Value<int>? diasAntecipacaoColheitaReal,
      Value<int>? diasDessecacaoPrePlantio,
      Value<String>? grupoRegulagemId,
      Value<bool>? plantioDefinido,
      Value<int>? ordem,
      Value<String>? programaOperacionalIds,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncState,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return TalhoesSafraCompanion(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      planoId: planoId ?? this.planoId,
      talhaoId: talhaoId ?? this.talhaoId,
      cultura: cultura ?? this.cultura,
      materialCultivar: materialCultivar ?? this.materialCultivar,
      dataPlantio: dataPlantio ?? this.dataPlantio,
      diasEmergencia: diasEmergencia ?? this.diasEmergencia,
      daePosEmergente: daePosEmergente ?? this.daePosEmergente,
      diasRecuperacaoPosEmergente:
          diasRecuperacaoPosEmergente ?? this.diasRecuperacaoPosEmergente,
      intervaloFungicidaDias:
          intervaloFungicidaDias ?? this.intervaloFungicidaDias,
      totalAplicacoesFungicida:
          totalAplicacoesFungicida ?? this.totalAplicacoesFungicida,
      daeMaturacaoCiclo: daeMaturacaoCiclo ?? this.daeMaturacaoCiclo,
      diasAntesR8Dessecante:
          diasAntesR8Dessecante ?? this.diasAntesR8Dessecante,
      diasAntecipacaoColheitaReal:
          diasAntecipacaoColheitaReal ?? this.diasAntecipacaoColheitaReal,
      diasDessecacaoPrePlantio:
          diasDessecacaoPrePlantio ?? this.diasDessecacaoPrePlantio,
      grupoRegulagemId: grupoRegulagemId ?? this.grupoRegulagemId,
      plantioDefinido: plantioDefinido ?? this.plantioDefinido,
      ordem: ordem ?? this.ordem,
      programaOperacionalIds:
          programaOperacionalIds ?? this.programaOperacionalIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncState: syncState ?? this.syncState,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (planoId.present) {
      map['plano_id'] = Variable<String>(planoId.value);
    }
    if (talhaoId.present) {
      map['talhao_id'] = Variable<String>(talhaoId.value);
    }
    if (cultura.present) {
      map['cultura'] = Variable<String>(cultura.value);
    }
    if (materialCultivar.present) {
      map['material_cultivar'] = Variable<String>(materialCultivar.value);
    }
    if (dataPlantio.present) {
      map['data_plantio'] = Variable<DateTime>(dataPlantio.value);
    }
    if (diasEmergencia.present) {
      map['dias_emergencia'] = Variable<int>(diasEmergencia.value);
    }
    if (daePosEmergente.present) {
      map['dae_pos_emergente'] = Variable<int>(daePosEmergente.value);
    }
    if (diasRecuperacaoPosEmergente.present) {
      map['dias_recuperacao_pos_emergente'] =
          Variable<int>(diasRecuperacaoPosEmergente.value);
    }
    if (intervaloFungicidaDias.present) {
      map['intervalo_fungicida_dias'] =
          Variable<int>(intervaloFungicidaDias.value);
    }
    if (totalAplicacoesFungicida.present) {
      map['total_aplicacoes_fungicida'] =
          Variable<int>(totalAplicacoesFungicida.value);
    }
    if (daeMaturacaoCiclo.present) {
      map['dae_maturacao_ciclo'] = Variable<int>(daeMaturacaoCiclo.value);
    }
    if (diasAntesR8Dessecante.present) {
      map['dias_antes_r8_dessecante'] =
          Variable<int>(diasAntesR8Dessecante.value);
    }
    if (diasAntecipacaoColheitaReal.present) {
      map['dias_antecipacao_colheita_real'] =
          Variable<int>(diasAntecipacaoColheitaReal.value);
    }
    if (diasDessecacaoPrePlantio.present) {
      map['dias_dessecacao_pre_plantio'] =
          Variable<int>(diasDessecacaoPrePlantio.value);
    }
    if (grupoRegulagemId.present) {
      map['grupo_regulagem_id'] = Variable<String>(grupoRegulagemId.value);
    }
    if (plantioDefinido.present) {
      map['plantio_definido'] = Variable<bool>(plantioDefinido.value);
    }
    if (ordem.present) {
      map['ordem'] = Variable<int>(ordem.value);
    }
    if (programaOperacionalIds.present) {
      map['programa_operacional_ids'] =
          Variable<String>(programaOperacionalIds.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TalhoesSafraCompanion(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('planoId: $planoId, ')
          ..write('talhaoId: $talhaoId, ')
          ..write('cultura: $cultura, ')
          ..write('materialCultivar: $materialCultivar, ')
          ..write('dataPlantio: $dataPlantio, ')
          ..write('diasEmergencia: $diasEmergencia, ')
          ..write('daePosEmergente: $daePosEmergente, ')
          ..write('diasRecuperacaoPosEmergente: $diasRecuperacaoPosEmergente, ')
          ..write('intervaloFungicidaDias: $intervaloFungicidaDias, ')
          ..write('totalAplicacoesFungicida: $totalAplicacoesFungicida, ')
          ..write('daeMaturacaoCiclo: $daeMaturacaoCiclo, ')
          ..write('diasAntesR8Dessecante: $diasAntesR8Dessecante, ')
          ..write('diasAntecipacaoColheitaReal: $diasAntecipacaoColheitaReal, ')
          ..write('diasDessecacaoPrePlantio: $diasDessecacaoPrePlantio, ')
          ..write('grupoRegulagemId: $grupoRegulagemId, ')
          ..write('plantioDefinido: $plantioDefinido, ')
          ..write('ordem: $ordem, ')
          ..write('programaOperacionalIds: $programaOperacionalIds, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProgramasOperacionaisTable extends ProgramasOperacionais
    with TableInfo<$ProgramasOperacionaisTable, ProgramasOperacionai> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgramasOperacionaisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _planoIdMeta =
      const VerificationMeta('planoId');
  @override
  late final GeneratedColumn<String> planoId = GeneratedColumn<String>(
      'plano_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES planos (uid) ON DELETE CASCADE'));
  static const VerificationMeta _talhaoIdMeta =
      const VerificationMeta('talhaoId');
  @override
  late final GeneratedColumn<String> talhaoId = GeneratedColumn<String>(
      'talhao_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES talhoes (uid) ON DELETE CASCADE'));
  static const VerificationMeta _programaPaiIdMeta =
      const VerificationMeta('programaPaiId');
  @override
  late final GeneratedColumn<String> programaPaiId = GeneratedColumn<String>(
      'programa_pai_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _regraCalculoMeta =
      const VerificationMeta('regraCalculo');
  @override
  late final GeneratedColumn<String> regraCalculo = GeneratedColumn<String>(
      'regra_calculo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _estadioIdMeta =
      const VerificationMeta('estadioId');
  @override
  late final GeneratedColumn<String> estadioId = GeneratedColumn<String>(
      'estadio_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES estadios (uid) ON DELETE SET NULL'));
  static const VerificationMeta _aplicacaoIndiceMeta =
      const VerificationMeta('aplicacaoIndice');
  @override
  late final GeneratedColumn<int> aplicacaoIndice = GeneratedColumn<int>(
      'aplicacao_indice', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _ordemMeta = const VerificationMeta('ordem');
  @override
  late final GeneratedColumn<int> ordem = GeneratedColumn<int>(
      'ordem', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _incluirAdubacaoMeta =
      const VerificationMeta('incluirAdubacao');
  @override
  late final GeneratedColumn<bool> incluirAdubacao = GeneratedColumn<bool>(
      'incluir_adubacao', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("incluir_adubacao" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        uid,
        userId,
        planoId,
        talhaoId,
        programaPaiId,
        tipo,
        regraCalculo,
        estadioId,
        aplicacaoIndice,
        ordem,
        incluirAdubacao,
        createdAt,
        updatedAt,
        syncState,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'programas_operacionais';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProgramasOperacionai> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('plano_id')) {
      context.handle(_planoIdMeta,
          planoId.isAcceptableOrUnknown(data['plano_id']!, _planoIdMeta));
    } else if (isInserting) {
      context.missing(_planoIdMeta);
    }
    if (data.containsKey('talhao_id')) {
      context.handle(_talhaoIdMeta,
          talhaoId.isAcceptableOrUnknown(data['talhao_id']!, _talhaoIdMeta));
    } else if (isInserting) {
      context.missing(_talhaoIdMeta);
    }
    if (data.containsKey('programa_pai_id')) {
      context.handle(
          _programaPaiIdMeta,
          programaPaiId.isAcceptableOrUnknown(
              data['programa_pai_id']!, _programaPaiIdMeta));
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('regra_calculo')) {
      context.handle(
          _regraCalculoMeta,
          regraCalculo.isAcceptableOrUnknown(
              data['regra_calculo']!, _regraCalculoMeta));
    } else if (isInserting) {
      context.missing(_regraCalculoMeta);
    }
    if (data.containsKey('estadio_id')) {
      context.handle(_estadioIdMeta,
          estadioId.isAcceptableOrUnknown(data['estadio_id']!, _estadioIdMeta));
    }
    if (data.containsKey('aplicacao_indice')) {
      context.handle(
          _aplicacaoIndiceMeta,
          aplicacaoIndice.isAcceptableOrUnknown(
              data['aplicacao_indice']!, _aplicacaoIndiceMeta));
    }
    if (data.containsKey('ordem')) {
      context.handle(
          _ordemMeta, ordem.isAcceptableOrUnknown(data['ordem']!, _ordemMeta));
    }
    if (data.containsKey('incluir_adubacao')) {
      context.handle(
          _incluirAdubacaoMeta,
          incluirAdubacao.isAcceptableOrUnknown(
              data['incluir_adubacao']!, _incluirAdubacaoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  ProgramasOperacionai map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgramasOperacionai(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      planoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plano_id'])!,
      talhaoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}talhao_id'])!,
      programaPaiId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}programa_pai_id']),
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo'])!,
      regraCalculo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}regra_calculo'])!,
      estadioId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estadio_id']),
      aplicacaoIndice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}aplicacao_indice']),
      ordem: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordem'])!,
      incluirAdubacao: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}incluir_adubacao'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $ProgramasOperacionaisTable createAlias(String alias) {
    return $ProgramasOperacionaisTable(attachedDatabase, alias);
  }
}

class ProgramasOperacionai extends DataClass
    implements Insertable<ProgramasOperacionai> {
  final String uid;
  final String? userId;
  final String planoId;
  final String talhaoId;
  final String? programaPaiId;
  final String tipo;
  final String regraCalculo;
  final String? estadioId;
  final int? aplicacaoIndice;
  final int ordem;
  final bool incluirAdubacao;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncState;
  final DateTime? deletedAt;
  const ProgramasOperacionai(
      {required this.uid,
      this.userId,
      required this.planoId,
      required this.talhaoId,
      this.programaPaiId,
      required this.tipo,
      required this.regraCalculo,
      this.estadioId,
      this.aplicacaoIndice,
      required this.ordem,
      required this.incluirAdubacao,
      required this.createdAt,
      required this.updatedAt,
      required this.syncState,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['plano_id'] = Variable<String>(planoId);
    map['talhao_id'] = Variable<String>(talhaoId);
    if (!nullToAbsent || programaPaiId != null) {
      map['programa_pai_id'] = Variable<String>(programaPaiId);
    }
    map['tipo'] = Variable<String>(tipo);
    map['regra_calculo'] = Variable<String>(regraCalculo);
    if (!nullToAbsent || estadioId != null) {
      map['estadio_id'] = Variable<String>(estadioId);
    }
    if (!nullToAbsent || aplicacaoIndice != null) {
      map['aplicacao_indice'] = Variable<int>(aplicacaoIndice);
    }
    map['ordem'] = Variable<int>(ordem);
    map['incluir_adubacao'] = Variable<bool>(incluirAdubacao);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ProgramasOperacionaisCompanion toCompanion(bool nullToAbsent) {
    return ProgramasOperacionaisCompanion(
      uid: Value(uid),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      planoId: Value(planoId),
      talhaoId: Value(talhaoId),
      programaPaiId: programaPaiId == null && nullToAbsent
          ? const Value.absent()
          : Value(programaPaiId),
      tipo: Value(tipo),
      regraCalculo: Value(regraCalculo),
      estadioId: estadioId == null && nullToAbsent
          ? const Value.absent()
          : Value(estadioId),
      aplicacaoIndice: aplicacaoIndice == null && nullToAbsent
          ? const Value.absent()
          : Value(aplicacaoIndice),
      ordem: Value(ordem),
      incluirAdubacao: Value(incluirAdubacao),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncState: Value(syncState),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory ProgramasOperacionai.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgramasOperacionai(
      uid: serializer.fromJson<String>(json['uid']),
      userId: serializer.fromJson<String?>(json['userId']),
      planoId: serializer.fromJson<String>(json['planoId']),
      talhaoId: serializer.fromJson<String>(json['talhaoId']),
      programaPaiId: serializer.fromJson<String?>(json['programaPaiId']),
      tipo: serializer.fromJson<String>(json['tipo']),
      regraCalculo: serializer.fromJson<String>(json['regraCalculo']),
      estadioId: serializer.fromJson<String?>(json['estadioId']),
      aplicacaoIndice: serializer.fromJson<int?>(json['aplicacaoIndice']),
      ordem: serializer.fromJson<int>(json['ordem']),
      incluirAdubacao: serializer.fromJson<bool>(json['incluirAdubacao']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'userId': serializer.toJson<String?>(userId),
      'planoId': serializer.toJson<String>(planoId),
      'talhaoId': serializer.toJson<String>(talhaoId),
      'programaPaiId': serializer.toJson<String?>(programaPaiId),
      'tipo': serializer.toJson<String>(tipo),
      'regraCalculo': serializer.toJson<String>(regraCalculo),
      'estadioId': serializer.toJson<String?>(estadioId),
      'aplicacaoIndice': serializer.toJson<int?>(aplicacaoIndice),
      'ordem': serializer.toJson<int>(ordem),
      'incluirAdubacao': serializer.toJson<bool>(incluirAdubacao),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncState': serializer.toJson<String>(syncState),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  ProgramasOperacionai copyWith(
          {String? uid,
          Value<String?> userId = const Value.absent(),
          String? planoId,
          String? talhaoId,
          Value<String?> programaPaiId = const Value.absent(),
          String? tipo,
          String? regraCalculo,
          Value<String?> estadioId = const Value.absent(),
          Value<int?> aplicacaoIndice = const Value.absent(),
          int? ordem,
          bool? incluirAdubacao,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncState,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      ProgramasOperacionai(
        uid: uid ?? this.uid,
        userId: userId.present ? userId.value : this.userId,
        planoId: planoId ?? this.planoId,
        talhaoId: talhaoId ?? this.talhaoId,
        programaPaiId:
            programaPaiId.present ? programaPaiId.value : this.programaPaiId,
        tipo: tipo ?? this.tipo,
        regraCalculo: regraCalculo ?? this.regraCalculo,
        estadioId: estadioId.present ? estadioId.value : this.estadioId,
        aplicacaoIndice: aplicacaoIndice.present
            ? aplicacaoIndice.value
            : this.aplicacaoIndice,
        ordem: ordem ?? this.ordem,
        incluirAdubacao: incluirAdubacao ?? this.incluirAdubacao,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncState: syncState ?? this.syncState,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  ProgramasOperacionai copyWithCompanion(ProgramasOperacionaisCompanion data) {
    return ProgramasOperacionai(
      uid: data.uid.present ? data.uid.value : this.uid,
      userId: data.userId.present ? data.userId.value : this.userId,
      planoId: data.planoId.present ? data.planoId.value : this.planoId,
      talhaoId: data.talhaoId.present ? data.talhaoId.value : this.talhaoId,
      programaPaiId: data.programaPaiId.present
          ? data.programaPaiId.value
          : this.programaPaiId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      regraCalculo: data.regraCalculo.present
          ? data.regraCalculo.value
          : this.regraCalculo,
      estadioId: data.estadioId.present ? data.estadioId.value : this.estadioId,
      aplicacaoIndice: data.aplicacaoIndice.present
          ? data.aplicacaoIndice.value
          : this.aplicacaoIndice,
      ordem: data.ordem.present ? data.ordem.value : this.ordem,
      incluirAdubacao: data.incluirAdubacao.present
          ? data.incluirAdubacao.value
          : this.incluirAdubacao,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgramasOperacionai(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('planoId: $planoId, ')
          ..write('talhaoId: $talhaoId, ')
          ..write('programaPaiId: $programaPaiId, ')
          ..write('tipo: $tipo, ')
          ..write('regraCalculo: $regraCalculo, ')
          ..write('estadioId: $estadioId, ')
          ..write('aplicacaoIndice: $aplicacaoIndice, ')
          ..write('ordem: $ordem, ')
          ..write('incluirAdubacao: $incluirAdubacao, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      uid,
      userId,
      planoId,
      talhaoId,
      programaPaiId,
      tipo,
      regraCalculo,
      estadioId,
      aplicacaoIndice,
      ordem,
      incluirAdubacao,
      createdAt,
      updatedAt,
      syncState,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgramasOperacionai &&
          other.uid == this.uid &&
          other.userId == this.userId &&
          other.planoId == this.planoId &&
          other.talhaoId == this.talhaoId &&
          other.programaPaiId == this.programaPaiId &&
          other.tipo == this.tipo &&
          other.regraCalculo == this.regraCalculo &&
          other.estadioId == this.estadioId &&
          other.aplicacaoIndice == this.aplicacaoIndice &&
          other.ordem == this.ordem &&
          other.incluirAdubacao == this.incluirAdubacao &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncState == this.syncState &&
          other.deletedAt == this.deletedAt);
}

class ProgramasOperacionaisCompanion
    extends UpdateCompanion<ProgramasOperacionai> {
  final Value<String> uid;
  final Value<String?> userId;
  final Value<String> planoId;
  final Value<String> talhaoId;
  final Value<String?> programaPaiId;
  final Value<String> tipo;
  final Value<String> regraCalculo;
  final Value<String?> estadioId;
  final Value<int?> aplicacaoIndice;
  final Value<int> ordem;
  final Value<bool> incluirAdubacao;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncState;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const ProgramasOperacionaisCompanion({
    this.uid = const Value.absent(),
    this.userId = const Value.absent(),
    this.planoId = const Value.absent(),
    this.talhaoId = const Value.absent(),
    this.programaPaiId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.regraCalculo = const Value.absent(),
    this.estadioId = const Value.absent(),
    this.aplicacaoIndice = const Value.absent(),
    this.ordem = const Value.absent(),
    this.incluirAdubacao = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProgramasOperacionaisCompanion.insert({
    required String uid,
    this.userId = const Value.absent(),
    required String planoId,
    required String talhaoId,
    this.programaPaiId = const Value.absent(),
    required String tipo,
    required String regraCalculo,
    this.estadioId = const Value.absent(),
    this.aplicacaoIndice = const Value.absent(),
    this.ordem = const Value.absent(),
    this.incluirAdubacao = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncState = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        planoId = Value(planoId),
        talhaoId = Value(talhaoId),
        tipo = Value(tipo),
        regraCalculo = Value(regraCalculo),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<ProgramasOperacionai> custom({
    Expression<String>? uid,
    Expression<String>? userId,
    Expression<String>? planoId,
    Expression<String>? talhaoId,
    Expression<String>? programaPaiId,
    Expression<String>? tipo,
    Expression<String>? regraCalculo,
    Expression<String>? estadioId,
    Expression<int>? aplicacaoIndice,
    Expression<int>? ordem,
    Expression<bool>? incluirAdubacao,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncState,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (userId != null) 'user_id': userId,
      if (planoId != null) 'plano_id': planoId,
      if (talhaoId != null) 'talhao_id': talhaoId,
      if (programaPaiId != null) 'programa_pai_id': programaPaiId,
      if (tipo != null) 'tipo': tipo,
      if (regraCalculo != null) 'regra_calculo': regraCalculo,
      if (estadioId != null) 'estadio_id': estadioId,
      if (aplicacaoIndice != null) 'aplicacao_indice': aplicacaoIndice,
      if (ordem != null) 'ordem': ordem,
      if (incluirAdubacao != null) 'incluir_adubacao': incluirAdubacao,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncState != null) 'sync_state': syncState,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProgramasOperacionaisCompanion copyWith(
      {Value<String>? uid,
      Value<String?>? userId,
      Value<String>? planoId,
      Value<String>? talhaoId,
      Value<String?>? programaPaiId,
      Value<String>? tipo,
      Value<String>? regraCalculo,
      Value<String?>? estadioId,
      Value<int?>? aplicacaoIndice,
      Value<int>? ordem,
      Value<bool>? incluirAdubacao,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncState,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return ProgramasOperacionaisCompanion(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      planoId: planoId ?? this.planoId,
      talhaoId: talhaoId ?? this.talhaoId,
      programaPaiId: programaPaiId ?? this.programaPaiId,
      tipo: tipo ?? this.tipo,
      regraCalculo: regraCalculo ?? this.regraCalculo,
      estadioId: estadioId ?? this.estadioId,
      aplicacaoIndice: aplicacaoIndice ?? this.aplicacaoIndice,
      ordem: ordem ?? this.ordem,
      incluirAdubacao: incluirAdubacao ?? this.incluirAdubacao,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncState: syncState ?? this.syncState,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (planoId.present) {
      map['plano_id'] = Variable<String>(planoId.value);
    }
    if (talhaoId.present) {
      map['talhao_id'] = Variable<String>(talhaoId.value);
    }
    if (programaPaiId.present) {
      map['programa_pai_id'] = Variable<String>(programaPaiId.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (regraCalculo.present) {
      map['regra_calculo'] = Variable<String>(regraCalculo.value);
    }
    if (estadioId.present) {
      map['estadio_id'] = Variable<String>(estadioId.value);
    }
    if (aplicacaoIndice.present) {
      map['aplicacao_indice'] = Variable<int>(aplicacaoIndice.value);
    }
    if (ordem.present) {
      map['ordem'] = Variable<int>(ordem.value);
    }
    if (incluirAdubacao.present) {
      map['incluir_adubacao'] = Variable<bool>(incluirAdubacao.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgramasOperacionaisCompanion(')
          ..write('uid: $uid, ')
          ..write('userId: $userId, ')
          ..write('planoId: $planoId, ')
          ..write('talhaoId: $talhaoId, ')
          ..write('programaPaiId: $programaPaiId, ')
          ..write('tipo: $tipo, ')
          ..write('regraCalculo: $regraCalculo, ')
          ..write('estadioId: $estadioId, ')
          ..write('aplicacaoIndice: $aplicacaoIndice, ')
          ..write('ordem: $ordem, ')
          ..write('incluirAdubacao: $incluirAdubacao, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalMetadataTable extends LocalMetadata
    with TableInfo<$LocalMetadataTable, LocalMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_metadata';
  @override
  VerificationContext validateIntegrity(Insertable<LocalMetadataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  LocalMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalMetadataData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LocalMetadataTable createAlias(String alias) {
    return $LocalMetadataTable(attachedDatabase, alias);
  }
}

class LocalMetadataData extends DataClass
    implements Insertable<LocalMetadataData> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const LocalMetadataData(
      {required this.key, required this.value, required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalMetadataCompanion toCompanion(bool nullToAbsent) {
    return LocalMetadataCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalMetadataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalMetadataData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalMetadataData copyWith(
          {String? key, String? value, DateTime? updatedAt}) =>
      LocalMetadataData(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalMetadataData copyWithCompanion(LocalMetadataCompanion data) {
    return LocalMetadataData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalMetadataData(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalMetadataData &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class LocalMetadataCompanion extends UpdateCompanion<LocalMetadataData> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalMetadataCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalMetadataCompanion.insert({
    required String key,
    required String value,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value),
        updatedAt = Value(updatedAt);
  static Insertable<LocalMetadataData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalMetadataCompanion copyWith(
      {Value<String>? key,
      Value<String>? value,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return LocalMetadataCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalMetadataCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalUsersTable localUsers = $LocalUsersTable(this);
  late final $ClientesTable clientes = $ClientesTable(this);
  late final $FazendasTable fazendas = $FazendasTable(this);
  late final $TalhoesTable talhoes = $TalhoesTable(this);
  late final $CatalogoProdutosTable catalogoProdutos =
      $CatalogoProdutosTable(this);
  late final $ReferenciasTecnicasTable referenciasTecnicas =
      $ReferenciasTecnicasTable(this);
  late final $PlanosTable planos = $PlanosTable(this);
  late final $EstadiosTable estadios = $EstadiosTable(this);
  late final $ProdutosAplicacaoTable produtosAplicacao =
      $ProdutosAplicacaoTable(this);
  late final $EscoposAlocacaoTable escoposAlocacao =
      $EscoposAlocacaoTable(this);
  late final $AlocacoesTalhaoTable alocacoesTalhao =
      $AlocacoesTalhaoTable(this);
  late final $SementesTalhaoTable sementesTalhao = $SementesTalhaoTable(this);
  late final $CronogramasSojaTalhaoTable cronogramasSojaTalhao =
      $CronogramasSojaTalhaoTable(this);
  late final $TalhoesSafraTable talhoesSafra = $TalhoesSafraTable(this);
  late final $ProgramasOperacionaisTable programasOperacionais =
      $ProgramasOperacionaisTable(this);
  late final $LocalMetadataTable localMetadata = $LocalMetadataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        localUsers,
        clientes,
        fazendas,
        talhoes,
        catalogoProdutos,
        referenciasTecnicas,
        planos,
        estadios,
        produtosAplicacao,
        escoposAlocacao,
        alocacoesTalhao,
        sementesTalhao,
        cronogramasSojaTalhao,
        talhoesSafra,
        programasOperacionais,
        localMetadata
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('clientes',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('fazendas', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('fazendas',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('talhoes', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('planos',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('estadios', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('estadios',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('produtos_aplicacao', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('produtos_aplicacao',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('escopos_alocacao', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('produtos_aplicacao',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('alocacoes_talhao', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('talhoes',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('alocacoes_talhao', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('escopos_alocacao',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('alocacoes_talhao', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('planos',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('sementes_talhao', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('estadios',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('sementes_talhao', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('talhoes',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('sementes_talhao', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('talhoes',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('cronogramas_soja_talhao', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('planos',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('talhoes_safra', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('talhoes',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('talhoes_safra', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('planos',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('programas_operacionais', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('talhoes',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('programas_operacionais', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('estadios',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('programas_operacionais', kind: UpdateKind.update),
            ],
          ),
        ],
      );
}

typedef $$LocalUsersTableCreateCompanionBuilder = LocalUsersCompanion Function({
  required String uid,
  required String nome,
  required String email,
  Value<String?> telefone,
  Value<String?> empresa,
  Value<String?> craRegistro,
  Value<String?> avatarUrl,
  Value<bool> darkMode,
  Value<String> appIconKey,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$LocalUsersTableUpdateCompanionBuilder = LocalUsersCompanion Function({
  Value<String> uid,
  Value<String> nome,
  Value<String> email,
  Value<String?> telefone,
  Value<String?> empresa,
  Value<String?> craRegistro,
  Value<String?> avatarUrl,
  Value<bool> darkMode,
  Value<String> appIconKey,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$LocalUsersTableFilterComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get empresa => $composableBuilder(
      column: $table.empresa, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get craRegistro => $composableBuilder(
      column: $table.craRegistro, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatarUrl => $composableBuilder(
      column: $table.avatarUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get darkMode => $composableBuilder(
      column: $table.darkMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get appIconKey => $composableBuilder(
      column: $table.appIconKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get empresa => $composableBuilder(
      column: $table.empresa, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get craRegistro => $composableBuilder(
      column: $table.craRegistro, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
      column: $table.avatarUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get darkMode => $composableBuilder(
      column: $table.darkMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get appIconKey => $composableBuilder(
      column: $table.appIconKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocalUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get telefone =>
      $composableBuilder(column: $table.telefone, builder: (column) => column);

  GeneratedColumn<String> get empresa =>
      $composableBuilder(column: $table.empresa, builder: (column) => column);

  GeneratedColumn<String> get craRegistro => $composableBuilder(
      column: $table.craRegistro, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<bool> get darkMode =>
      $composableBuilder(column: $table.darkMode, builder: (column) => column);

  GeneratedColumn<String> get appIconKey => $composableBuilder(
      column: $table.appIconKey, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalUsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalUsersTable,
    LocalUser,
    $$LocalUsersTableFilterComposer,
    $$LocalUsersTableOrderingComposer,
    $$LocalUsersTableAnnotationComposer,
    $$LocalUsersTableCreateCompanionBuilder,
    $$LocalUsersTableUpdateCompanionBuilder,
    (LocalUser, BaseReferences<_$AppDatabase, $LocalUsersTable, LocalUser>),
    LocalUser,
    PrefetchHooks Function()> {
  $$LocalUsersTableTableManager(_$AppDatabase db, $LocalUsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String?> telefone = const Value.absent(),
            Value<String?> empresa = const Value.absent(),
            Value<String?> craRegistro = const Value.absent(),
            Value<String?> avatarUrl = const Value.absent(),
            Value<bool> darkMode = const Value.absent(),
            Value<String> appIconKey = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalUsersCompanion(
            uid: uid,
            nome: nome,
            email: email,
            telefone: telefone,
            empresa: empresa,
            craRegistro: craRegistro,
            avatarUrl: avatarUrl,
            darkMode: darkMode,
            appIconKey: appIconKey,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            required String nome,
            required String email,
            Value<String?> telefone = const Value.absent(),
            Value<String?> empresa = const Value.absent(),
            Value<String?> craRegistro = const Value.absent(),
            Value<String?> avatarUrl = const Value.absent(),
            Value<bool> darkMode = const Value.absent(),
            Value<String> appIconKey = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalUsersCompanion.insert(
            uid: uid,
            nome: nome,
            email: email,
            telefone: telefone,
            empresa: empresa,
            craRegistro: craRegistro,
            avatarUrl: avatarUrl,
            darkMode: darkMode,
            appIconKey: appIconKey,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalUsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalUsersTable,
    LocalUser,
    $$LocalUsersTableFilterComposer,
    $$LocalUsersTableOrderingComposer,
    $$LocalUsersTableAnnotationComposer,
    $$LocalUsersTableCreateCompanionBuilder,
    $$LocalUsersTableUpdateCompanionBuilder,
    (LocalUser, BaseReferences<_$AppDatabase, $LocalUsersTable, LocalUser>),
    LocalUser,
    PrefetchHooks Function()>;
typedef $$ClientesTableCreateCompanionBuilder = ClientesCompanion Function({
  required String uid,
  Value<String?> userId,
  required String nome,
  Value<String?> cpfCnpj,
  Value<String?> telefone,
  Value<String?> email,
  Value<String?> cidade,
  Value<String?> uf,
  Value<bool> ativo,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$ClientesTableUpdateCompanionBuilder = ClientesCompanion Function({
  Value<String> uid,
  Value<String?> userId,
  Value<String> nome,
  Value<String?> cpfCnpj,
  Value<String?> telefone,
  Value<String?> email,
  Value<String?> cidade,
  Value<String?> uf,
  Value<bool> ativo,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$ClientesTableReferences
    extends BaseReferences<_$AppDatabase, $ClientesTable, Cliente> {
  $$ClientesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FazendasTable, List<Fazenda>> _fazendasRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.fazendas,
          aliasName:
              $_aliasNameGenerator(db.clientes.uid, db.fazendas.clienteId));

  $$FazendasTableProcessedTableManager get fazendasRefs {
    final manager = $$FazendasTableTableManager($_db, $_db.fazendas)
        .filter((f) => f.clienteId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache = $_typedResult.readTableOrNull(_fazendasRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PlanosTable, List<Plano>> _planosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.planos,
          aliasName:
              $_aliasNameGenerator(db.clientes.uid, db.planos.clienteId));

  $$PlanosTableProcessedTableManager get planosRefs {
    final manager = $$PlanosTableTableManager($_db, $_db.planos)
        .filter((f) => f.clienteId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache = $_typedResult.readTableOrNull(_planosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ClientesTableFilterComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cpfCnpj => $composableBuilder(
      column: $table.cpfCnpj, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cidade => $composableBuilder(
      column: $table.cidade, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uf => $composableBuilder(
      column: $table.uf, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> fazendasRefs(
      Expression<bool> Function($$FazendasTableFilterComposer f) f) {
    final $$FazendasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.fazendas,
        getReferencedColumn: (t) => t.clienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FazendasTableFilterComposer(
              $db: $db,
              $table: $db.fazendas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> planosRefs(
      Expression<bool> Function($$PlanosTableFilterComposer f) f) {
    final $$PlanosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.planos,
        getReferencedColumn: (t) => t.clienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanosTableFilterComposer(
              $db: $db,
              $table: $db.planos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ClientesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cpfCnpj => $composableBuilder(
      column: $table.cpfCnpj, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cidade => $composableBuilder(
      column: $table.cidade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uf => $composableBuilder(
      column: $table.uf, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$ClientesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get cpfCnpj =>
      $composableBuilder(column: $table.cpfCnpj, builder: (column) => column);

  GeneratedColumn<String> get telefone =>
      $composableBuilder(column: $table.telefone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get cidade =>
      $composableBuilder(column: $table.cidade, builder: (column) => column);

  GeneratedColumn<String> get uf =>
      $composableBuilder(column: $table.uf, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> fazendasRefs<T extends Object>(
      Expression<T> Function($$FazendasTableAnnotationComposer a) f) {
    final $$FazendasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.fazendas,
        getReferencedColumn: (t) => t.clienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FazendasTableAnnotationComposer(
              $db: $db,
              $table: $db.fazendas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> planosRefs<T extends Object>(
      Expression<T> Function($$PlanosTableAnnotationComposer a) f) {
    final $$PlanosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.planos,
        getReferencedColumn: (t) => t.clienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanosTableAnnotationComposer(
              $db: $db,
              $table: $db.planos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ClientesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClientesTable,
    Cliente,
    $$ClientesTableFilterComposer,
    $$ClientesTableOrderingComposer,
    $$ClientesTableAnnotationComposer,
    $$ClientesTableCreateCompanionBuilder,
    $$ClientesTableUpdateCompanionBuilder,
    (Cliente, $$ClientesTableReferences),
    Cliente,
    PrefetchHooks Function({bool fazendasRefs, bool planosRefs})> {
  $$ClientesTableTableManager(_$AppDatabase db, $ClientesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String?> cpfCnpj = const Value.absent(),
            Value<String?> telefone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> cidade = const Value.absent(),
            Value<String?> uf = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientesCompanion(
            uid: uid,
            userId: userId,
            nome: nome,
            cpfCnpj: cpfCnpj,
            telefone: telefone,
            email: email,
            cidade: cidade,
            uf: uf,
            ativo: ativo,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            Value<String?> userId = const Value.absent(),
            required String nome,
            Value<String?> cpfCnpj = const Value.absent(),
            Value<String?> telefone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> cidade = const Value.absent(),
            Value<String?> uf = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientesCompanion.insert(
            uid: uid,
            userId: userId,
            nome: nome,
            cpfCnpj: cpfCnpj,
            telefone: telefone,
            email: email,
            cidade: cidade,
            uf: uf,
            ativo: ativo,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ClientesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({fazendasRefs = false, planosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (fazendasRefs) db.fazendas,
                if (planosRefs) db.planos
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (fazendasRefs)
                    await $_getPrefetchedData<Cliente, $ClientesTable, Fazenda>(
                        currentTable: table,
                        referencedTable:
                            $$ClientesTableReferences._fazendasRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClientesTableReferences(db, table, p0)
                                .fazendasRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.clienteId == item.uid),
                        typedResults: items),
                  if (planosRefs)
                    await $_getPrefetchedData<Cliente, $ClientesTable, Plano>(
                        currentTable: table,
                        referencedTable:
                            $$ClientesTableReferences._planosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClientesTableReferences(db, table, p0).planosRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.clienteId == item.uid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ClientesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClientesTable,
    Cliente,
    $$ClientesTableFilterComposer,
    $$ClientesTableOrderingComposer,
    $$ClientesTableAnnotationComposer,
    $$ClientesTableCreateCompanionBuilder,
    $$ClientesTableUpdateCompanionBuilder,
    (Cliente, $$ClientesTableReferences),
    Cliente,
    PrefetchHooks Function({bool fazendasRefs, bool planosRefs})>;
typedef $$FazendasTableCreateCompanionBuilder = FazendasCompanion Function({
  required String uid,
  Value<String?> userId,
  required String clienteId,
  required String nome,
  required double areaHa,
  required String cultura,
  required String safra,
  Value<String?> municipio,
  Value<String?> uf,
  Value<bool> ativo,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$FazendasTableUpdateCompanionBuilder = FazendasCompanion Function({
  Value<String> uid,
  Value<String?> userId,
  Value<String> clienteId,
  Value<String> nome,
  Value<double> areaHa,
  Value<String> cultura,
  Value<String> safra,
  Value<String?> municipio,
  Value<String?> uf,
  Value<bool> ativo,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$FazendasTableReferences
    extends BaseReferences<_$AppDatabase, $FazendasTable, Fazenda> {
  $$FazendasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientesTable _clienteIdTable(_$AppDatabase db) =>
      db.clientes.createAlias(
          $_aliasNameGenerator(db.fazendas.clienteId, db.clientes.uid));

  $$ClientesTableProcessedTableManager get clienteId {
    final $_column = $_itemColumn<String>('cliente_id')!;

    final manager = $$ClientesTableTableManager($_db, $_db.clientes)
        .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clienteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TalhoesTable, List<Talhoe>> _talhoesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.talhoes,
          aliasName:
              $_aliasNameGenerator(db.fazendas.uid, db.talhoes.fazendaId));

  $$TalhoesTableProcessedTableManager get talhoesRefs {
    final manager = $$TalhoesTableTableManager($_db, $_db.talhoes)
        .filter((f) => f.fazendaId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache = $_typedResult.readTableOrNull(_talhoesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PlanosTable, List<Plano>> _planosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.planos,
          aliasName:
              $_aliasNameGenerator(db.fazendas.uid, db.planos.fazendaId));

  $$PlanosTableProcessedTableManager get planosRefs {
    final manager = $$PlanosTableTableManager($_db, $_db.planos)
        .filter((f) => f.fazendaId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache = $_typedResult.readTableOrNull(_planosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FazendasTableFilterComposer
    extends Composer<_$AppDatabase, $FazendasTable> {
  $$FazendasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get areaHa => $composableBuilder(
      column: $table.areaHa, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cultura => $composableBuilder(
      column: $table.cultura, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get safra => $composableBuilder(
      column: $table.safra, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get municipio => $composableBuilder(
      column: $table.municipio, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uf => $composableBuilder(
      column: $table.uf, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$ClientesTableFilterComposer get clienteId {
    final $$ClientesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clienteId,
        referencedTable: $db.clientes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientesTableFilterComposer(
              $db: $db,
              $table: $db.clientes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> talhoesRefs(
      Expression<bool> Function($$TalhoesTableFilterComposer f) f) {
    final $$TalhoesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.talhoes,
        getReferencedColumn: (t) => t.fazendaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesTableFilterComposer(
              $db: $db,
              $table: $db.talhoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> planosRefs(
      Expression<bool> Function($$PlanosTableFilterComposer f) f) {
    final $$PlanosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.planos,
        getReferencedColumn: (t) => t.fazendaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanosTableFilterComposer(
              $db: $db,
              $table: $db.planos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FazendasTableOrderingComposer
    extends Composer<_$AppDatabase, $FazendasTable> {
  $$FazendasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get areaHa => $composableBuilder(
      column: $table.areaHa, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cultura => $composableBuilder(
      column: $table.cultura, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get safra => $composableBuilder(
      column: $table.safra, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get municipio => $composableBuilder(
      column: $table.municipio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uf => $composableBuilder(
      column: $table.uf, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$ClientesTableOrderingComposer get clienteId {
    final $$ClientesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clienteId,
        referencedTable: $db.clientes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientesTableOrderingComposer(
              $db: $db,
              $table: $db.clientes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FazendasTableAnnotationComposer
    extends Composer<_$AppDatabase, $FazendasTable> {
  $$FazendasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<double> get areaHa =>
      $composableBuilder(column: $table.areaHa, builder: (column) => column);

  GeneratedColumn<String> get cultura =>
      $composableBuilder(column: $table.cultura, builder: (column) => column);

  GeneratedColumn<String> get safra =>
      $composableBuilder(column: $table.safra, builder: (column) => column);

  GeneratedColumn<String> get municipio =>
      $composableBuilder(column: $table.municipio, builder: (column) => column);

  GeneratedColumn<String> get uf =>
      $composableBuilder(column: $table.uf, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$ClientesTableAnnotationComposer get clienteId {
    final $$ClientesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clienteId,
        referencedTable: $db.clientes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientesTableAnnotationComposer(
              $db: $db,
              $table: $db.clientes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> talhoesRefs<T extends Object>(
      Expression<T> Function($$TalhoesTableAnnotationComposer a) f) {
    final $$TalhoesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.talhoes,
        getReferencedColumn: (t) => t.fazendaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesTableAnnotationComposer(
              $db: $db,
              $table: $db.talhoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> planosRefs<T extends Object>(
      Expression<T> Function($$PlanosTableAnnotationComposer a) f) {
    final $$PlanosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.planos,
        getReferencedColumn: (t) => t.fazendaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanosTableAnnotationComposer(
              $db: $db,
              $table: $db.planos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FazendasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FazendasTable,
    Fazenda,
    $$FazendasTableFilterComposer,
    $$FazendasTableOrderingComposer,
    $$FazendasTableAnnotationComposer,
    $$FazendasTableCreateCompanionBuilder,
    $$FazendasTableUpdateCompanionBuilder,
    (Fazenda, $$FazendasTableReferences),
    Fazenda,
    PrefetchHooks Function(
        {bool clienteId, bool talhoesRefs, bool planosRefs})> {
  $$FazendasTableTableManager(_$AppDatabase db, $FazendasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FazendasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FazendasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FazendasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> clienteId = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<double> areaHa = const Value.absent(),
            Value<String> cultura = const Value.absent(),
            Value<String> safra = const Value.absent(),
            Value<String?> municipio = const Value.absent(),
            Value<String?> uf = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FazendasCompanion(
            uid: uid,
            userId: userId,
            clienteId: clienteId,
            nome: nome,
            areaHa: areaHa,
            cultura: cultura,
            safra: safra,
            municipio: municipio,
            uf: uf,
            ativo: ativo,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            Value<String?> userId = const Value.absent(),
            required String clienteId,
            required String nome,
            required double areaHa,
            required String cultura,
            required String safra,
            Value<String?> municipio = const Value.absent(),
            Value<String?> uf = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FazendasCompanion.insert(
            uid: uid,
            userId: userId,
            clienteId: clienteId,
            nome: nome,
            areaHa: areaHa,
            cultura: cultura,
            safra: safra,
            municipio: municipio,
            uf: uf,
            ativo: ativo,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$FazendasTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {clienteId = false, talhoesRefs = false, planosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (talhoesRefs) db.talhoes,
                if (planosRefs) db.planos
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (clienteId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.clienteId,
                    referencedTable:
                        $$FazendasTableReferences._clienteIdTable(db),
                    referencedColumn:
                        $$FazendasTableReferences._clienteIdTable(db).uid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (talhoesRefs)
                    await $_getPrefetchedData<Fazenda, $FazendasTable, Talhoe>(
                        currentTable: table,
                        referencedTable:
                            $$FazendasTableReferences._talhoesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FazendasTableReferences(db, table, p0)
                                .talhoesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.fazendaId == item.uid),
                        typedResults: items),
                  if (planosRefs)
                    await $_getPrefetchedData<Fazenda, $FazendasTable, Plano>(
                        currentTable: table,
                        referencedTable:
                            $$FazendasTableReferences._planosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FazendasTableReferences(db, table, p0).planosRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.fazendaId == item.uid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FazendasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FazendasTable,
    Fazenda,
    $$FazendasTableFilterComposer,
    $$FazendasTableOrderingComposer,
    $$FazendasTableAnnotationComposer,
    $$FazendasTableCreateCompanionBuilder,
    $$FazendasTableUpdateCompanionBuilder,
    (Fazenda, $$FazendasTableReferences),
    Fazenda,
    PrefetchHooks Function(
        {bool clienteId, bool talhoesRefs, bool planosRefs})>;
typedef $$TalhoesTableCreateCompanionBuilder = TalhoesCompanion Function({
  required String uid,
  Value<String?> userId,
  required String fazendaId,
  required String nome,
  required double areaHa,
  Value<String?> observacao,
  Value<bool> ativo,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$TalhoesTableUpdateCompanionBuilder = TalhoesCompanion Function({
  Value<String> uid,
  Value<String?> userId,
  Value<String> fazendaId,
  Value<String> nome,
  Value<double> areaHa,
  Value<String?> observacao,
  Value<bool> ativo,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$TalhoesTableReferences
    extends BaseReferences<_$AppDatabase, $TalhoesTable, Talhoe> {
  $$TalhoesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FazendasTable _fazendaIdTable(_$AppDatabase db) => db.fazendas
      .createAlias($_aliasNameGenerator(db.talhoes.fazendaId, db.fazendas.uid));

  $$FazendasTableProcessedTableManager get fazendaId {
    final $_column = $_itemColumn<String>('fazenda_id')!;

    final manager = $$FazendasTableTableManager($_db, $_db.fazendas)
        .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fazendaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$AlocacoesTalhaoTable, List<AlocacoesTalhaoData>>
      _alocacoesTalhaoRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.alocacoesTalhao,
              aliasName: $_aliasNameGenerator(
                  db.talhoes.uid, db.alocacoesTalhao.talhaoId));

  $$AlocacoesTalhaoTableProcessedTableManager get alocacoesTalhaoRefs {
    final manager = $$AlocacoesTalhaoTableTableManager(
            $_db, $_db.alocacoesTalhao)
        .filter((f) => f.talhaoId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache =
        $_typedResult.readTableOrNull(_alocacoesTalhaoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SementesTalhaoTable, List<SementesTalhaoData>>
      _sementesTalhaoRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.sementesTalhao,
              aliasName: $_aliasNameGenerator(
                  db.talhoes.uid, db.sementesTalhao.talhaoId));

  $$SementesTalhaoTableProcessedTableManager get sementesTalhaoRefs {
    final manager = $$SementesTalhaoTableTableManager($_db, $_db.sementesTalhao)
        .filter((f) => f.talhaoId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache = $_typedResult.readTableOrNull(_sementesTalhaoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CronogramasSojaTalhaoTable,
      List<CronogramasSojaTalhaoData>> _cronogramasSojaTalhaoRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.cronogramasSojaTalhao,
          aliasName: $_aliasNameGenerator(
              db.talhoes.uid, db.cronogramasSojaTalhao.talhaoId));

  $$CronogramasSojaTalhaoTableProcessedTableManager
      get cronogramasSojaTalhaoRefs {
    final manager = $$CronogramasSojaTalhaoTableTableManager(
            $_db, $_db.cronogramasSojaTalhao)
        .filter((f) => f.talhaoId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache =
        $_typedResult.readTableOrNull(_cronogramasSojaTalhaoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TalhoesSafraTable, List<TalhoesSafraData>>
      _talhoesSafraRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.talhoesSafra,
          aliasName:
              $_aliasNameGenerator(db.talhoes.uid, db.talhoesSafra.talhaoId));

  $$TalhoesSafraTableProcessedTableManager get talhoesSafraRefs {
    final manager = $$TalhoesSafraTableTableManager($_db, $_db.talhoesSafra)
        .filter((f) => f.talhaoId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache = $_typedResult.readTableOrNull(_talhoesSafraRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ProgramasOperacionaisTable,
      List<ProgramasOperacionai>> _programasOperacionaisRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.programasOperacionais,
          aliasName: $_aliasNameGenerator(
              db.talhoes.uid, db.programasOperacionais.talhaoId));

  $$ProgramasOperacionaisTableProcessedTableManager
      get programasOperacionaisRefs {
    final manager = $$ProgramasOperacionaisTableTableManager(
            $_db, $_db.programasOperacionais)
        .filter((f) => f.talhaoId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache =
        $_typedResult.readTableOrNull(_programasOperacionaisRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TalhoesTableFilterComposer
    extends Composer<_$AppDatabase, $TalhoesTable> {
  $$TalhoesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get areaHa => $composableBuilder(
      column: $table.areaHa, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$FazendasTableFilterComposer get fazendaId {
    final $$FazendasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fazendaId,
        referencedTable: $db.fazendas,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FazendasTableFilterComposer(
              $db: $db,
              $table: $db.fazendas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> alocacoesTalhaoRefs(
      Expression<bool> Function($$AlocacoesTalhaoTableFilterComposer f) f) {
    final $$AlocacoesTalhaoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.alocacoesTalhao,
        getReferencedColumn: (t) => t.talhaoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlocacoesTalhaoTableFilterComposer(
              $db: $db,
              $table: $db.alocacoesTalhao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> sementesTalhaoRefs(
      Expression<bool> Function($$SementesTalhaoTableFilterComposer f) f) {
    final $$SementesTalhaoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.sementesTalhao,
        getReferencedColumn: (t) => t.talhaoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SementesTalhaoTableFilterComposer(
              $db: $db,
              $table: $db.sementesTalhao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> cronogramasSojaTalhaoRefs(
      Expression<bool> Function($$CronogramasSojaTalhaoTableFilterComposer f)
          f) {
    final $$CronogramasSojaTalhaoTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.uid,
            referencedTable: $db.cronogramasSojaTalhao,
            getReferencedColumn: (t) => t.talhaoId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$CronogramasSojaTalhaoTableFilterComposer(
                  $db: $db,
                  $table: $db.cronogramasSojaTalhao,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> talhoesSafraRefs(
      Expression<bool> Function($$TalhoesSafraTableFilterComposer f) f) {
    final $$TalhoesSafraTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.talhoesSafra,
        getReferencedColumn: (t) => t.talhaoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesSafraTableFilterComposer(
              $db: $db,
              $table: $db.talhoesSafra,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> programasOperacionaisRefs(
      Expression<bool> Function($$ProgramasOperacionaisTableFilterComposer f)
          f) {
    final $$ProgramasOperacionaisTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.uid,
            referencedTable: $db.programasOperacionais,
            getReferencedColumn: (t) => t.talhaoId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ProgramasOperacionaisTableFilterComposer(
                  $db: $db,
                  $table: $db.programasOperacionais,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TalhoesTableOrderingComposer
    extends Composer<_$AppDatabase, $TalhoesTable> {
  $$TalhoesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get areaHa => $composableBuilder(
      column: $table.areaHa, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$FazendasTableOrderingComposer get fazendaId {
    final $$FazendasTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fazendaId,
        referencedTable: $db.fazendas,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FazendasTableOrderingComposer(
              $db: $db,
              $table: $db.fazendas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TalhoesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TalhoesTable> {
  $$TalhoesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<double> get areaHa =>
      $composableBuilder(column: $table.areaHa, builder: (column) => column);

  GeneratedColumn<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$FazendasTableAnnotationComposer get fazendaId {
    final $$FazendasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fazendaId,
        referencedTable: $db.fazendas,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FazendasTableAnnotationComposer(
              $db: $db,
              $table: $db.fazendas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> alocacoesTalhaoRefs<T extends Object>(
      Expression<T> Function($$AlocacoesTalhaoTableAnnotationComposer a) f) {
    final $$AlocacoesTalhaoTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.alocacoesTalhao,
        getReferencedColumn: (t) => t.talhaoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlocacoesTalhaoTableAnnotationComposer(
              $db: $db,
              $table: $db.alocacoesTalhao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> sementesTalhaoRefs<T extends Object>(
      Expression<T> Function($$SementesTalhaoTableAnnotationComposer a) f) {
    final $$SementesTalhaoTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.sementesTalhao,
        getReferencedColumn: (t) => t.talhaoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SementesTalhaoTableAnnotationComposer(
              $db: $db,
              $table: $db.sementesTalhao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> cronogramasSojaTalhaoRefs<T extends Object>(
      Expression<T> Function($$CronogramasSojaTalhaoTableAnnotationComposer a)
          f) {
    final $$CronogramasSojaTalhaoTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.uid,
            referencedTable: $db.cronogramasSojaTalhao,
            getReferencedColumn: (t) => t.talhaoId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$CronogramasSojaTalhaoTableAnnotationComposer(
                  $db: $db,
                  $table: $db.cronogramasSojaTalhao,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> talhoesSafraRefs<T extends Object>(
      Expression<T> Function($$TalhoesSafraTableAnnotationComposer a) f) {
    final $$TalhoesSafraTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.talhoesSafra,
        getReferencedColumn: (t) => t.talhaoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesSafraTableAnnotationComposer(
              $db: $db,
              $table: $db.talhoesSafra,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> programasOperacionaisRefs<T extends Object>(
      Expression<T> Function($$ProgramasOperacionaisTableAnnotationComposer a)
          f) {
    final $$ProgramasOperacionaisTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.uid,
            referencedTable: $db.programasOperacionais,
            getReferencedColumn: (t) => t.talhaoId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ProgramasOperacionaisTableAnnotationComposer(
                  $db: $db,
                  $table: $db.programasOperacionais,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TalhoesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TalhoesTable,
    Talhoe,
    $$TalhoesTableFilterComposer,
    $$TalhoesTableOrderingComposer,
    $$TalhoesTableAnnotationComposer,
    $$TalhoesTableCreateCompanionBuilder,
    $$TalhoesTableUpdateCompanionBuilder,
    (Talhoe, $$TalhoesTableReferences),
    Talhoe,
    PrefetchHooks Function(
        {bool fazendaId,
        bool alocacoesTalhaoRefs,
        bool sementesTalhaoRefs,
        bool cronogramasSojaTalhaoRefs,
        bool talhoesSafraRefs,
        bool programasOperacionaisRefs})> {
  $$TalhoesTableTableManager(_$AppDatabase db, $TalhoesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TalhoesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TalhoesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TalhoesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> fazendaId = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<double> areaHa = const Value.absent(),
            Value<String?> observacao = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TalhoesCompanion(
            uid: uid,
            userId: userId,
            fazendaId: fazendaId,
            nome: nome,
            areaHa: areaHa,
            observacao: observacao,
            ativo: ativo,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            Value<String?> userId = const Value.absent(),
            required String fazendaId,
            required String nome,
            required double areaHa,
            Value<String?> observacao = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TalhoesCompanion.insert(
            uid: uid,
            userId: userId,
            fazendaId: fazendaId,
            nome: nome,
            areaHa: areaHa,
            observacao: observacao,
            ativo: ativo,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TalhoesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {fazendaId = false,
              alocacoesTalhaoRefs = false,
              sementesTalhaoRefs = false,
              cronogramasSojaTalhaoRefs = false,
              talhoesSafraRefs = false,
              programasOperacionaisRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (alocacoesTalhaoRefs) db.alocacoesTalhao,
                if (sementesTalhaoRefs) db.sementesTalhao,
                if (cronogramasSojaTalhaoRefs) db.cronogramasSojaTalhao,
                if (talhoesSafraRefs) db.talhoesSafra,
                if (programasOperacionaisRefs) db.programasOperacionais
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (fazendaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.fazendaId,
                    referencedTable:
                        $$TalhoesTableReferences._fazendaIdTable(db),
                    referencedColumn:
                        $$TalhoesTableReferences._fazendaIdTable(db).uid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (alocacoesTalhaoRefs)
                    await $_getPrefetchedData<Talhoe, $TalhoesTable,
                            AlocacoesTalhaoData>(
                        currentTable: table,
                        referencedTable: $$TalhoesTableReferences
                            ._alocacoesTalhaoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TalhoesTableReferences(db, table, p0)
                                .alocacoesTalhaoRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.talhaoId == item.uid),
                        typedResults: items),
                  if (sementesTalhaoRefs)
                    await $_getPrefetchedData<Talhoe, $TalhoesTable,
                            SementesTalhaoData>(
                        currentTable: table,
                        referencedTable: $$TalhoesTableReferences
                            ._sementesTalhaoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TalhoesTableReferences(db, table, p0)
                                .sementesTalhaoRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.talhaoId == item.uid),
                        typedResults: items),
                  if (cronogramasSojaTalhaoRefs)
                    await $_getPrefetchedData<Talhoe, $TalhoesTable,
                            CronogramasSojaTalhaoData>(
                        currentTable: table,
                        referencedTable: $$TalhoesTableReferences
                            ._cronogramasSojaTalhaoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TalhoesTableReferences(db, table, p0)
                                .cronogramasSojaTalhaoRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.talhaoId == item.uid),
                        typedResults: items),
                  if (talhoesSafraRefs)
                    await $_getPrefetchedData<Talhoe, $TalhoesTable,
                            TalhoesSafraData>(
                        currentTable: table,
                        referencedTable:
                            $$TalhoesTableReferences._talhoesSafraRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TalhoesTableReferences(db, table, p0)
                                .talhoesSafraRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.talhaoId == item.uid),
                        typedResults: items),
                  if (programasOperacionaisRefs)
                    await $_getPrefetchedData<Talhoe, $TalhoesTable,
                            ProgramasOperacionai>(
                        currentTable: table,
                        referencedTable: $$TalhoesTableReferences
                            ._programasOperacionaisRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TalhoesTableReferences(db, table, p0)
                                .programasOperacionaisRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.talhaoId == item.uid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TalhoesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TalhoesTable,
    Talhoe,
    $$TalhoesTableFilterComposer,
    $$TalhoesTableOrderingComposer,
    $$TalhoesTableAnnotationComposer,
    $$TalhoesTableCreateCompanionBuilder,
    $$TalhoesTableUpdateCompanionBuilder,
    (Talhoe, $$TalhoesTableReferences),
    Talhoe,
    PrefetchHooks Function(
        {bool fazendaId,
        bool alocacoesTalhaoRefs,
        bool sementesTalhaoRefs,
        bool cronogramasSojaTalhaoRefs,
        bool talhoesSafraRefs,
        bool programasOperacionaisRefs})>;
typedef $$CatalogoProdutosTableCreateCompanionBuilder
    = CatalogoProdutosCompanion Function({
  required String uid,
  Value<String?> userId,
  required String nomeComercial,
  Value<String?> ingredienteAtivo,
  required String categoria,
  required String unidadePadrao,
  Value<double?> doseMin,
  Value<double?> doseMax,
  Value<double?> precoUnitario,
  Value<String?> fabricante,
  Value<String?> observacoes,
  Value<String?> culturas,
  Value<bool> ativo,
  Value<bool> isSeed,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$CatalogoProdutosTableUpdateCompanionBuilder
    = CatalogoProdutosCompanion Function({
  Value<String> uid,
  Value<String?> userId,
  Value<String> nomeComercial,
  Value<String?> ingredienteAtivo,
  Value<String> categoria,
  Value<String> unidadePadrao,
  Value<double?> doseMin,
  Value<double?> doseMax,
  Value<double?> precoUnitario,
  Value<String?> fabricante,
  Value<String?> observacoes,
  Value<String?> culturas,
  Value<bool> ativo,
  Value<bool> isSeed,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$CatalogoProdutosTableReferences extends BaseReferences<
    _$AppDatabase, $CatalogoProdutosTable, CatalogoProduto> {
  $$CatalogoProdutosTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProdutosAplicacaoTable,
      List<ProdutosAplicacaoData>> _produtosAplicacaoRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.produtosAplicacao,
          aliasName: $_aliasNameGenerator(
              db.catalogoProdutos.uid, db.produtosAplicacao.catalogoProdutoId));

  $$ProdutosAplicacaoTableProcessedTableManager get produtosAplicacaoRefs {
    final manager = $$ProdutosAplicacaoTableTableManager(
            $_db, $_db.produtosAplicacao)
        .filter((f) =>
            f.catalogoProdutoId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache =
        $_typedResult.readTableOrNull(_produtosAplicacaoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CatalogoProdutosTableFilterComposer
    extends Composer<_$AppDatabase, $CatalogoProdutosTable> {
  $$CatalogoProdutosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nomeComercial => $composableBuilder(
      column: $table.nomeComercial, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ingredienteAtivo => $composableBuilder(
      column: $table.ingredienteAtivo,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unidadePadrao => $composableBuilder(
      column: $table.unidadePadrao, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get doseMin => $composableBuilder(
      column: $table.doseMin, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get doseMax => $composableBuilder(
      column: $table.doseMax, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precoUnitario => $composableBuilder(
      column: $table.precoUnitario, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fabricante => $composableBuilder(
      column: $table.fabricante, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get culturas => $composableBuilder(
      column: $table.culturas, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSeed => $composableBuilder(
      column: $table.isSeed, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> produtosAplicacaoRefs(
      Expression<bool> Function($$ProdutosAplicacaoTableFilterComposer f) f) {
    final $$ProdutosAplicacaoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.produtosAplicacao,
        getReferencedColumn: (t) => t.catalogoProdutoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProdutosAplicacaoTableFilterComposer(
              $db: $db,
              $table: $db.produtosAplicacao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CatalogoProdutosTableOrderingComposer
    extends Composer<_$AppDatabase, $CatalogoProdutosTable> {
  $$CatalogoProdutosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nomeComercial => $composableBuilder(
      column: $table.nomeComercial,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ingredienteAtivo => $composableBuilder(
      column: $table.ingredienteAtivo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unidadePadrao => $composableBuilder(
      column: $table.unidadePadrao,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get doseMin => $composableBuilder(
      column: $table.doseMin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get doseMax => $composableBuilder(
      column: $table.doseMax, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precoUnitario => $composableBuilder(
      column: $table.precoUnitario,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fabricante => $composableBuilder(
      column: $table.fabricante, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get culturas => $composableBuilder(
      column: $table.culturas, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSeed => $composableBuilder(
      column: $table.isSeed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$CatalogoProdutosTableAnnotationComposer
    extends Composer<_$AppDatabase, $CatalogoProdutosTable> {
  $$CatalogoProdutosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get nomeComercial => $composableBuilder(
      column: $table.nomeComercial, builder: (column) => column);

  GeneratedColumn<String> get ingredienteAtivo => $composableBuilder(
      column: $table.ingredienteAtivo, builder: (column) => column);

  GeneratedColumn<String> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);

  GeneratedColumn<String> get unidadePadrao => $composableBuilder(
      column: $table.unidadePadrao, builder: (column) => column);

  GeneratedColumn<double> get doseMin =>
      $composableBuilder(column: $table.doseMin, builder: (column) => column);

  GeneratedColumn<double> get doseMax =>
      $composableBuilder(column: $table.doseMax, builder: (column) => column);

  GeneratedColumn<double> get precoUnitario => $composableBuilder(
      column: $table.precoUnitario, builder: (column) => column);

  GeneratedColumn<String> get fabricante => $composableBuilder(
      column: $table.fabricante, builder: (column) => column);

  GeneratedColumn<String> get observacoes => $composableBuilder(
      column: $table.observacoes, builder: (column) => column);

  GeneratedColumn<String> get culturas =>
      $composableBuilder(column: $table.culturas, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<bool> get isSeed =>
      $composableBuilder(column: $table.isSeed, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> produtosAplicacaoRefs<T extends Object>(
      Expression<T> Function($$ProdutosAplicacaoTableAnnotationComposer a) f) {
    final $$ProdutosAplicacaoTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.uid,
            referencedTable: $db.produtosAplicacao,
            getReferencedColumn: (t) => t.catalogoProdutoId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ProdutosAplicacaoTableAnnotationComposer(
                  $db: $db,
                  $table: $db.produtosAplicacao,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$CatalogoProdutosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CatalogoProdutosTable,
    CatalogoProduto,
    $$CatalogoProdutosTableFilterComposer,
    $$CatalogoProdutosTableOrderingComposer,
    $$CatalogoProdutosTableAnnotationComposer,
    $$CatalogoProdutosTableCreateCompanionBuilder,
    $$CatalogoProdutosTableUpdateCompanionBuilder,
    (CatalogoProduto, $$CatalogoProdutosTableReferences),
    CatalogoProduto,
    PrefetchHooks Function({bool produtosAplicacaoRefs})> {
  $$CatalogoProdutosTableTableManager(
      _$AppDatabase db, $CatalogoProdutosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CatalogoProdutosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CatalogoProdutosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CatalogoProdutosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> nomeComercial = const Value.absent(),
            Value<String?> ingredienteAtivo = const Value.absent(),
            Value<String> categoria = const Value.absent(),
            Value<String> unidadePadrao = const Value.absent(),
            Value<double?> doseMin = const Value.absent(),
            Value<double?> doseMax = const Value.absent(),
            Value<double?> precoUnitario = const Value.absent(),
            Value<String?> fabricante = const Value.absent(),
            Value<String?> observacoes = const Value.absent(),
            Value<String?> culturas = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<bool> isSeed = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CatalogoProdutosCompanion(
            uid: uid,
            userId: userId,
            nomeComercial: nomeComercial,
            ingredienteAtivo: ingredienteAtivo,
            categoria: categoria,
            unidadePadrao: unidadePadrao,
            doseMin: doseMin,
            doseMax: doseMax,
            precoUnitario: precoUnitario,
            fabricante: fabricante,
            observacoes: observacoes,
            culturas: culturas,
            ativo: ativo,
            isSeed: isSeed,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            Value<String?> userId = const Value.absent(),
            required String nomeComercial,
            Value<String?> ingredienteAtivo = const Value.absent(),
            required String categoria,
            required String unidadePadrao,
            Value<double?> doseMin = const Value.absent(),
            Value<double?> doseMax = const Value.absent(),
            Value<double?> precoUnitario = const Value.absent(),
            Value<String?> fabricante = const Value.absent(),
            Value<String?> observacoes = const Value.absent(),
            Value<String?> culturas = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<bool> isSeed = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CatalogoProdutosCompanion.insert(
            uid: uid,
            userId: userId,
            nomeComercial: nomeComercial,
            ingredienteAtivo: ingredienteAtivo,
            categoria: categoria,
            unidadePadrao: unidadePadrao,
            doseMin: doseMin,
            doseMax: doseMax,
            precoUnitario: precoUnitario,
            fabricante: fabricante,
            observacoes: observacoes,
            culturas: culturas,
            ativo: ativo,
            isSeed: isSeed,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CatalogoProdutosTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({produtosAplicacaoRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (produtosAplicacaoRefs) db.produtosAplicacao
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (produtosAplicacaoRefs)
                    await $_getPrefetchedData<CatalogoProduto,
                            $CatalogoProdutosTable, ProdutosAplicacaoData>(
                        currentTable: table,
                        referencedTable: $$CatalogoProdutosTableReferences
                            ._produtosAplicacaoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CatalogoProdutosTableReferences(db, table, p0)
                                .produtosAplicacaoRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.catalogoProdutoId == item.uid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CatalogoProdutosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CatalogoProdutosTable,
    CatalogoProduto,
    $$CatalogoProdutosTableFilterComposer,
    $$CatalogoProdutosTableOrderingComposer,
    $$CatalogoProdutosTableAnnotationComposer,
    $$CatalogoProdutosTableCreateCompanionBuilder,
    $$CatalogoProdutosTableUpdateCompanionBuilder,
    (CatalogoProduto, $$CatalogoProdutosTableReferences),
    CatalogoProduto,
    PrefetchHooks Function({bool produtosAplicacaoRefs})>;
typedef $$ReferenciasTecnicasTableCreateCompanionBuilder
    = ReferenciasTecnicasCompanion Function({
  required String uid,
  required String categoria,
  required String estadio,
  required String titulo,
  Value<String?> descricao,
  Value<String?> focoManejo,
  Value<String?> praticas,
  Value<String?> padrao,
  Value<String?> destaque,
  Value<String?> fonte,
  Value<String?> safraReferencia,
  Value<DateTime?> dataReferencia,
  Value<String?> resultado,
  Value<String?> local,
  Value<String?> tipoFonte,
  Value<int> rowid,
});
typedef $$ReferenciasTecnicasTableUpdateCompanionBuilder
    = ReferenciasTecnicasCompanion Function({
  Value<String> uid,
  Value<String> categoria,
  Value<String> estadio,
  Value<String> titulo,
  Value<String?> descricao,
  Value<String?> focoManejo,
  Value<String?> praticas,
  Value<String?> padrao,
  Value<String?> destaque,
  Value<String?> fonte,
  Value<String?> safraReferencia,
  Value<DateTime?> dataReferencia,
  Value<String?> resultado,
  Value<String?> local,
  Value<String?> tipoFonte,
  Value<int> rowid,
});

class $$ReferenciasTecnicasTableFilterComposer
    extends Composer<_$AppDatabase, $ReferenciasTecnicasTable> {
  $$ReferenciasTecnicasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estadio => $composableBuilder(
      column: $table.estadio, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get titulo => $composableBuilder(
      column: $table.titulo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get focoManejo => $composableBuilder(
      column: $table.focoManejo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get praticas => $composableBuilder(
      column: $table.praticas, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get padrao => $composableBuilder(
      column: $table.padrao, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get destaque => $composableBuilder(
      column: $table.destaque, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fonte => $composableBuilder(
      column: $table.fonte, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get safraReferencia => $composableBuilder(
      column: $table.safraReferencia,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataReferencia => $composableBuilder(
      column: $table.dataReferencia,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get resultado => $composableBuilder(
      column: $table.resultado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get local => $composableBuilder(
      column: $table.local, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipoFonte => $composableBuilder(
      column: $table.tipoFonte, builder: (column) => ColumnFilters(column));
}

class $$ReferenciasTecnicasTableOrderingComposer
    extends Composer<_$AppDatabase, $ReferenciasTecnicasTable> {
  $$ReferenciasTecnicasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estadio => $composableBuilder(
      column: $table.estadio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get titulo => $composableBuilder(
      column: $table.titulo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get focoManejo => $composableBuilder(
      column: $table.focoManejo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get praticas => $composableBuilder(
      column: $table.praticas, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get padrao => $composableBuilder(
      column: $table.padrao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get destaque => $composableBuilder(
      column: $table.destaque, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fonte => $composableBuilder(
      column: $table.fonte, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get safraReferencia => $composableBuilder(
      column: $table.safraReferencia,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataReferencia => $composableBuilder(
      column: $table.dataReferencia,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resultado => $composableBuilder(
      column: $table.resultado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get local => $composableBuilder(
      column: $table.local, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipoFonte => $composableBuilder(
      column: $table.tipoFonte, builder: (column) => ColumnOrderings(column));
}

class $$ReferenciasTecnicasTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReferenciasTecnicasTable> {
  $$ReferenciasTecnicasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);

  GeneratedColumn<String> get estadio =>
      $composableBuilder(column: $table.estadio, builder: (column) => column);

  GeneratedColumn<String> get titulo =>
      $composableBuilder(column: $table.titulo, builder: (column) => column);

  GeneratedColumn<String> get descricao =>
      $composableBuilder(column: $table.descricao, builder: (column) => column);

  GeneratedColumn<String> get focoManejo => $composableBuilder(
      column: $table.focoManejo, builder: (column) => column);

  GeneratedColumn<String> get praticas =>
      $composableBuilder(column: $table.praticas, builder: (column) => column);

  GeneratedColumn<String> get padrao =>
      $composableBuilder(column: $table.padrao, builder: (column) => column);

  GeneratedColumn<String> get destaque =>
      $composableBuilder(column: $table.destaque, builder: (column) => column);

  GeneratedColumn<String> get fonte =>
      $composableBuilder(column: $table.fonte, builder: (column) => column);

  GeneratedColumn<String> get safraReferencia => $composableBuilder(
      column: $table.safraReferencia, builder: (column) => column);

  GeneratedColumn<DateTime> get dataReferencia => $composableBuilder(
      column: $table.dataReferencia, builder: (column) => column);

  GeneratedColumn<String> get resultado =>
      $composableBuilder(column: $table.resultado, builder: (column) => column);

  GeneratedColumn<String> get local =>
      $composableBuilder(column: $table.local, builder: (column) => column);

  GeneratedColumn<String> get tipoFonte =>
      $composableBuilder(column: $table.tipoFonte, builder: (column) => column);
}

class $$ReferenciasTecnicasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReferenciasTecnicasTable,
    ReferenciasTecnica,
    $$ReferenciasTecnicasTableFilterComposer,
    $$ReferenciasTecnicasTableOrderingComposer,
    $$ReferenciasTecnicasTableAnnotationComposer,
    $$ReferenciasTecnicasTableCreateCompanionBuilder,
    $$ReferenciasTecnicasTableUpdateCompanionBuilder,
    (
      ReferenciasTecnica,
      BaseReferences<_$AppDatabase, $ReferenciasTecnicasTable,
          ReferenciasTecnica>
    ),
    ReferenciasTecnica,
    PrefetchHooks Function()> {
  $$ReferenciasTecnicasTableTableManager(
      _$AppDatabase db, $ReferenciasTecnicasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReferenciasTecnicasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReferenciasTecnicasTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReferenciasTecnicasTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String> categoria = const Value.absent(),
            Value<String> estadio = const Value.absent(),
            Value<String> titulo = const Value.absent(),
            Value<String?> descricao = const Value.absent(),
            Value<String?> focoManejo = const Value.absent(),
            Value<String?> praticas = const Value.absent(),
            Value<String?> padrao = const Value.absent(),
            Value<String?> destaque = const Value.absent(),
            Value<String?> fonte = const Value.absent(),
            Value<String?> safraReferencia = const Value.absent(),
            Value<DateTime?> dataReferencia = const Value.absent(),
            Value<String?> resultado = const Value.absent(),
            Value<String?> local = const Value.absent(),
            Value<String?> tipoFonte = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReferenciasTecnicasCompanion(
            uid: uid,
            categoria: categoria,
            estadio: estadio,
            titulo: titulo,
            descricao: descricao,
            focoManejo: focoManejo,
            praticas: praticas,
            padrao: padrao,
            destaque: destaque,
            fonte: fonte,
            safraReferencia: safraReferencia,
            dataReferencia: dataReferencia,
            resultado: resultado,
            local: local,
            tipoFonte: tipoFonte,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            required String categoria,
            required String estadio,
            required String titulo,
            Value<String?> descricao = const Value.absent(),
            Value<String?> focoManejo = const Value.absent(),
            Value<String?> praticas = const Value.absent(),
            Value<String?> padrao = const Value.absent(),
            Value<String?> destaque = const Value.absent(),
            Value<String?> fonte = const Value.absent(),
            Value<String?> safraReferencia = const Value.absent(),
            Value<DateTime?> dataReferencia = const Value.absent(),
            Value<String?> resultado = const Value.absent(),
            Value<String?> local = const Value.absent(),
            Value<String?> tipoFonte = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReferenciasTecnicasCompanion.insert(
            uid: uid,
            categoria: categoria,
            estadio: estadio,
            titulo: titulo,
            descricao: descricao,
            focoManejo: focoManejo,
            praticas: praticas,
            padrao: padrao,
            destaque: destaque,
            fonte: fonte,
            safraReferencia: safraReferencia,
            dataReferencia: dataReferencia,
            resultado: resultado,
            local: local,
            tipoFonte: tipoFonte,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ReferenciasTecnicasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReferenciasTecnicasTable,
    ReferenciasTecnica,
    $$ReferenciasTecnicasTableFilterComposer,
    $$ReferenciasTecnicasTableOrderingComposer,
    $$ReferenciasTecnicasTableAnnotationComposer,
    $$ReferenciasTecnicasTableCreateCompanionBuilder,
    $$ReferenciasTecnicasTableUpdateCompanionBuilder,
    (
      ReferenciasTecnica,
      BaseReferences<_$AppDatabase, $ReferenciasTecnicasTable,
          ReferenciasTecnica>
    ),
    ReferenciasTecnica,
    PrefetchHooks Function()>;
typedef $$PlanosTableCreateCompanionBuilder = PlanosCompanion Function({
  required String uid,
  Value<String?> userId,
  Value<String?> clienteId,
  Value<String?> fazendaId,
  required String nome,
  Value<String?> produtorNomeLivre,
  Value<String?> fazendaNomeLivre,
  Value<String?> cidadeUf,
  Value<String?> consultorNome,
  Value<bool> consultorExibirNome,
  Value<String?> logoLocalPath,
  Value<double?> precoGraoSc60,
  Value<DateTime?> dataVencimento,
  Value<String?> cultivarNome,
  Value<String?> cultivarObtentora,
  Value<String?> cultivarGrupoMaturacao,
  Value<double?> cultivarPopulacao,
  Value<String> cultivarPopulacaoUnidade,
  Value<String?> cultivarObservacoes,
  required String cultura,
  required String safra,
  required double areaHaTotal,
  required String status,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$PlanosTableUpdateCompanionBuilder = PlanosCompanion Function({
  Value<String> uid,
  Value<String?> userId,
  Value<String?> clienteId,
  Value<String?> fazendaId,
  Value<String> nome,
  Value<String?> produtorNomeLivre,
  Value<String?> fazendaNomeLivre,
  Value<String?> cidadeUf,
  Value<String?> consultorNome,
  Value<bool> consultorExibirNome,
  Value<String?> logoLocalPath,
  Value<double?> precoGraoSc60,
  Value<DateTime?> dataVencimento,
  Value<String?> cultivarNome,
  Value<String?> cultivarObtentora,
  Value<String?> cultivarGrupoMaturacao,
  Value<double?> cultivarPopulacao,
  Value<String> cultivarPopulacaoUnidade,
  Value<String?> cultivarObservacoes,
  Value<String> cultura,
  Value<String> safra,
  Value<double> areaHaTotal,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$PlanosTableReferences
    extends BaseReferences<_$AppDatabase, $PlanosTable, Plano> {
  $$PlanosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientesTable _clienteIdTable(_$AppDatabase db) => db.clientes
      .createAlias($_aliasNameGenerator(db.planos.clienteId, db.clientes.uid));

  $$ClientesTableProcessedTableManager? get clienteId {
    final $_column = $_itemColumn<String>('cliente_id');
    if ($_column == null) return null;
    final manager = $$ClientesTableTableManager($_db, $_db.clientes)
        .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clienteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $FazendasTable _fazendaIdTable(_$AppDatabase db) => db.fazendas
      .createAlias($_aliasNameGenerator(db.planos.fazendaId, db.fazendas.uid));

  $$FazendasTableProcessedTableManager? get fazendaId {
    final $_column = $_itemColumn<String>('fazenda_id');
    if ($_column == null) return null;
    final manager = $$FazendasTableTableManager($_db, $_db.fazendas)
        .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fazendaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$EstadiosTable, List<Estadio>> _estadiosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.estadios,
          aliasName: $_aliasNameGenerator(db.planos.uid, db.estadios.planoId));

  $$EstadiosTableProcessedTableManager get estadiosRefs {
    final manager = $$EstadiosTableTableManager($_db, $_db.estadios)
        .filter((f) => f.planoId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache = $_typedResult.readTableOrNull(_estadiosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SementesTalhaoTable, List<SementesTalhaoData>>
      _sementesTalhaoRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.sementesTalhao,
              aliasName: $_aliasNameGenerator(
                  db.planos.uid, db.sementesTalhao.planoId));

  $$SementesTalhaoTableProcessedTableManager get sementesTalhaoRefs {
    final manager = $$SementesTalhaoTableTableManager($_db, $_db.sementesTalhao)
        .filter((f) => f.planoId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache = $_typedResult.readTableOrNull(_sementesTalhaoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TalhoesSafraTable, List<TalhoesSafraData>>
      _talhoesSafraRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.talhoesSafra,
              aliasName:
                  $_aliasNameGenerator(db.planos.uid, db.talhoesSafra.planoId));

  $$TalhoesSafraTableProcessedTableManager get talhoesSafraRefs {
    final manager = $$TalhoesSafraTableTableManager($_db, $_db.talhoesSafra)
        .filter((f) => f.planoId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache = $_typedResult.readTableOrNull(_talhoesSafraRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ProgramasOperacionaisTable,
      List<ProgramasOperacionai>> _programasOperacionaisRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.programasOperacionais,
          aliasName: $_aliasNameGenerator(
              db.planos.uid, db.programasOperacionais.planoId));

  $$ProgramasOperacionaisTableProcessedTableManager
      get programasOperacionaisRefs {
    final manager = $$ProgramasOperacionaisTableTableManager(
            $_db, $_db.programasOperacionais)
        .filter((f) => f.planoId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache =
        $_typedResult.readTableOrNull(_programasOperacionaisRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PlanosTableFilterComposer
    extends Composer<_$AppDatabase, $PlanosTable> {
  $$PlanosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get produtorNomeLivre => $composableBuilder(
      column: $table.produtorNomeLivre,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fazendaNomeLivre => $composableBuilder(
      column: $table.fazendaNomeLivre,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cidadeUf => $composableBuilder(
      column: $table.cidadeUf, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get consultorNome => $composableBuilder(
      column: $table.consultorNome, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get consultorExibirNome => $composableBuilder(
      column: $table.consultorExibirNome,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get logoLocalPath => $composableBuilder(
      column: $table.logoLocalPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precoGraoSc60 => $composableBuilder(
      column: $table.precoGraoSc60, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataVencimento => $composableBuilder(
      column: $table.dataVencimento,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cultivarNome => $composableBuilder(
      column: $table.cultivarNome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cultivarObtentora => $composableBuilder(
      column: $table.cultivarObtentora,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cultivarGrupoMaturacao => $composableBuilder(
      column: $table.cultivarGrupoMaturacao,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get cultivarPopulacao => $composableBuilder(
      column: $table.cultivarPopulacao,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cultivarPopulacaoUnidade => $composableBuilder(
      column: $table.cultivarPopulacaoUnidade,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cultivarObservacoes => $composableBuilder(
      column: $table.cultivarObservacoes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cultura => $composableBuilder(
      column: $table.cultura, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get safra => $composableBuilder(
      column: $table.safra, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get areaHaTotal => $composableBuilder(
      column: $table.areaHaTotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$ClientesTableFilterComposer get clienteId {
    final $$ClientesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clienteId,
        referencedTable: $db.clientes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientesTableFilterComposer(
              $db: $db,
              $table: $db.clientes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FazendasTableFilterComposer get fazendaId {
    final $$FazendasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fazendaId,
        referencedTable: $db.fazendas,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FazendasTableFilterComposer(
              $db: $db,
              $table: $db.fazendas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> estadiosRefs(
      Expression<bool> Function($$EstadiosTableFilterComposer f) f) {
    final $$EstadiosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.estadios,
        getReferencedColumn: (t) => t.planoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EstadiosTableFilterComposer(
              $db: $db,
              $table: $db.estadios,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> sementesTalhaoRefs(
      Expression<bool> Function($$SementesTalhaoTableFilterComposer f) f) {
    final $$SementesTalhaoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.sementesTalhao,
        getReferencedColumn: (t) => t.planoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SementesTalhaoTableFilterComposer(
              $db: $db,
              $table: $db.sementesTalhao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> talhoesSafraRefs(
      Expression<bool> Function($$TalhoesSafraTableFilterComposer f) f) {
    final $$TalhoesSafraTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.talhoesSafra,
        getReferencedColumn: (t) => t.planoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesSafraTableFilterComposer(
              $db: $db,
              $table: $db.talhoesSafra,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> programasOperacionaisRefs(
      Expression<bool> Function($$ProgramasOperacionaisTableFilterComposer f)
          f) {
    final $$ProgramasOperacionaisTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.uid,
            referencedTable: $db.programasOperacionais,
            getReferencedColumn: (t) => t.planoId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ProgramasOperacionaisTableFilterComposer(
                  $db: $db,
                  $table: $db.programasOperacionais,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PlanosTableOrderingComposer
    extends Composer<_$AppDatabase, $PlanosTable> {
  $$PlanosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get produtorNomeLivre => $composableBuilder(
      column: $table.produtorNomeLivre,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fazendaNomeLivre => $composableBuilder(
      column: $table.fazendaNomeLivre,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cidadeUf => $composableBuilder(
      column: $table.cidadeUf, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get consultorNome => $composableBuilder(
      column: $table.consultorNome,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get consultorExibirNome => $composableBuilder(
      column: $table.consultorExibirNome,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get logoLocalPath => $composableBuilder(
      column: $table.logoLocalPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precoGraoSc60 => $composableBuilder(
      column: $table.precoGraoSc60,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataVencimento => $composableBuilder(
      column: $table.dataVencimento,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cultivarNome => $composableBuilder(
      column: $table.cultivarNome,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cultivarObtentora => $composableBuilder(
      column: $table.cultivarObtentora,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cultivarGrupoMaturacao => $composableBuilder(
      column: $table.cultivarGrupoMaturacao,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get cultivarPopulacao => $composableBuilder(
      column: $table.cultivarPopulacao,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cultivarPopulacaoUnidade => $composableBuilder(
      column: $table.cultivarPopulacaoUnidade,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cultivarObservacoes => $composableBuilder(
      column: $table.cultivarObservacoes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cultura => $composableBuilder(
      column: $table.cultura, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get safra => $composableBuilder(
      column: $table.safra, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get areaHaTotal => $composableBuilder(
      column: $table.areaHaTotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$ClientesTableOrderingComposer get clienteId {
    final $$ClientesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clienteId,
        referencedTable: $db.clientes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientesTableOrderingComposer(
              $db: $db,
              $table: $db.clientes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FazendasTableOrderingComposer get fazendaId {
    final $$FazendasTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fazendaId,
        referencedTable: $db.fazendas,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FazendasTableOrderingComposer(
              $db: $db,
              $table: $db.fazendas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlanosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanosTable> {
  $$PlanosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get produtorNomeLivre => $composableBuilder(
      column: $table.produtorNomeLivre, builder: (column) => column);

  GeneratedColumn<String> get fazendaNomeLivre => $composableBuilder(
      column: $table.fazendaNomeLivre, builder: (column) => column);

  GeneratedColumn<String> get cidadeUf =>
      $composableBuilder(column: $table.cidadeUf, builder: (column) => column);

  GeneratedColumn<String> get consultorNome => $composableBuilder(
      column: $table.consultorNome, builder: (column) => column);

  GeneratedColumn<bool> get consultorExibirNome => $composableBuilder(
      column: $table.consultorExibirNome, builder: (column) => column);

  GeneratedColumn<String> get logoLocalPath => $composableBuilder(
      column: $table.logoLocalPath, builder: (column) => column);

  GeneratedColumn<double> get precoGraoSc60 => $composableBuilder(
      column: $table.precoGraoSc60, builder: (column) => column);

  GeneratedColumn<DateTime> get dataVencimento => $composableBuilder(
      column: $table.dataVencimento, builder: (column) => column);

  GeneratedColumn<String> get cultivarNome => $composableBuilder(
      column: $table.cultivarNome, builder: (column) => column);

  GeneratedColumn<String> get cultivarObtentora => $composableBuilder(
      column: $table.cultivarObtentora, builder: (column) => column);

  GeneratedColumn<String> get cultivarGrupoMaturacao => $composableBuilder(
      column: $table.cultivarGrupoMaturacao, builder: (column) => column);

  GeneratedColumn<double> get cultivarPopulacao => $composableBuilder(
      column: $table.cultivarPopulacao, builder: (column) => column);

  GeneratedColumn<String> get cultivarPopulacaoUnidade => $composableBuilder(
      column: $table.cultivarPopulacaoUnidade, builder: (column) => column);

  GeneratedColumn<String> get cultivarObservacoes => $composableBuilder(
      column: $table.cultivarObservacoes, builder: (column) => column);

  GeneratedColumn<String> get cultura =>
      $composableBuilder(column: $table.cultura, builder: (column) => column);

  GeneratedColumn<String> get safra =>
      $composableBuilder(column: $table.safra, builder: (column) => column);

  GeneratedColumn<double> get areaHaTotal => $composableBuilder(
      column: $table.areaHaTotal, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$ClientesTableAnnotationComposer get clienteId {
    final $$ClientesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clienteId,
        referencedTable: $db.clientes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientesTableAnnotationComposer(
              $db: $db,
              $table: $db.clientes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FazendasTableAnnotationComposer get fazendaId {
    final $$FazendasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fazendaId,
        referencedTable: $db.fazendas,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FazendasTableAnnotationComposer(
              $db: $db,
              $table: $db.fazendas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> estadiosRefs<T extends Object>(
      Expression<T> Function($$EstadiosTableAnnotationComposer a) f) {
    final $$EstadiosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.estadios,
        getReferencedColumn: (t) => t.planoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EstadiosTableAnnotationComposer(
              $db: $db,
              $table: $db.estadios,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> sementesTalhaoRefs<T extends Object>(
      Expression<T> Function($$SementesTalhaoTableAnnotationComposer a) f) {
    final $$SementesTalhaoTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.sementesTalhao,
        getReferencedColumn: (t) => t.planoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SementesTalhaoTableAnnotationComposer(
              $db: $db,
              $table: $db.sementesTalhao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> talhoesSafraRefs<T extends Object>(
      Expression<T> Function($$TalhoesSafraTableAnnotationComposer a) f) {
    final $$TalhoesSafraTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.talhoesSafra,
        getReferencedColumn: (t) => t.planoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesSafraTableAnnotationComposer(
              $db: $db,
              $table: $db.talhoesSafra,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> programasOperacionaisRefs<T extends Object>(
      Expression<T> Function($$ProgramasOperacionaisTableAnnotationComposer a)
          f) {
    final $$ProgramasOperacionaisTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.uid,
            referencedTable: $db.programasOperacionais,
            getReferencedColumn: (t) => t.planoId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ProgramasOperacionaisTableAnnotationComposer(
                  $db: $db,
                  $table: $db.programasOperacionais,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PlanosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlanosTable,
    Plano,
    $$PlanosTableFilterComposer,
    $$PlanosTableOrderingComposer,
    $$PlanosTableAnnotationComposer,
    $$PlanosTableCreateCompanionBuilder,
    $$PlanosTableUpdateCompanionBuilder,
    (Plano, $$PlanosTableReferences),
    Plano,
    PrefetchHooks Function(
        {bool clienteId,
        bool fazendaId,
        bool estadiosRefs,
        bool sementesTalhaoRefs,
        bool talhoesSafraRefs,
        bool programasOperacionaisRefs})> {
  $$PlanosTableTableManager(_$AppDatabase db, $PlanosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlanosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlanosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlanosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String?> clienteId = const Value.absent(),
            Value<String?> fazendaId = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String?> produtorNomeLivre = const Value.absent(),
            Value<String?> fazendaNomeLivre = const Value.absent(),
            Value<String?> cidadeUf = const Value.absent(),
            Value<String?> consultorNome = const Value.absent(),
            Value<bool> consultorExibirNome = const Value.absent(),
            Value<String?> logoLocalPath = const Value.absent(),
            Value<double?> precoGraoSc60 = const Value.absent(),
            Value<DateTime?> dataVencimento = const Value.absent(),
            Value<String?> cultivarNome = const Value.absent(),
            Value<String?> cultivarObtentora = const Value.absent(),
            Value<String?> cultivarGrupoMaturacao = const Value.absent(),
            Value<double?> cultivarPopulacao = const Value.absent(),
            Value<String> cultivarPopulacaoUnidade = const Value.absent(),
            Value<String?> cultivarObservacoes = const Value.absent(),
            Value<String> cultura = const Value.absent(),
            Value<String> safra = const Value.absent(),
            Value<double> areaHaTotal = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlanosCompanion(
            uid: uid,
            userId: userId,
            clienteId: clienteId,
            fazendaId: fazendaId,
            nome: nome,
            produtorNomeLivre: produtorNomeLivre,
            fazendaNomeLivre: fazendaNomeLivre,
            cidadeUf: cidadeUf,
            consultorNome: consultorNome,
            consultorExibirNome: consultorExibirNome,
            logoLocalPath: logoLocalPath,
            precoGraoSc60: precoGraoSc60,
            dataVencimento: dataVencimento,
            cultivarNome: cultivarNome,
            cultivarObtentora: cultivarObtentora,
            cultivarGrupoMaturacao: cultivarGrupoMaturacao,
            cultivarPopulacao: cultivarPopulacao,
            cultivarPopulacaoUnidade: cultivarPopulacaoUnidade,
            cultivarObservacoes: cultivarObservacoes,
            cultura: cultura,
            safra: safra,
            areaHaTotal: areaHaTotal,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            Value<String?> userId = const Value.absent(),
            Value<String?> clienteId = const Value.absent(),
            Value<String?> fazendaId = const Value.absent(),
            required String nome,
            Value<String?> produtorNomeLivre = const Value.absent(),
            Value<String?> fazendaNomeLivre = const Value.absent(),
            Value<String?> cidadeUf = const Value.absent(),
            Value<String?> consultorNome = const Value.absent(),
            Value<bool> consultorExibirNome = const Value.absent(),
            Value<String?> logoLocalPath = const Value.absent(),
            Value<double?> precoGraoSc60 = const Value.absent(),
            Value<DateTime?> dataVencimento = const Value.absent(),
            Value<String?> cultivarNome = const Value.absent(),
            Value<String?> cultivarObtentora = const Value.absent(),
            Value<String?> cultivarGrupoMaturacao = const Value.absent(),
            Value<double?> cultivarPopulacao = const Value.absent(),
            Value<String> cultivarPopulacaoUnidade = const Value.absent(),
            Value<String?> cultivarObservacoes = const Value.absent(),
            required String cultura,
            required String safra,
            required double areaHaTotal,
            required String status,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlanosCompanion.insert(
            uid: uid,
            userId: userId,
            clienteId: clienteId,
            fazendaId: fazendaId,
            nome: nome,
            produtorNomeLivre: produtorNomeLivre,
            fazendaNomeLivre: fazendaNomeLivre,
            cidadeUf: cidadeUf,
            consultorNome: consultorNome,
            consultorExibirNome: consultorExibirNome,
            logoLocalPath: logoLocalPath,
            precoGraoSc60: precoGraoSc60,
            dataVencimento: dataVencimento,
            cultivarNome: cultivarNome,
            cultivarObtentora: cultivarObtentora,
            cultivarGrupoMaturacao: cultivarGrupoMaturacao,
            cultivarPopulacao: cultivarPopulacao,
            cultivarPopulacaoUnidade: cultivarPopulacaoUnidade,
            cultivarObservacoes: cultivarObservacoes,
            cultura: cultura,
            safra: safra,
            areaHaTotal: areaHaTotal,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PlanosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {clienteId = false,
              fazendaId = false,
              estadiosRefs = false,
              sementesTalhaoRefs = false,
              talhoesSafraRefs = false,
              programasOperacionaisRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (estadiosRefs) db.estadios,
                if (sementesTalhaoRefs) db.sementesTalhao,
                if (talhoesSafraRefs) db.talhoesSafra,
                if (programasOperacionaisRefs) db.programasOperacionais
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (clienteId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.clienteId,
                    referencedTable:
                        $$PlanosTableReferences._clienteIdTable(db),
                    referencedColumn:
                        $$PlanosTableReferences._clienteIdTable(db).uid,
                  ) as T;
                }
                if (fazendaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.fazendaId,
                    referencedTable:
                        $$PlanosTableReferences._fazendaIdTable(db),
                    referencedColumn:
                        $$PlanosTableReferences._fazendaIdTable(db).uid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (estadiosRefs)
                    await $_getPrefetchedData<Plano, $PlanosTable, Estadio>(
                        currentTable: table,
                        referencedTable:
                            $$PlanosTableReferences._estadiosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlanosTableReferences(db, table, p0).estadiosRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.planoId == item.uid),
                        typedResults: items),
                  if (sementesTalhaoRefs)
                    await $_getPrefetchedData<Plano, $PlanosTable,
                            SementesTalhaoData>(
                        currentTable: table,
                        referencedTable: $$PlanosTableReferences
                            ._sementesTalhaoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlanosTableReferences(db, table, p0)
                                .sementesTalhaoRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.planoId == item.uid),
                        typedResults: items),
                  if (talhoesSafraRefs)
                    await $_getPrefetchedData<Plano, $PlanosTable,
                            TalhoesSafraData>(
                        currentTable: table,
                        referencedTable:
                            $$PlanosTableReferences._talhoesSafraRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlanosTableReferences(db, table, p0)
                                .talhoesSafraRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.planoId == item.uid),
                        typedResults: items),
                  if (programasOperacionaisRefs)
                    await $_getPrefetchedData<Plano, $PlanosTable,
                            ProgramasOperacionai>(
                        currentTable: table,
                        referencedTable: $$PlanosTableReferences
                            ._programasOperacionaisRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlanosTableReferences(db, table, p0)
                                .programasOperacionaisRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.planoId == item.uid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PlanosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlanosTable,
    Plano,
    $$PlanosTableFilterComposer,
    $$PlanosTableOrderingComposer,
    $$PlanosTableAnnotationComposer,
    $$PlanosTableCreateCompanionBuilder,
    $$PlanosTableUpdateCompanionBuilder,
    (Plano, $$PlanosTableReferences),
    Plano,
    PrefetchHooks Function(
        {bool clienteId,
        bool fazendaId,
        bool estadiosRefs,
        bool sementesTalhaoRefs,
        bool talhoesSafraRefs,
        bool programasOperacionaisRefs})>;
typedef $$EstadiosTableCreateCompanionBuilder = EstadiosCompanion Function({
  required String uid,
  Value<String?> userId,
  required String planoId,
  required String codigo,
  Value<String> tipo,
  required String label,
  Value<int> ordem,
  Value<DateTime?> dataAplicacao,
  Value<String?> imageLocalPath,
  Value<String?> observacao,
  Value<String?> tipoOperacional,
  Value<String?> operacionalConfig,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$EstadiosTableUpdateCompanionBuilder = EstadiosCompanion Function({
  Value<String> uid,
  Value<String?> userId,
  Value<String> planoId,
  Value<String> codigo,
  Value<String> tipo,
  Value<String> label,
  Value<int> ordem,
  Value<DateTime?> dataAplicacao,
  Value<String?> imageLocalPath,
  Value<String?> observacao,
  Value<String?> tipoOperacional,
  Value<String?> operacionalConfig,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$EstadiosTableReferences
    extends BaseReferences<_$AppDatabase, $EstadiosTable, Estadio> {
  $$EstadiosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlanosTable _planoIdTable(_$AppDatabase db) => db.planos
      .createAlias($_aliasNameGenerator(db.estadios.planoId, db.planos.uid));

  $$PlanosTableProcessedTableManager get planoId {
    final $_column = $_itemColumn<String>('plano_id')!;

    final manager = $$PlanosTableTableManager($_db, $_db.planos)
        .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ProdutosAplicacaoTable,
      List<ProdutosAplicacaoData>> _produtosAplicacaoRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.produtosAplicacao,
          aliasName: $_aliasNameGenerator(
              db.estadios.uid, db.produtosAplicacao.estadioId));

  $$ProdutosAplicacaoTableProcessedTableManager get produtosAplicacaoRefs {
    final manager = $$ProdutosAplicacaoTableTableManager(
            $_db, $_db.produtosAplicacao)
        .filter((f) => f.estadioId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache =
        $_typedResult.readTableOrNull(_produtosAplicacaoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SementesTalhaoTable, List<SementesTalhaoData>>
      _sementesTalhaoRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.sementesTalhao,
              aliasName: $_aliasNameGenerator(
                  db.estadios.uid, db.sementesTalhao.estadioId));

  $$SementesTalhaoTableProcessedTableManager get sementesTalhaoRefs {
    final manager = $$SementesTalhaoTableTableManager($_db, $_db.sementesTalhao)
        .filter((f) => f.estadioId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache = $_typedResult.readTableOrNull(_sementesTalhaoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ProgramasOperacionaisTable,
      List<ProgramasOperacionai>> _programasOperacionaisRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.programasOperacionais,
          aliasName: $_aliasNameGenerator(
              db.estadios.uid, db.programasOperacionais.estadioId));

  $$ProgramasOperacionaisTableProcessedTableManager
      get programasOperacionaisRefs {
    final manager = $$ProgramasOperacionaisTableTableManager(
            $_db, $_db.programasOperacionais)
        .filter((f) => f.estadioId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache =
        $_typedResult.readTableOrNull(_programasOperacionaisRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$EstadiosTableFilterComposer
    extends Composer<_$AppDatabase, $EstadiosTable> {
  $$EstadiosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordem => $composableBuilder(
      column: $table.ordem, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataAplicacao => $composableBuilder(
      column: $table.dataAplicacao, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageLocalPath => $composableBuilder(
      column: $table.imageLocalPath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipoOperacional => $composableBuilder(
      column: $table.tipoOperacional,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operacionalConfig => $composableBuilder(
      column: $table.operacionalConfig,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$PlanosTableFilterComposer get planoId {
    final $$PlanosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planoId,
        referencedTable: $db.planos,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanosTableFilterComposer(
              $db: $db,
              $table: $db.planos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> produtosAplicacaoRefs(
      Expression<bool> Function($$ProdutosAplicacaoTableFilterComposer f) f) {
    final $$ProdutosAplicacaoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.produtosAplicacao,
        getReferencedColumn: (t) => t.estadioId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProdutosAplicacaoTableFilterComposer(
              $db: $db,
              $table: $db.produtosAplicacao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> sementesTalhaoRefs(
      Expression<bool> Function($$SementesTalhaoTableFilterComposer f) f) {
    final $$SementesTalhaoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.sementesTalhao,
        getReferencedColumn: (t) => t.estadioId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SementesTalhaoTableFilterComposer(
              $db: $db,
              $table: $db.sementesTalhao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> programasOperacionaisRefs(
      Expression<bool> Function($$ProgramasOperacionaisTableFilterComposer f)
          f) {
    final $$ProgramasOperacionaisTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.uid,
            referencedTable: $db.programasOperacionais,
            getReferencedColumn: (t) => t.estadioId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ProgramasOperacionaisTableFilterComposer(
                  $db: $db,
                  $table: $db.programasOperacionais,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$EstadiosTableOrderingComposer
    extends Composer<_$AppDatabase, $EstadiosTable> {
  $$EstadiosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordem => $composableBuilder(
      column: $table.ordem, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataAplicacao => $composableBuilder(
      column: $table.dataAplicacao,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageLocalPath => $composableBuilder(
      column: $table.imageLocalPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipoOperacional => $composableBuilder(
      column: $table.tipoOperacional,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operacionalConfig => $composableBuilder(
      column: $table.operacionalConfig,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$PlanosTableOrderingComposer get planoId {
    final $$PlanosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planoId,
        referencedTable: $db.planos,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanosTableOrderingComposer(
              $db: $db,
              $table: $db.planos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EstadiosTableAnnotationComposer
    extends Composer<_$AppDatabase, $EstadiosTable> {
  $$EstadiosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<int> get ordem =>
      $composableBuilder(column: $table.ordem, builder: (column) => column);

  GeneratedColumn<DateTime> get dataAplicacao => $composableBuilder(
      column: $table.dataAplicacao, builder: (column) => column);

  GeneratedColumn<String> get imageLocalPath => $composableBuilder(
      column: $table.imageLocalPath, builder: (column) => column);

  GeneratedColumn<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => column);

  GeneratedColumn<String> get tipoOperacional => $composableBuilder(
      column: $table.tipoOperacional, builder: (column) => column);

  GeneratedColumn<String> get operacionalConfig => $composableBuilder(
      column: $table.operacionalConfig, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$PlanosTableAnnotationComposer get planoId {
    final $$PlanosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planoId,
        referencedTable: $db.planos,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanosTableAnnotationComposer(
              $db: $db,
              $table: $db.planos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> produtosAplicacaoRefs<T extends Object>(
      Expression<T> Function($$ProdutosAplicacaoTableAnnotationComposer a) f) {
    final $$ProdutosAplicacaoTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.uid,
            referencedTable: $db.produtosAplicacao,
            getReferencedColumn: (t) => t.estadioId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ProdutosAplicacaoTableAnnotationComposer(
                  $db: $db,
                  $table: $db.produtosAplicacao,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> sementesTalhaoRefs<T extends Object>(
      Expression<T> Function($$SementesTalhaoTableAnnotationComposer a) f) {
    final $$SementesTalhaoTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.sementesTalhao,
        getReferencedColumn: (t) => t.estadioId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SementesTalhaoTableAnnotationComposer(
              $db: $db,
              $table: $db.sementesTalhao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> programasOperacionaisRefs<T extends Object>(
      Expression<T> Function($$ProgramasOperacionaisTableAnnotationComposer a)
          f) {
    final $$ProgramasOperacionaisTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.uid,
            referencedTable: $db.programasOperacionais,
            getReferencedColumn: (t) => t.estadioId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ProgramasOperacionaisTableAnnotationComposer(
                  $db: $db,
                  $table: $db.programasOperacionais,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$EstadiosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EstadiosTable,
    Estadio,
    $$EstadiosTableFilterComposer,
    $$EstadiosTableOrderingComposer,
    $$EstadiosTableAnnotationComposer,
    $$EstadiosTableCreateCompanionBuilder,
    $$EstadiosTableUpdateCompanionBuilder,
    (Estadio, $$EstadiosTableReferences),
    Estadio,
    PrefetchHooks Function(
        {bool planoId,
        bool produtosAplicacaoRefs,
        bool sementesTalhaoRefs,
        bool programasOperacionaisRefs})> {
  $$EstadiosTableTableManager(_$AppDatabase db, $EstadiosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EstadiosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EstadiosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EstadiosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> planoId = const Value.absent(),
            Value<String> codigo = const Value.absent(),
            Value<String> tipo = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<int> ordem = const Value.absent(),
            Value<DateTime?> dataAplicacao = const Value.absent(),
            Value<String?> imageLocalPath = const Value.absent(),
            Value<String?> observacao = const Value.absent(),
            Value<String?> tipoOperacional = const Value.absent(),
            Value<String?> operacionalConfig = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EstadiosCompanion(
            uid: uid,
            userId: userId,
            planoId: planoId,
            codigo: codigo,
            tipo: tipo,
            label: label,
            ordem: ordem,
            dataAplicacao: dataAplicacao,
            imageLocalPath: imageLocalPath,
            observacao: observacao,
            tipoOperacional: tipoOperacional,
            operacionalConfig: operacionalConfig,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            Value<String?> userId = const Value.absent(),
            required String planoId,
            required String codigo,
            Value<String> tipo = const Value.absent(),
            required String label,
            Value<int> ordem = const Value.absent(),
            Value<DateTime?> dataAplicacao = const Value.absent(),
            Value<String?> imageLocalPath = const Value.absent(),
            Value<String?> observacao = const Value.absent(),
            Value<String?> tipoOperacional = const Value.absent(),
            Value<String?> operacionalConfig = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EstadiosCompanion.insert(
            uid: uid,
            userId: userId,
            planoId: planoId,
            codigo: codigo,
            tipo: tipo,
            label: label,
            ordem: ordem,
            dataAplicacao: dataAplicacao,
            imageLocalPath: imageLocalPath,
            observacao: observacao,
            tipoOperacional: tipoOperacional,
            operacionalConfig: operacionalConfig,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$EstadiosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {planoId = false,
              produtosAplicacaoRefs = false,
              sementesTalhaoRefs = false,
              programasOperacionaisRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (produtosAplicacaoRefs) db.produtosAplicacao,
                if (sementesTalhaoRefs) db.sementesTalhao,
                if (programasOperacionaisRefs) db.programasOperacionais
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (planoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.planoId,
                    referencedTable:
                        $$EstadiosTableReferences._planoIdTable(db),
                    referencedColumn:
                        $$EstadiosTableReferences._planoIdTable(db).uid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (produtosAplicacaoRefs)
                    await $_getPrefetchedData<Estadio, $EstadiosTable,
                            ProdutosAplicacaoData>(
                        currentTable: table,
                        referencedTable: $$EstadiosTableReferences
                            ._produtosAplicacaoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EstadiosTableReferences(db, table, p0)
                                .produtosAplicacaoRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.estadioId == item.uid),
                        typedResults: items),
                  if (sementesTalhaoRefs)
                    await $_getPrefetchedData<Estadio, $EstadiosTable,
                            SementesTalhaoData>(
                        currentTable: table,
                        referencedTable: $$EstadiosTableReferences
                            ._sementesTalhaoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EstadiosTableReferences(db, table, p0)
                                .sementesTalhaoRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.estadioId == item.uid),
                        typedResults: items),
                  if (programasOperacionaisRefs)
                    await $_getPrefetchedData<Estadio, $EstadiosTable,
                            ProgramasOperacionai>(
                        currentTable: table,
                        referencedTable: $$EstadiosTableReferences
                            ._programasOperacionaisRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EstadiosTableReferences(db, table, p0)
                                .programasOperacionaisRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.estadioId == item.uid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$EstadiosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EstadiosTable,
    Estadio,
    $$EstadiosTableFilterComposer,
    $$EstadiosTableOrderingComposer,
    $$EstadiosTableAnnotationComposer,
    $$EstadiosTableCreateCompanionBuilder,
    $$EstadiosTableUpdateCompanionBuilder,
    (Estadio, $$EstadiosTableReferences),
    Estadio,
    PrefetchHooks Function(
        {bool planoId,
        bool produtosAplicacaoRefs,
        bool sementesTalhaoRefs,
        bool programasOperacionaisRefs})>;
typedef $$ProdutosAplicacaoTableCreateCompanionBuilder
    = ProdutosAplicacaoCompanion Function({
  required String uid,
  Value<String?> userId,
  required String estadioId,
  Value<String?> catalogoProdutoId,
  required String produtoNome,
  required String produtoCategoria,
  required double dose,
  required String doseUnidade,
  required double areaHa,
  Value<String?> talhaoRef,
  Value<double?> totalOverride,
  Value<String?> overrideMotivo,
  Value<double?> precoUnitario,
  Value<String?> observacao,
  Value<DateTime?> dataPrevista,
  Value<int> ordem,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$ProdutosAplicacaoTableUpdateCompanionBuilder
    = ProdutosAplicacaoCompanion Function({
  Value<String> uid,
  Value<String?> userId,
  Value<String> estadioId,
  Value<String?> catalogoProdutoId,
  Value<String> produtoNome,
  Value<String> produtoCategoria,
  Value<double> dose,
  Value<String> doseUnidade,
  Value<double> areaHa,
  Value<String?> talhaoRef,
  Value<double?> totalOverride,
  Value<String?> overrideMotivo,
  Value<double?> precoUnitario,
  Value<String?> observacao,
  Value<DateTime?> dataPrevista,
  Value<int> ordem,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$ProdutosAplicacaoTableReferences extends BaseReferences<
    _$AppDatabase, $ProdutosAplicacaoTable, ProdutosAplicacaoData> {
  $$ProdutosAplicacaoTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $EstadiosTable _estadioIdTable(_$AppDatabase db) =>
      db.estadios.createAlias($_aliasNameGenerator(
          db.produtosAplicacao.estadioId, db.estadios.uid));

  $$EstadiosTableProcessedTableManager get estadioId {
    final $_column = $_itemColumn<String>('estadio_id')!;

    final manager = $$EstadiosTableTableManager($_db, $_db.estadios)
        .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_estadioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CatalogoProdutosTable _catalogoProdutoIdTable(_$AppDatabase db) =>
      db.catalogoProdutos.createAlias($_aliasNameGenerator(
          db.produtosAplicacao.catalogoProdutoId, db.catalogoProdutos.uid));

  $$CatalogoProdutosTableProcessedTableManager? get catalogoProdutoId {
    final $_column = $_itemColumn<String>('catalogo_produto_id');
    if ($_column == null) return null;
    final manager =
        $$CatalogoProdutosTableTableManager($_db, $_db.catalogoProdutos)
            .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_catalogoProdutoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$EscoposAlocacaoTable, List<EscoposAlocacaoData>>
      _escoposAlocacaoRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.escoposAlocacao,
              aliasName: $_aliasNameGenerator(db.produtosAplicacao.uid,
                  db.escoposAlocacao.produtoAplicacaoId));

  $$EscoposAlocacaoTableProcessedTableManager get escoposAlocacaoRefs {
    final manager = $$EscoposAlocacaoTableTableManager(
            $_db, $_db.escoposAlocacao)
        .filter((f) =>
            f.produtoAplicacaoId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache =
        $_typedResult.readTableOrNull(_escoposAlocacaoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AlocacoesTalhaoTable, List<AlocacoesTalhaoData>>
      _alocacoesTalhaoRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.alocacoesTalhao,
              aliasName: $_aliasNameGenerator(db.produtosAplicacao.uid,
                  db.alocacoesTalhao.produtoAplicacaoId));

  $$AlocacoesTalhaoTableProcessedTableManager get alocacoesTalhaoRefs {
    final manager = $$AlocacoesTalhaoTableTableManager(
            $_db, $_db.alocacoesTalhao)
        .filter((f) =>
            f.produtoAplicacaoId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache =
        $_typedResult.readTableOrNull(_alocacoesTalhaoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProdutosAplicacaoTableFilterComposer
    extends Composer<_$AppDatabase, $ProdutosAplicacaoTable> {
  $$ProdutosAplicacaoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get produtoNome => $composableBuilder(
      column: $table.produtoNome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get produtoCategoria => $composableBuilder(
      column: $table.produtoCategoria,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get dose => $composableBuilder(
      column: $table.dose, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get doseUnidade => $composableBuilder(
      column: $table.doseUnidade, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get areaHa => $composableBuilder(
      column: $table.areaHa, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get talhaoRef => $composableBuilder(
      column: $table.talhaoRef, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalOverride => $composableBuilder(
      column: $table.totalOverride, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get overrideMotivo => $composableBuilder(
      column: $table.overrideMotivo,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precoUnitario => $composableBuilder(
      column: $table.precoUnitario, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataPrevista => $composableBuilder(
      column: $table.dataPrevista, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordem => $composableBuilder(
      column: $table.ordem, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$EstadiosTableFilterComposer get estadioId {
    final $$EstadiosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.estadioId,
        referencedTable: $db.estadios,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EstadiosTableFilterComposer(
              $db: $db,
              $table: $db.estadios,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CatalogoProdutosTableFilterComposer get catalogoProdutoId {
    final $$CatalogoProdutosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.catalogoProdutoId,
        referencedTable: $db.catalogoProdutos,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CatalogoProdutosTableFilterComposer(
              $db: $db,
              $table: $db.catalogoProdutos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> escoposAlocacaoRefs(
      Expression<bool> Function($$EscoposAlocacaoTableFilterComposer f) f) {
    final $$EscoposAlocacaoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.escoposAlocacao,
        getReferencedColumn: (t) => t.produtoAplicacaoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EscoposAlocacaoTableFilterComposer(
              $db: $db,
              $table: $db.escoposAlocacao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> alocacoesTalhaoRefs(
      Expression<bool> Function($$AlocacoesTalhaoTableFilterComposer f) f) {
    final $$AlocacoesTalhaoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.alocacoesTalhao,
        getReferencedColumn: (t) => t.produtoAplicacaoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlocacoesTalhaoTableFilterComposer(
              $db: $db,
              $table: $db.alocacoesTalhao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProdutosAplicacaoTableOrderingComposer
    extends Composer<_$AppDatabase, $ProdutosAplicacaoTable> {
  $$ProdutosAplicacaoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get produtoNome => $composableBuilder(
      column: $table.produtoNome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get produtoCategoria => $composableBuilder(
      column: $table.produtoCategoria,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get dose => $composableBuilder(
      column: $table.dose, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get doseUnidade => $composableBuilder(
      column: $table.doseUnidade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get areaHa => $composableBuilder(
      column: $table.areaHa, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get talhaoRef => $composableBuilder(
      column: $table.talhaoRef, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalOverride => $composableBuilder(
      column: $table.totalOverride,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get overrideMotivo => $composableBuilder(
      column: $table.overrideMotivo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precoUnitario => $composableBuilder(
      column: $table.precoUnitario,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataPrevista => $composableBuilder(
      column: $table.dataPrevista,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordem => $composableBuilder(
      column: $table.ordem, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$EstadiosTableOrderingComposer get estadioId {
    final $$EstadiosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.estadioId,
        referencedTable: $db.estadios,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EstadiosTableOrderingComposer(
              $db: $db,
              $table: $db.estadios,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CatalogoProdutosTableOrderingComposer get catalogoProdutoId {
    final $$CatalogoProdutosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.catalogoProdutoId,
        referencedTable: $db.catalogoProdutos,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CatalogoProdutosTableOrderingComposer(
              $db: $db,
              $table: $db.catalogoProdutos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProdutosAplicacaoTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProdutosAplicacaoTable> {
  $$ProdutosAplicacaoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get produtoNome => $composableBuilder(
      column: $table.produtoNome, builder: (column) => column);

  GeneratedColumn<String> get produtoCategoria => $composableBuilder(
      column: $table.produtoCategoria, builder: (column) => column);

  GeneratedColumn<double> get dose =>
      $composableBuilder(column: $table.dose, builder: (column) => column);

  GeneratedColumn<String> get doseUnidade => $composableBuilder(
      column: $table.doseUnidade, builder: (column) => column);

  GeneratedColumn<double> get areaHa =>
      $composableBuilder(column: $table.areaHa, builder: (column) => column);

  GeneratedColumn<String> get talhaoRef =>
      $composableBuilder(column: $table.talhaoRef, builder: (column) => column);

  GeneratedColumn<double> get totalOverride => $composableBuilder(
      column: $table.totalOverride, builder: (column) => column);

  GeneratedColumn<String> get overrideMotivo => $composableBuilder(
      column: $table.overrideMotivo, builder: (column) => column);

  GeneratedColumn<double> get precoUnitario => $composableBuilder(
      column: $table.precoUnitario, builder: (column) => column);

  GeneratedColumn<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => column);

  GeneratedColumn<DateTime> get dataPrevista => $composableBuilder(
      column: $table.dataPrevista, builder: (column) => column);

  GeneratedColumn<int> get ordem =>
      $composableBuilder(column: $table.ordem, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$EstadiosTableAnnotationComposer get estadioId {
    final $$EstadiosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.estadioId,
        referencedTable: $db.estadios,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EstadiosTableAnnotationComposer(
              $db: $db,
              $table: $db.estadios,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CatalogoProdutosTableAnnotationComposer get catalogoProdutoId {
    final $$CatalogoProdutosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.catalogoProdutoId,
        referencedTable: $db.catalogoProdutos,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CatalogoProdutosTableAnnotationComposer(
              $db: $db,
              $table: $db.catalogoProdutos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> escoposAlocacaoRefs<T extends Object>(
      Expression<T> Function($$EscoposAlocacaoTableAnnotationComposer a) f) {
    final $$EscoposAlocacaoTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.escoposAlocacao,
        getReferencedColumn: (t) => t.produtoAplicacaoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EscoposAlocacaoTableAnnotationComposer(
              $db: $db,
              $table: $db.escoposAlocacao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> alocacoesTalhaoRefs<T extends Object>(
      Expression<T> Function($$AlocacoesTalhaoTableAnnotationComposer a) f) {
    final $$AlocacoesTalhaoTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.alocacoesTalhao,
        getReferencedColumn: (t) => t.produtoAplicacaoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlocacoesTalhaoTableAnnotationComposer(
              $db: $db,
              $table: $db.alocacoesTalhao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProdutosAplicacaoTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProdutosAplicacaoTable,
    ProdutosAplicacaoData,
    $$ProdutosAplicacaoTableFilterComposer,
    $$ProdutosAplicacaoTableOrderingComposer,
    $$ProdutosAplicacaoTableAnnotationComposer,
    $$ProdutosAplicacaoTableCreateCompanionBuilder,
    $$ProdutosAplicacaoTableUpdateCompanionBuilder,
    (ProdutosAplicacaoData, $$ProdutosAplicacaoTableReferences),
    ProdutosAplicacaoData,
    PrefetchHooks Function(
        {bool estadioId,
        bool catalogoProdutoId,
        bool escoposAlocacaoRefs,
        bool alocacoesTalhaoRefs})> {
  $$ProdutosAplicacaoTableTableManager(
      _$AppDatabase db, $ProdutosAplicacaoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProdutosAplicacaoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProdutosAplicacaoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProdutosAplicacaoTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> estadioId = const Value.absent(),
            Value<String?> catalogoProdutoId = const Value.absent(),
            Value<String> produtoNome = const Value.absent(),
            Value<String> produtoCategoria = const Value.absent(),
            Value<double> dose = const Value.absent(),
            Value<String> doseUnidade = const Value.absent(),
            Value<double> areaHa = const Value.absent(),
            Value<String?> talhaoRef = const Value.absent(),
            Value<double?> totalOverride = const Value.absent(),
            Value<String?> overrideMotivo = const Value.absent(),
            Value<double?> precoUnitario = const Value.absent(),
            Value<String?> observacao = const Value.absent(),
            Value<DateTime?> dataPrevista = const Value.absent(),
            Value<int> ordem = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProdutosAplicacaoCompanion(
            uid: uid,
            userId: userId,
            estadioId: estadioId,
            catalogoProdutoId: catalogoProdutoId,
            produtoNome: produtoNome,
            produtoCategoria: produtoCategoria,
            dose: dose,
            doseUnidade: doseUnidade,
            areaHa: areaHa,
            talhaoRef: talhaoRef,
            totalOverride: totalOverride,
            overrideMotivo: overrideMotivo,
            precoUnitario: precoUnitario,
            observacao: observacao,
            dataPrevista: dataPrevista,
            ordem: ordem,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            Value<String?> userId = const Value.absent(),
            required String estadioId,
            Value<String?> catalogoProdutoId = const Value.absent(),
            required String produtoNome,
            required String produtoCategoria,
            required double dose,
            required String doseUnidade,
            required double areaHa,
            Value<String?> talhaoRef = const Value.absent(),
            Value<double?> totalOverride = const Value.absent(),
            Value<String?> overrideMotivo = const Value.absent(),
            Value<double?> precoUnitario = const Value.absent(),
            Value<String?> observacao = const Value.absent(),
            Value<DateTime?> dataPrevista = const Value.absent(),
            Value<int> ordem = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProdutosAplicacaoCompanion.insert(
            uid: uid,
            userId: userId,
            estadioId: estadioId,
            catalogoProdutoId: catalogoProdutoId,
            produtoNome: produtoNome,
            produtoCategoria: produtoCategoria,
            dose: dose,
            doseUnidade: doseUnidade,
            areaHa: areaHa,
            talhaoRef: talhaoRef,
            totalOverride: totalOverride,
            overrideMotivo: overrideMotivo,
            precoUnitario: precoUnitario,
            observacao: observacao,
            dataPrevista: dataPrevista,
            ordem: ordem,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ProdutosAplicacaoTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {estadioId = false,
              catalogoProdutoId = false,
              escoposAlocacaoRefs = false,
              alocacoesTalhaoRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (escoposAlocacaoRefs) db.escoposAlocacao,
                if (alocacoesTalhaoRefs) db.alocacoesTalhao
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (estadioId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.estadioId,
                    referencedTable:
                        $$ProdutosAplicacaoTableReferences._estadioIdTable(db),
                    referencedColumn: $$ProdutosAplicacaoTableReferences
                        ._estadioIdTable(db)
                        .uid,
                  ) as T;
                }
                if (catalogoProdutoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.catalogoProdutoId,
                    referencedTable: $$ProdutosAplicacaoTableReferences
                        ._catalogoProdutoIdTable(db),
                    referencedColumn: $$ProdutosAplicacaoTableReferences
                        ._catalogoProdutoIdTable(db)
                        .uid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (escoposAlocacaoRefs)
                    await $_getPrefetchedData<ProdutosAplicacaoData,
                            $ProdutosAplicacaoTable, EscoposAlocacaoData>(
                        currentTable: table,
                        referencedTable: $$ProdutosAplicacaoTableReferences
                            ._escoposAlocacaoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProdutosAplicacaoTableReferences(db, table, p0)
                                .escoposAlocacaoRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.produtoAplicacaoId == item.uid),
                        typedResults: items),
                  if (alocacoesTalhaoRefs)
                    await $_getPrefetchedData<ProdutosAplicacaoData,
                            $ProdutosAplicacaoTable, AlocacoesTalhaoData>(
                        currentTable: table,
                        referencedTable: $$ProdutosAplicacaoTableReferences
                            ._alocacoesTalhaoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProdutosAplicacaoTableReferences(db, table, p0)
                                .alocacoesTalhaoRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.produtoAplicacaoId == item.uid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProdutosAplicacaoTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProdutosAplicacaoTable,
    ProdutosAplicacaoData,
    $$ProdutosAplicacaoTableFilterComposer,
    $$ProdutosAplicacaoTableOrderingComposer,
    $$ProdutosAplicacaoTableAnnotationComposer,
    $$ProdutosAplicacaoTableCreateCompanionBuilder,
    $$ProdutosAplicacaoTableUpdateCompanionBuilder,
    (ProdutosAplicacaoData, $$ProdutosAplicacaoTableReferences),
    ProdutosAplicacaoData,
    PrefetchHooks Function(
        {bool estadioId,
        bool catalogoProdutoId,
        bool escoposAlocacaoRefs,
        bool alocacoesTalhaoRefs})>;
typedef $$EscoposAlocacaoTableCreateCompanionBuilder = EscoposAlocacaoCompanion
    Function({
  required String uid,
  Value<String?> userId,
  required String produtoAplicacaoId,
  required String tipo,
  required String talhoesIdsJson,
  required double quantidadeTotal,
  required DateTime dataCriacao,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$EscoposAlocacaoTableUpdateCompanionBuilder = EscoposAlocacaoCompanion
    Function({
  Value<String> uid,
  Value<String?> userId,
  Value<String> produtoAplicacaoId,
  Value<String> tipo,
  Value<String> talhoesIdsJson,
  Value<double> quantidadeTotal,
  Value<DateTime> dataCriacao,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$EscoposAlocacaoTableReferences extends BaseReferences<
    _$AppDatabase, $EscoposAlocacaoTable, EscoposAlocacaoData> {
  $$EscoposAlocacaoTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ProdutosAplicacaoTable _produtoAplicacaoIdTable(_$AppDatabase db) =>
      db.produtosAplicacao.createAlias($_aliasNameGenerator(
          db.escoposAlocacao.produtoAplicacaoId, db.produtosAplicacao.uid));

  $$ProdutosAplicacaoTableProcessedTableManager get produtoAplicacaoId {
    final $_column = $_itemColumn<String>('produto_aplicacao_id')!;

    final manager =
        $$ProdutosAplicacaoTableTableManager($_db, $_db.produtosAplicacao)
            .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_produtoAplicacaoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$AlocacoesTalhaoTable, List<AlocacoesTalhaoData>>
      _alocacoesTalhaoRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.alocacoesTalhao,
              aliasName: $_aliasNameGenerator(
                  db.escoposAlocacao.uid, db.alocacoesTalhao.origemEscopoId));

  $$AlocacoesTalhaoTableProcessedTableManager get alocacoesTalhaoRefs {
    final manager =
        $$AlocacoesTalhaoTableTableManager($_db, $_db.alocacoesTalhao).filter(
            (f) =>
                f.origemEscopoId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache =
        $_typedResult.readTableOrNull(_alocacoesTalhaoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$EscoposAlocacaoTableFilterComposer
    extends Composer<_$AppDatabase, $EscoposAlocacaoTable> {
  $$EscoposAlocacaoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get talhoesIdsJson => $composableBuilder(
      column: $table.talhoesIdsJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get quantidadeTotal => $composableBuilder(
      column: $table.quantidadeTotal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataCriacao => $composableBuilder(
      column: $table.dataCriacao, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$ProdutosAplicacaoTableFilterComposer get produtoAplicacaoId {
    final $$ProdutosAplicacaoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.produtoAplicacaoId,
        referencedTable: $db.produtosAplicacao,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProdutosAplicacaoTableFilterComposer(
              $db: $db,
              $table: $db.produtosAplicacao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> alocacoesTalhaoRefs(
      Expression<bool> Function($$AlocacoesTalhaoTableFilterComposer f) f) {
    final $$AlocacoesTalhaoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.alocacoesTalhao,
        getReferencedColumn: (t) => t.origemEscopoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlocacoesTalhaoTableFilterComposer(
              $db: $db,
              $table: $db.alocacoesTalhao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$EscoposAlocacaoTableOrderingComposer
    extends Composer<_$AppDatabase, $EscoposAlocacaoTable> {
  $$EscoposAlocacaoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get talhoesIdsJson => $composableBuilder(
      column: $table.talhoesIdsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get quantidadeTotal => $composableBuilder(
      column: $table.quantidadeTotal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataCriacao => $composableBuilder(
      column: $table.dataCriacao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$ProdutosAplicacaoTableOrderingComposer get produtoAplicacaoId {
    final $$ProdutosAplicacaoTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.produtoAplicacaoId,
        referencedTable: $db.produtosAplicacao,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProdutosAplicacaoTableOrderingComposer(
              $db: $db,
              $table: $db.produtosAplicacao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EscoposAlocacaoTableAnnotationComposer
    extends Composer<_$AppDatabase, $EscoposAlocacaoTable> {
  $$EscoposAlocacaoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get talhoesIdsJson => $composableBuilder(
      column: $table.talhoesIdsJson, builder: (column) => column);

  GeneratedColumn<double> get quantidadeTotal => $composableBuilder(
      column: $table.quantidadeTotal, builder: (column) => column);

  GeneratedColumn<DateTime> get dataCriacao => $composableBuilder(
      column: $table.dataCriacao, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$ProdutosAplicacaoTableAnnotationComposer get produtoAplicacaoId {
    final $$ProdutosAplicacaoTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.produtoAplicacaoId,
            referencedTable: $db.produtosAplicacao,
            getReferencedColumn: (t) => t.uid,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ProdutosAplicacaoTableAnnotationComposer(
                  $db: $db,
                  $table: $db.produtosAplicacao,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  Expression<T> alocacoesTalhaoRefs<T extends Object>(
      Expression<T> Function($$AlocacoesTalhaoTableAnnotationComposer a) f) {
    final $$AlocacoesTalhaoTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.alocacoesTalhao,
        getReferencedColumn: (t) => t.origemEscopoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlocacoesTalhaoTableAnnotationComposer(
              $db: $db,
              $table: $db.alocacoesTalhao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$EscoposAlocacaoTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EscoposAlocacaoTable,
    EscoposAlocacaoData,
    $$EscoposAlocacaoTableFilterComposer,
    $$EscoposAlocacaoTableOrderingComposer,
    $$EscoposAlocacaoTableAnnotationComposer,
    $$EscoposAlocacaoTableCreateCompanionBuilder,
    $$EscoposAlocacaoTableUpdateCompanionBuilder,
    (EscoposAlocacaoData, $$EscoposAlocacaoTableReferences),
    EscoposAlocacaoData,
    PrefetchHooks Function(
        {bool produtoAplicacaoId, bool alocacoesTalhaoRefs})> {
  $$EscoposAlocacaoTableTableManager(
      _$AppDatabase db, $EscoposAlocacaoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EscoposAlocacaoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EscoposAlocacaoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EscoposAlocacaoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> produtoAplicacaoId = const Value.absent(),
            Value<String> tipo = const Value.absent(),
            Value<String> talhoesIdsJson = const Value.absent(),
            Value<double> quantidadeTotal = const Value.absent(),
            Value<DateTime> dataCriacao = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EscoposAlocacaoCompanion(
            uid: uid,
            userId: userId,
            produtoAplicacaoId: produtoAplicacaoId,
            tipo: tipo,
            talhoesIdsJson: talhoesIdsJson,
            quantidadeTotal: quantidadeTotal,
            dataCriacao: dataCriacao,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            Value<String?> userId = const Value.absent(),
            required String produtoAplicacaoId,
            required String tipo,
            required String talhoesIdsJson,
            required double quantidadeTotal,
            required DateTime dataCriacao,
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EscoposAlocacaoCompanion.insert(
            uid: uid,
            userId: userId,
            produtoAplicacaoId: produtoAplicacaoId,
            tipo: tipo,
            talhoesIdsJson: talhoesIdsJson,
            quantidadeTotal: quantidadeTotal,
            dataCriacao: dataCriacao,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$EscoposAlocacaoTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {produtoAplicacaoId = false, alocacoesTalhaoRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (alocacoesTalhaoRefs) db.alocacoesTalhao
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (produtoAplicacaoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.produtoAplicacaoId,
                    referencedTable: $$EscoposAlocacaoTableReferences
                        ._produtoAplicacaoIdTable(db),
                    referencedColumn: $$EscoposAlocacaoTableReferences
                        ._produtoAplicacaoIdTable(db)
                        .uid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (alocacoesTalhaoRefs)
                    await $_getPrefetchedData<EscoposAlocacaoData,
                            $EscoposAlocacaoTable, AlocacoesTalhaoData>(
                        currentTable: table,
                        referencedTable: $$EscoposAlocacaoTableReferences
                            ._alocacoesTalhaoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EscoposAlocacaoTableReferences(db, table, p0)
                                .alocacoesTalhaoRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.origemEscopoId == item.uid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$EscoposAlocacaoTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EscoposAlocacaoTable,
    EscoposAlocacaoData,
    $$EscoposAlocacaoTableFilterComposer,
    $$EscoposAlocacaoTableOrderingComposer,
    $$EscoposAlocacaoTableAnnotationComposer,
    $$EscoposAlocacaoTableCreateCompanionBuilder,
    $$EscoposAlocacaoTableUpdateCompanionBuilder,
    (EscoposAlocacaoData, $$EscoposAlocacaoTableReferences),
    EscoposAlocacaoData,
    PrefetchHooks Function(
        {bool produtoAplicacaoId, bool alocacoesTalhaoRefs})>;
typedef $$AlocacoesTalhaoTableCreateCompanionBuilder = AlocacoesTalhaoCompanion
    Function({
  required String uid,
  Value<String?> userId,
  required String produtoAplicacaoId,
  required String talhaoId,
  required double quantidadeAlocada,
  required String origemEscopoId,
  required DateTime dataLancamento,
  Value<bool> foiAjustadoManualmente,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$AlocacoesTalhaoTableUpdateCompanionBuilder = AlocacoesTalhaoCompanion
    Function({
  Value<String> uid,
  Value<String?> userId,
  Value<String> produtoAplicacaoId,
  Value<String> talhaoId,
  Value<double> quantidadeAlocada,
  Value<String> origemEscopoId,
  Value<DateTime> dataLancamento,
  Value<bool> foiAjustadoManualmente,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$AlocacoesTalhaoTableReferences extends BaseReferences<
    _$AppDatabase, $AlocacoesTalhaoTable, AlocacoesTalhaoData> {
  $$AlocacoesTalhaoTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ProdutosAplicacaoTable _produtoAplicacaoIdTable(_$AppDatabase db) =>
      db.produtosAplicacao.createAlias($_aliasNameGenerator(
          db.alocacoesTalhao.produtoAplicacaoId, db.produtosAplicacao.uid));

  $$ProdutosAplicacaoTableProcessedTableManager get produtoAplicacaoId {
    final $_column = $_itemColumn<String>('produto_aplicacao_id')!;

    final manager =
        $$ProdutosAplicacaoTableTableManager($_db, $_db.produtosAplicacao)
            .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_produtoAplicacaoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TalhoesTable _talhaoIdTable(_$AppDatabase db) =>
      db.talhoes.createAlias(
          $_aliasNameGenerator(db.alocacoesTalhao.talhaoId, db.talhoes.uid));

  $$TalhoesTableProcessedTableManager get talhaoId {
    final $_column = $_itemColumn<String>('talhao_id')!;

    final manager = $$TalhoesTableTableManager($_db, $_db.talhoes)
        .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_talhaoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $EscoposAlocacaoTable _origemEscopoIdTable(_$AppDatabase db) =>
      db.escoposAlocacao.createAlias($_aliasNameGenerator(
          db.alocacoesTalhao.origemEscopoId, db.escoposAlocacao.uid));

  $$EscoposAlocacaoTableProcessedTableManager get origemEscopoId {
    final $_column = $_itemColumn<String>('origem_escopo_id')!;

    final manager =
        $$EscoposAlocacaoTableTableManager($_db, $_db.escoposAlocacao)
            .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_origemEscopoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AlocacoesTalhaoTableFilterComposer
    extends Composer<_$AppDatabase, $AlocacoesTalhaoTable> {
  $$AlocacoesTalhaoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get quantidadeAlocada => $composableBuilder(
      column: $table.quantidadeAlocada,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataLancamento => $composableBuilder(
      column: $table.dataLancamento,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get foiAjustadoManualmente => $composableBuilder(
      column: $table.foiAjustadoManualmente,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$ProdutosAplicacaoTableFilterComposer get produtoAplicacaoId {
    final $$ProdutosAplicacaoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.produtoAplicacaoId,
        referencedTable: $db.produtosAplicacao,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProdutosAplicacaoTableFilterComposer(
              $db: $db,
              $table: $db.produtosAplicacao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TalhoesTableFilterComposer get talhaoId {
    final $$TalhoesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.talhaoId,
        referencedTable: $db.talhoes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesTableFilterComposer(
              $db: $db,
              $table: $db.talhoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EscoposAlocacaoTableFilterComposer get origemEscopoId {
    final $$EscoposAlocacaoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.origemEscopoId,
        referencedTable: $db.escoposAlocacao,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EscoposAlocacaoTableFilterComposer(
              $db: $db,
              $table: $db.escoposAlocacao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AlocacoesTalhaoTableOrderingComposer
    extends Composer<_$AppDatabase, $AlocacoesTalhaoTable> {
  $$AlocacoesTalhaoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get quantidadeAlocada => $composableBuilder(
      column: $table.quantidadeAlocada,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataLancamento => $composableBuilder(
      column: $table.dataLancamento,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get foiAjustadoManualmente => $composableBuilder(
      column: $table.foiAjustadoManualmente,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$ProdutosAplicacaoTableOrderingComposer get produtoAplicacaoId {
    final $$ProdutosAplicacaoTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.produtoAplicacaoId,
        referencedTable: $db.produtosAplicacao,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProdutosAplicacaoTableOrderingComposer(
              $db: $db,
              $table: $db.produtosAplicacao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TalhoesTableOrderingComposer get talhaoId {
    final $$TalhoesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.talhaoId,
        referencedTable: $db.talhoes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesTableOrderingComposer(
              $db: $db,
              $table: $db.talhoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EscoposAlocacaoTableOrderingComposer get origemEscopoId {
    final $$EscoposAlocacaoTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.origemEscopoId,
        referencedTable: $db.escoposAlocacao,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EscoposAlocacaoTableOrderingComposer(
              $db: $db,
              $table: $db.escoposAlocacao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AlocacoesTalhaoTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlocacoesTalhaoTable> {
  $$AlocacoesTalhaoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<double> get quantidadeAlocada => $composableBuilder(
      column: $table.quantidadeAlocada, builder: (column) => column);

  GeneratedColumn<DateTime> get dataLancamento => $composableBuilder(
      column: $table.dataLancamento, builder: (column) => column);

  GeneratedColumn<bool> get foiAjustadoManualmente => $composableBuilder(
      column: $table.foiAjustadoManualmente, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$ProdutosAplicacaoTableAnnotationComposer get produtoAplicacaoId {
    final $$ProdutosAplicacaoTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.produtoAplicacaoId,
            referencedTable: $db.produtosAplicacao,
            getReferencedColumn: (t) => t.uid,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ProdutosAplicacaoTableAnnotationComposer(
                  $db: $db,
                  $table: $db.produtosAplicacao,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$TalhoesTableAnnotationComposer get talhaoId {
    final $$TalhoesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.talhaoId,
        referencedTable: $db.talhoes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesTableAnnotationComposer(
              $db: $db,
              $table: $db.talhoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EscoposAlocacaoTableAnnotationComposer get origemEscopoId {
    final $$EscoposAlocacaoTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.origemEscopoId,
        referencedTable: $db.escoposAlocacao,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EscoposAlocacaoTableAnnotationComposer(
              $db: $db,
              $table: $db.escoposAlocacao,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AlocacoesTalhaoTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AlocacoesTalhaoTable,
    AlocacoesTalhaoData,
    $$AlocacoesTalhaoTableFilterComposer,
    $$AlocacoesTalhaoTableOrderingComposer,
    $$AlocacoesTalhaoTableAnnotationComposer,
    $$AlocacoesTalhaoTableCreateCompanionBuilder,
    $$AlocacoesTalhaoTableUpdateCompanionBuilder,
    (AlocacoesTalhaoData, $$AlocacoesTalhaoTableReferences),
    AlocacoesTalhaoData,
    PrefetchHooks Function(
        {bool produtoAplicacaoId, bool talhaoId, bool origemEscopoId})> {
  $$AlocacoesTalhaoTableTableManager(
      _$AppDatabase db, $AlocacoesTalhaoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlocacoesTalhaoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlocacoesTalhaoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlocacoesTalhaoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> produtoAplicacaoId = const Value.absent(),
            Value<String> talhaoId = const Value.absent(),
            Value<double> quantidadeAlocada = const Value.absent(),
            Value<String> origemEscopoId = const Value.absent(),
            Value<DateTime> dataLancamento = const Value.absent(),
            Value<bool> foiAjustadoManualmente = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlocacoesTalhaoCompanion(
            uid: uid,
            userId: userId,
            produtoAplicacaoId: produtoAplicacaoId,
            talhaoId: talhaoId,
            quantidadeAlocada: quantidadeAlocada,
            origemEscopoId: origemEscopoId,
            dataLancamento: dataLancamento,
            foiAjustadoManualmente: foiAjustadoManualmente,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            Value<String?> userId = const Value.absent(),
            required String produtoAplicacaoId,
            required String talhaoId,
            required double quantidadeAlocada,
            required String origemEscopoId,
            required DateTime dataLancamento,
            Value<bool> foiAjustadoManualmente = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlocacoesTalhaoCompanion.insert(
            uid: uid,
            userId: userId,
            produtoAplicacaoId: produtoAplicacaoId,
            talhaoId: talhaoId,
            quantidadeAlocada: quantidadeAlocada,
            origemEscopoId: origemEscopoId,
            dataLancamento: dataLancamento,
            foiAjustadoManualmente: foiAjustadoManualmente,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AlocacoesTalhaoTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {produtoAplicacaoId = false,
              talhaoId = false,
              origemEscopoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (produtoAplicacaoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.produtoAplicacaoId,
                    referencedTable: $$AlocacoesTalhaoTableReferences
                        ._produtoAplicacaoIdTable(db),
                    referencedColumn: $$AlocacoesTalhaoTableReferences
                        ._produtoAplicacaoIdTable(db)
                        .uid,
                  ) as T;
                }
                if (talhaoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.talhaoId,
                    referencedTable:
                        $$AlocacoesTalhaoTableReferences._talhaoIdTable(db),
                    referencedColumn:
                        $$AlocacoesTalhaoTableReferences._talhaoIdTable(db).uid,
                  ) as T;
                }
                if (origemEscopoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.origemEscopoId,
                    referencedTable: $$AlocacoesTalhaoTableReferences
                        ._origemEscopoIdTable(db),
                    referencedColumn: $$AlocacoesTalhaoTableReferences
                        ._origemEscopoIdTable(db)
                        .uid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AlocacoesTalhaoTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AlocacoesTalhaoTable,
    AlocacoesTalhaoData,
    $$AlocacoesTalhaoTableFilterComposer,
    $$AlocacoesTalhaoTableOrderingComposer,
    $$AlocacoesTalhaoTableAnnotationComposer,
    $$AlocacoesTalhaoTableCreateCompanionBuilder,
    $$AlocacoesTalhaoTableUpdateCompanionBuilder,
    (AlocacoesTalhaoData, $$AlocacoesTalhaoTableReferences),
    AlocacoesTalhaoData,
    PrefetchHooks Function(
        {bool produtoAplicacaoId, bool talhaoId, bool origemEscopoId})>;
typedef $$SementesTalhaoTableCreateCompanionBuilder = SementesTalhaoCompanion
    Function({
  required String uid,
  Value<String?> userId,
  required String planoId,
  required String estadioId,
  Value<String?> talhaoId,
  required String cultivar,
  required double populacaoSementesPorHa,
  required int sementesPorEmbalagem,
  required double espacamentoPlantioCm,
  Value<int?> embalagensManual,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$SementesTalhaoTableUpdateCompanionBuilder = SementesTalhaoCompanion
    Function({
  Value<String> uid,
  Value<String?> userId,
  Value<String> planoId,
  Value<String> estadioId,
  Value<String?> talhaoId,
  Value<String> cultivar,
  Value<double> populacaoSementesPorHa,
  Value<int> sementesPorEmbalagem,
  Value<double> espacamentoPlantioCm,
  Value<int?> embalagensManual,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$SementesTalhaoTableReferences extends BaseReferences<
    _$AppDatabase, $SementesTalhaoTable, SementesTalhaoData> {
  $$SementesTalhaoTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PlanosTable _planoIdTable(_$AppDatabase db) => db.planos.createAlias(
      $_aliasNameGenerator(db.sementesTalhao.planoId, db.planos.uid));

  $$PlanosTableProcessedTableManager get planoId {
    final $_column = $_itemColumn<String>('plano_id')!;

    final manager = $$PlanosTableTableManager($_db, $_db.planos)
        .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $EstadiosTable _estadioIdTable(_$AppDatabase db) =>
      db.estadios.createAlias(
          $_aliasNameGenerator(db.sementesTalhao.estadioId, db.estadios.uid));

  $$EstadiosTableProcessedTableManager get estadioId {
    final $_column = $_itemColumn<String>('estadio_id')!;

    final manager = $$EstadiosTableTableManager($_db, $_db.estadios)
        .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_estadioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TalhoesTable _talhaoIdTable(_$AppDatabase db) =>
      db.talhoes.createAlias(
          $_aliasNameGenerator(db.sementesTalhao.talhaoId, db.talhoes.uid));

  $$TalhoesTableProcessedTableManager? get talhaoId {
    final $_column = $_itemColumn<String>('talhao_id');
    if ($_column == null) return null;
    final manager = $$TalhoesTableTableManager($_db, $_db.talhoes)
        .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_talhaoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SementesTalhaoTableFilterComposer
    extends Composer<_$AppDatabase, $SementesTalhaoTable> {
  $$SementesTalhaoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cultivar => $composableBuilder(
      column: $table.cultivar, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get populacaoSementesPorHa => $composableBuilder(
      column: $table.populacaoSementesPorHa,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sementesPorEmbalagem => $composableBuilder(
      column: $table.sementesPorEmbalagem,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get espacamentoPlantioCm => $composableBuilder(
      column: $table.espacamentoPlantioCm,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get embalagensManual => $composableBuilder(
      column: $table.embalagensManual,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$PlanosTableFilterComposer get planoId {
    final $$PlanosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planoId,
        referencedTable: $db.planos,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanosTableFilterComposer(
              $db: $db,
              $table: $db.planos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EstadiosTableFilterComposer get estadioId {
    final $$EstadiosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.estadioId,
        referencedTable: $db.estadios,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EstadiosTableFilterComposer(
              $db: $db,
              $table: $db.estadios,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TalhoesTableFilterComposer get talhaoId {
    final $$TalhoesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.talhaoId,
        referencedTable: $db.talhoes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesTableFilterComposer(
              $db: $db,
              $table: $db.talhoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SementesTalhaoTableOrderingComposer
    extends Composer<_$AppDatabase, $SementesTalhaoTable> {
  $$SementesTalhaoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cultivar => $composableBuilder(
      column: $table.cultivar, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get populacaoSementesPorHa => $composableBuilder(
      column: $table.populacaoSementesPorHa,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sementesPorEmbalagem => $composableBuilder(
      column: $table.sementesPorEmbalagem,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get espacamentoPlantioCm => $composableBuilder(
      column: $table.espacamentoPlantioCm,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get embalagensManual => $composableBuilder(
      column: $table.embalagensManual,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$PlanosTableOrderingComposer get planoId {
    final $$PlanosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planoId,
        referencedTable: $db.planos,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanosTableOrderingComposer(
              $db: $db,
              $table: $db.planos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EstadiosTableOrderingComposer get estadioId {
    final $$EstadiosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.estadioId,
        referencedTable: $db.estadios,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EstadiosTableOrderingComposer(
              $db: $db,
              $table: $db.estadios,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TalhoesTableOrderingComposer get talhaoId {
    final $$TalhoesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.talhaoId,
        referencedTable: $db.talhoes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesTableOrderingComposer(
              $db: $db,
              $table: $db.talhoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SementesTalhaoTableAnnotationComposer
    extends Composer<_$AppDatabase, $SementesTalhaoTable> {
  $$SementesTalhaoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get cultivar =>
      $composableBuilder(column: $table.cultivar, builder: (column) => column);

  GeneratedColumn<double> get populacaoSementesPorHa => $composableBuilder(
      column: $table.populacaoSementesPorHa, builder: (column) => column);

  GeneratedColumn<int> get sementesPorEmbalagem => $composableBuilder(
      column: $table.sementesPorEmbalagem, builder: (column) => column);

  GeneratedColumn<double> get espacamentoPlantioCm => $composableBuilder(
      column: $table.espacamentoPlantioCm, builder: (column) => column);

  GeneratedColumn<int> get embalagensManual => $composableBuilder(
      column: $table.embalagensManual, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$PlanosTableAnnotationComposer get planoId {
    final $$PlanosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planoId,
        referencedTable: $db.planos,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanosTableAnnotationComposer(
              $db: $db,
              $table: $db.planos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EstadiosTableAnnotationComposer get estadioId {
    final $$EstadiosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.estadioId,
        referencedTable: $db.estadios,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EstadiosTableAnnotationComposer(
              $db: $db,
              $table: $db.estadios,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TalhoesTableAnnotationComposer get talhaoId {
    final $$TalhoesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.talhaoId,
        referencedTable: $db.talhoes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesTableAnnotationComposer(
              $db: $db,
              $table: $db.talhoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SementesTalhaoTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SementesTalhaoTable,
    SementesTalhaoData,
    $$SementesTalhaoTableFilterComposer,
    $$SementesTalhaoTableOrderingComposer,
    $$SementesTalhaoTableAnnotationComposer,
    $$SementesTalhaoTableCreateCompanionBuilder,
    $$SementesTalhaoTableUpdateCompanionBuilder,
    (SementesTalhaoData, $$SementesTalhaoTableReferences),
    SementesTalhaoData,
    PrefetchHooks Function({bool planoId, bool estadioId, bool talhaoId})> {
  $$SementesTalhaoTableTableManager(
      _$AppDatabase db, $SementesTalhaoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SementesTalhaoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SementesTalhaoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SementesTalhaoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> planoId = const Value.absent(),
            Value<String> estadioId = const Value.absent(),
            Value<String?> talhaoId = const Value.absent(),
            Value<String> cultivar = const Value.absent(),
            Value<double> populacaoSementesPorHa = const Value.absent(),
            Value<int> sementesPorEmbalagem = const Value.absent(),
            Value<double> espacamentoPlantioCm = const Value.absent(),
            Value<int?> embalagensManual = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SementesTalhaoCompanion(
            uid: uid,
            userId: userId,
            planoId: planoId,
            estadioId: estadioId,
            talhaoId: talhaoId,
            cultivar: cultivar,
            populacaoSementesPorHa: populacaoSementesPorHa,
            sementesPorEmbalagem: sementesPorEmbalagem,
            espacamentoPlantioCm: espacamentoPlantioCm,
            embalagensManual: embalagensManual,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            Value<String?> userId = const Value.absent(),
            required String planoId,
            required String estadioId,
            Value<String?> talhaoId = const Value.absent(),
            required String cultivar,
            required double populacaoSementesPorHa,
            required int sementesPorEmbalagem,
            required double espacamentoPlantioCm,
            Value<int?> embalagensManual = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SementesTalhaoCompanion.insert(
            uid: uid,
            userId: userId,
            planoId: planoId,
            estadioId: estadioId,
            talhaoId: talhaoId,
            cultivar: cultivar,
            populacaoSementesPorHa: populacaoSementesPorHa,
            sementesPorEmbalagem: sementesPorEmbalagem,
            espacamentoPlantioCm: espacamentoPlantioCm,
            embalagensManual: embalagensManual,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SementesTalhaoTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {planoId = false, estadioId = false, talhaoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (planoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.planoId,
                    referencedTable:
                        $$SementesTalhaoTableReferences._planoIdTable(db),
                    referencedColumn:
                        $$SementesTalhaoTableReferences._planoIdTable(db).uid,
                  ) as T;
                }
                if (estadioId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.estadioId,
                    referencedTable:
                        $$SementesTalhaoTableReferences._estadioIdTable(db),
                    referencedColumn:
                        $$SementesTalhaoTableReferences._estadioIdTable(db).uid,
                  ) as T;
                }
                if (talhaoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.talhaoId,
                    referencedTable:
                        $$SementesTalhaoTableReferences._talhaoIdTable(db),
                    referencedColumn:
                        $$SementesTalhaoTableReferences._talhaoIdTable(db).uid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SementesTalhaoTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SementesTalhaoTable,
    SementesTalhaoData,
    $$SementesTalhaoTableFilterComposer,
    $$SementesTalhaoTableOrderingComposer,
    $$SementesTalhaoTableAnnotationComposer,
    $$SementesTalhaoTableCreateCompanionBuilder,
    $$SementesTalhaoTableUpdateCompanionBuilder,
    (SementesTalhaoData, $$SementesTalhaoTableReferences),
    SementesTalhaoData,
    PrefetchHooks Function({bool planoId, bool estadioId, bool talhaoId})>;
typedef $$CronogramasSojaTalhaoTableCreateCompanionBuilder
    = CronogramasSojaTalhaoCompanion Function({
  required String uid,
  Value<String?> userId,
  required String talhaoId,
  required String cultura,
  Value<String> materialCultivar,
  required DateTime dataPlantio,
  Value<int> diasEmergencia,
  Value<int> daePosEmergente,
  Value<int> diasRecuperacaoPosEmergente,
  Value<int> intervaloFungicidaDias,
  Value<int> totalAplicacoesFungicida,
  Value<int> daeMaturacaoCiclo,
  Value<int> diasAntesR8Dessecante,
  Value<int> diasAntecipacaoColheitaReal,
  Value<int> diasDessecacaoPrePlantio,
  Value<String> grupoRegulagemId,
  Value<bool> plantioDefinido,
  Value<int> ordem,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$CronogramasSojaTalhaoTableUpdateCompanionBuilder
    = CronogramasSojaTalhaoCompanion Function({
  Value<String> uid,
  Value<String?> userId,
  Value<String> talhaoId,
  Value<String> cultura,
  Value<String> materialCultivar,
  Value<DateTime> dataPlantio,
  Value<int> diasEmergencia,
  Value<int> daePosEmergente,
  Value<int> diasRecuperacaoPosEmergente,
  Value<int> intervaloFungicidaDias,
  Value<int> totalAplicacoesFungicida,
  Value<int> daeMaturacaoCiclo,
  Value<int> diasAntesR8Dessecante,
  Value<int> diasAntecipacaoColheitaReal,
  Value<int> diasDessecacaoPrePlantio,
  Value<String> grupoRegulagemId,
  Value<bool> plantioDefinido,
  Value<int> ordem,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$CronogramasSojaTalhaoTableReferences extends BaseReferences<
    _$AppDatabase, $CronogramasSojaTalhaoTable, CronogramasSojaTalhaoData> {
  $$CronogramasSojaTalhaoTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TalhoesTable _talhaoIdTable(_$AppDatabase db) =>
      db.talhoes.createAlias($_aliasNameGenerator(
          db.cronogramasSojaTalhao.talhaoId, db.talhoes.uid));

  $$TalhoesTableProcessedTableManager get talhaoId {
    final $_column = $_itemColumn<String>('talhao_id')!;

    final manager = $$TalhoesTableTableManager($_db, $_db.talhoes)
        .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_talhaoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CronogramasSojaTalhaoTableFilterComposer
    extends Composer<_$AppDatabase, $CronogramasSojaTalhaoTable> {
  $$CronogramasSojaTalhaoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cultura => $composableBuilder(
      column: $table.cultura, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get materialCultivar => $composableBuilder(
      column: $table.materialCultivar,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataPlantio => $composableBuilder(
      column: $table.dataPlantio, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diasEmergencia => $composableBuilder(
      column: $table.diasEmergencia,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get daePosEmergente => $composableBuilder(
      column: $table.daePosEmergente,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diasRecuperacaoPosEmergente => $composableBuilder(
      column: $table.diasRecuperacaoPosEmergente,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get intervaloFungicidaDias => $composableBuilder(
      column: $table.intervaloFungicidaDias,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalAplicacoesFungicida => $composableBuilder(
      column: $table.totalAplicacoesFungicida,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get daeMaturacaoCiclo => $composableBuilder(
      column: $table.daeMaturacaoCiclo,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diasAntesR8Dessecante => $composableBuilder(
      column: $table.diasAntesR8Dessecante,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diasAntecipacaoColheitaReal => $composableBuilder(
      column: $table.diasAntecipacaoColheitaReal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diasDessecacaoPrePlantio => $composableBuilder(
      column: $table.diasDessecacaoPrePlantio,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get grupoRegulagemId => $composableBuilder(
      column: $table.grupoRegulagemId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get plantioDefinido => $composableBuilder(
      column: $table.plantioDefinido,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordem => $composableBuilder(
      column: $table.ordem, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$TalhoesTableFilterComposer get talhaoId {
    final $$TalhoesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.talhaoId,
        referencedTable: $db.talhoes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesTableFilterComposer(
              $db: $db,
              $table: $db.talhoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CronogramasSojaTalhaoTableOrderingComposer
    extends Composer<_$AppDatabase, $CronogramasSojaTalhaoTable> {
  $$CronogramasSojaTalhaoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cultura => $composableBuilder(
      column: $table.cultura, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get materialCultivar => $composableBuilder(
      column: $table.materialCultivar,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataPlantio => $composableBuilder(
      column: $table.dataPlantio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diasEmergencia => $composableBuilder(
      column: $table.diasEmergencia,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get daePosEmergente => $composableBuilder(
      column: $table.daePosEmergente,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diasRecuperacaoPosEmergente => $composableBuilder(
      column: $table.diasRecuperacaoPosEmergente,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get intervaloFungicidaDias => $composableBuilder(
      column: $table.intervaloFungicidaDias,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalAplicacoesFungicida => $composableBuilder(
      column: $table.totalAplicacoesFungicida,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get daeMaturacaoCiclo => $composableBuilder(
      column: $table.daeMaturacaoCiclo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diasAntesR8Dessecante => $composableBuilder(
      column: $table.diasAntesR8Dessecante,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diasAntecipacaoColheitaReal => $composableBuilder(
      column: $table.diasAntecipacaoColheitaReal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diasDessecacaoPrePlantio => $composableBuilder(
      column: $table.diasDessecacaoPrePlantio,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get grupoRegulagemId => $composableBuilder(
      column: $table.grupoRegulagemId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get plantioDefinido => $composableBuilder(
      column: $table.plantioDefinido,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordem => $composableBuilder(
      column: $table.ordem, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$TalhoesTableOrderingComposer get talhaoId {
    final $$TalhoesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.talhaoId,
        referencedTable: $db.talhoes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesTableOrderingComposer(
              $db: $db,
              $table: $db.talhoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CronogramasSojaTalhaoTableAnnotationComposer
    extends Composer<_$AppDatabase, $CronogramasSojaTalhaoTable> {
  $$CronogramasSojaTalhaoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get cultura =>
      $composableBuilder(column: $table.cultura, builder: (column) => column);

  GeneratedColumn<String> get materialCultivar => $composableBuilder(
      column: $table.materialCultivar, builder: (column) => column);

  GeneratedColumn<DateTime> get dataPlantio => $composableBuilder(
      column: $table.dataPlantio, builder: (column) => column);

  GeneratedColumn<int> get diasEmergencia => $composableBuilder(
      column: $table.diasEmergencia, builder: (column) => column);

  GeneratedColumn<int> get daePosEmergente => $composableBuilder(
      column: $table.daePosEmergente, builder: (column) => column);

  GeneratedColumn<int> get diasRecuperacaoPosEmergente => $composableBuilder(
      column: $table.diasRecuperacaoPosEmergente, builder: (column) => column);

  GeneratedColumn<int> get intervaloFungicidaDias => $composableBuilder(
      column: $table.intervaloFungicidaDias, builder: (column) => column);

  GeneratedColumn<int> get totalAplicacoesFungicida => $composableBuilder(
      column: $table.totalAplicacoesFungicida, builder: (column) => column);

  GeneratedColumn<int> get daeMaturacaoCiclo => $composableBuilder(
      column: $table.daeMaturacaoCiclo, builder: (column) => column);

  GeneratedColumn<int> get diasAntesR8Dessecante => $composableBuilder(
      column: $table.diasAntesR8Dessecante, builder: (column) => column);

  GeneratedColumn<int> get diasAntecipacaoColheitaReal => $composableBuilder(
      column: $table.diasAntecipacaoColheitaReal, builder: (column) => column);

  GeneratedColumn<int> get diasDessecacaoPrePlantio => $composableBuilder(
      column: $table.diasDessecacaoPrePlantio, builder: (column) => column);

  GeneratedColumn<String> get grupoRegulagemId => $composableBuilder(
      column: $table.grupoRegulagemId, builder: (column) => column);

  GeneratedColumn<bool> get plantioDefinido => $composableBuilder(
      column: $table.plantioDefinido, builder: (column) => column);

  GeneratedColumn<int> get ordem =>
      $composableBuilder(column: $table.ordem, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$TalhoesTableAnnotationComposer get talhaoId {
    final $$TalhoesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.talhaoId,
        referencedTable: $db.talhoes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesTableAnnotationComposer(
              $db: $db,
              $table: $db.talhoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CronogramasSojaTalhaoTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CronogramasSojaTalhaoTable,
    CronogramasSojaTalhaoData,
    $$CronogramasSojaTalhaoTableFilterComposer,
    $$CronogramasSojaTalhaoTableOrderingComposer,
    $$CronogramasSojaTalhaoTableAnnotationComposer,
    $$CronogramasSojaTalhaoTableCreateCompanionBuilder,
    $$CronogramasSojaTalhaoTableUpdateCompanionBuilder,
    (CronogramasSojaTalhaoData, $$CronogramasSojaTalhaoTableReferences),
    CronogramasSojaTalhaoData,
    PrefetchHooks Function({bool talhaoId})> {
  $$CronogramasSojaTalhaoTableTableManager(
      _$AppDatabase db, $CronogramasSojaTalhaoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CronogramasSojaTalhaoTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$CronogramasSojaTalhaoTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CronogramasSojaTalhaoTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> talhaoId = const Value.absent(),
            Value<String> cultura = const Value.absent(),
            Value<String> materialCultivar = const Value.absent(),
            Value<DateTime> dataPlantio = const Value.absent(),
            Value<int> diasEmergencia = const Value.absent(),
            Value<int> daePosEmergente = const Value.absent(),
            Value<int> diasRecuperacaoPosEmergente = const Value.absent(),
            Value<int> intervaloFungicidaDias = const Value.absent(),
            Value<int> totalAplicacoesFungicida = const Value.absent(),
            Value<int> daeMaturacaoCiclo = const Value.absent(),
            Value<int> diasAntesR8Dessecante = const Value.absent(),
            Value<int> diasAntecipacaoColheitaReal = const Value.absent(),
            Value<int> diasDessecacaoPrePlantio = const Value.absent(),
            Value<String> grupoRegulagemId = const Value.absent(),
            Value<bool> plantioDefinido = const Value.absent(),
            Value<int> ordem = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CronogramasSojaTalhaoCompanion(
            uid: uid,
            userId: userId,
            talhaoId: talhaoId,
            cultura: cultura,
            materialCultivar: materialCultivar,
            dataPlantio: dataPlantio,
            diasEmergencia: diasEmergencia,
            daePosEmergente: daePosEmergente,
            diasRecuperacaoPosEmergente: diasRecuperacaoPosEmergente,
            intervaloFungicidaDias: intervaloFungicidaDias,
            totalAplicacoesFungicida: totalAplicacoesFungicida,
            daeMaturacaoCiclo: daeMaturacaoCiclo,
            diasAntesR8Dessecante: diasAntesR8Dessecante,
            diasAntecipacaoColheitaReal: diasAntecipacaoColheitaReal,
            diasDessecacaoPrePlantio: diasDessecacaoPrePlantio,
            grupoRegulagemId: grupoRegulagemId,
            plantioDefinido: plantioDefinido,
            ordem: ordem,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            Value<String?> userId = const Value.absent(),
            required String talhaoId,
            required String cultura,
            Value<String> materialCultivar = const Value.absent(),
            required DateTime dataPlantio,
            Value<int> diasEmergencia = const Value.absent(),
            Value<int> daePosEmergente = const Value.absent(),
            Value<int> diasRecuperacaoPosEmergente = const Value.absent(),
            Value<int> intervaloFungicidaDias = const Value.absent(),
            Value<int> totalAplicacoesFungicida = const Value.absent(),
            Value<int> daeMaturacaoCiclo = const Value.absent(),
            Value<int> diasAntesR8Dessecante = const Value.absent(),
            Value<int> diasAntecipacaoColheitaReal = const Value.absent(),
            Value<int> diasDessecacaoPrePlantio = const Value.absent(),
            Value<String> grupoRegulagemId = const Value.absent(),
            Value<bool> plantioDefinido = const Value.absent(),
            Value<int> ordem = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CronogramasSojaTalhaoCompanion.insert(
            uid: uid,
            userId: userId,
            talhaoId: talhaoId,
            cultura: cultura,
            materialCultivar: materialCultivar,
            dataPlantio: dataPlantio,
            diasEmergencia: diasEmergencia,
            daePosEmergente: daePosEmergente,
            diasRecuperacaoPosEmergente: diasRecuperacaoPosEmergente,
            intervaloFungicidaDias: intervaloFungicidaDias,
            totalAplicacoesFungicida: totalAplicacoesFungicida,
            daeMaturacaoCiclo: daeMaturacaoCiclo,
            diasAntesR8Dessecante: diasAntesR8Dessecante,
            diasAntecipacaoColheitaReal: diasAntecipacaoColheitaReal,
            diasDessecacaoPrePlantio: diasDessecacaoPrePlantio,
            grupoRegulagemId: grupoRegulagemId,
            plantioDefinido: plantioDefinido,
            ordem: ordem,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CronogramasSojaTalhaoTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({talhaoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (talhaoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.talhaoId,
                    referencedTable: $$CronogramasSojaTalhaoTableReferences
                        ._talhaoIdTable(db),
                    referencedColumn: $$CronogramasSojaTalhaoTableReferences
                        ._talhaoIdTable(db)
                        .uid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CronogramasSojaTalhaoTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $CronogramasSojaTalhaoTable,
        CronogramasSojaTalhaoData,
        $$CronogramasSojaTalhaoTableFilterComposer,
        $$CronogramasSojaTalhaoTableOrderingComposer,
        $$CronogramasSojaTalhaoTableAnnotationComposer,
        $$CronogramasSojaTalhaoTableCreateCompanionBuilder,
        $$CronogramasSojaTalhaoTableUpdateCompanionBuilder,
        (CronogramasSojaTalhaoData, $$CronogramasSojaTalhaoTableReferences),
        CronogramasSojaTalhaoData,
        PrefetchHooks Function({bool talhaoId})>;
typedef $$TalhoesSafraTableCreateCompanionBuilder = TalhoesSafraCompanion
    Function({
  required String uid,
  Value<String?> userId,
  required String planoId,
  required String talhaoId,
  required String cultura,
  Value<String> materialCultivar,
  required DateTime dataPlantio,
  Value<int> diasEmergencia,
  Value<int> daePosEmergente,
  Value<int> diasRecuperacaoPosEmergente,
  Value<int> intervaloFungicidaDias,
  Value<int> totalAplicacoesFungicida,
  Value<int> daeMaturacaoCiclo,
  Value<int> diasAntesR8Dessecante,
  Value<int> diasAntecipacaoColheitaReal,
  Value<int> diasDessecacaoPrePlantio,
  Value<String> grupoRegulagemId,
  Value<bool> plantioDefinido,
  Value<int> ordem,
  Value<String> programaOperacionalIds,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$TalhoesSafraTableUpdateCompanionBuilder = TalhoesSafraCompanion
    Function({
  Value<String> uid,
  Value<String?> userId,
  Value<String> planoId,
  Value<String> talhaoId,
  Value<String> cultura,
  Value<String> materialCultivar,
  Value<DateTime> dataPlantio,
  Value<int> diasEmergencia,
  Value<int> daePosEmergente,
  Value<int> diasRecuperacaoPosEmergente,
  Value<int> intervaloFungicidaDias,
  Value<int> totalAplicacoesFungicida,
  Value<int> daeMaturacaoCiclo,
  Value<int> diasAntesR8Dessecante,
  Value<int> diasAntecipacaoColheitaReal,
  Value<int> diasDessecacaoPrePlantio,
  Value<String> grupoRegulagemId,
  Value<bool> plantioDefinido,
  Value<int> ordem,
  Value<String> programaOperacionalIds,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$TalhoesSafraTableReferences extends BaseReferences<_$AppDatabase,
    $TalhoesSafraTable, TalhoesSafraData> {
  $$TalhoesSafraTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlanosTable _planoIdTable(_$AppDatabase db) => db.planos.createAlias(
      $_aliasNameGenerator(db.talhoesSafra.planoId, db.planos.uid));

  $$PlanosTableProcessedTableManager get planoId {
    final $_column = $_itemColumn<String>('plano_id')!;

    final manager = $$PlanosTableTableManager($_db, $_db.planos)
        .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TalhoesTable _talhaoIdTable(_$AppDatabase db) =>
      db.talhoes.createAlias(
          $_aliasNameGenerator(db.talhoesSafra.talhaoId, db.talhoes.uid));

  $$TalhoesTableProcessedTableManager get talhaoId {
    final $_column = $_itemColumn<String>('talhao_id')!;

    final manager = $$TalhoesTableTableManager($_db, $_db.talhoes)
        .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_talhaoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TalhoesSafraTableFilterComposer
    extends Composer<_$AppDatabase, $TalhoesSafraTable> {
  $$TalhoesSafraTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cultura => $composableBuilder(
      column: $table.cultura, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get materialCultivar => $composableBuilder(
      column: $table.materialCultivar,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataPlantio => $composableBuilder(
      column: $table.dataPlantio, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diasEmergencia => $composableBuilder(
      column: $table.diasEmergencia,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get daePosEmergente => $composableBuilder(
      column: $table.daePosEmergente,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diasRecuperacaoPosEmergente => $composableBuilder(
      column: $table.diasRecuperacaoPosEmergente,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get intervaloFungicidaDias => $composableBuilder(
      column: $table.intervaloFungicidaDias,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalAplicacoesFungicida => $composableBuilder(
      column: $table.totalAplicacoesFungicida,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get daeMaturacaoCiclo => $composableBuilder(
      column: $table.daeMaturacaoCiclo,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diasAntesR8Dessecante => $composableBuilder(
      column: $table.diasAntesR8Dessecante,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diasAntecipacaoColheitaReal => $composableBuilder(
      column: $table.diasAntecipacaoColheitaReal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diasDessecacaoPrePlantio => $composableBuilder(
      column: $table.diasDessecacaoPrePlantio,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get grupoRegulagemId => $composableBuilder(
      column: $table.grupoRegulagemId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get plantioDefinido => $composableBuilder(
      column: $table.plantioDefinido,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordem => $composableBuilder(
      column: $table.ordem, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get programaOperacionalIds => $composableBuilder(
      column: $table.programaOperacionalIds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$PlanosTableFilterComposer get planoId {
    final $$PlanosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planoId,
        referencedTable: $db.planos,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanosTableFilterComposer(
              $db: $db,
              $table: $db.planos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TalhoesTableFilterComposer get talhaoId {
    final $$TalhoesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.talhaoId,
        referencedTable: $db.talhoes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesTableFilterComposer(
              $db: $db,
              $table: $db.talhoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TalhoesSafraTableOrderingComposer
    extends Composer<_$AppDatabase, $TalhoesSafraTable> {
  $$TalhoesSafraTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cultura => $composableBuilder(
      column: $table.cultura, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get materialCultivar => $composableBuilder(
      column: $table.materialCultivar,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataPlantio => $composableBuilder(
      column: $table.dataPlantio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diasEmergencia => $composableBuilder(
      column: $table.diasEmergencia,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get daePosEmergente => $composableBuilder(
      column: $table.daePosEmergente,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diasRecuperacaoPosEmergente => $composableBuilder(
      column: $table.diasRecuperacaoPosEmergente,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get intervaloFungicidaDias => $composableBuilder(
      column: $table.intervaloFungicidaDias,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalAplicacoesFungicida => $composableBuilder(
      column: $table.totalAplicacoesFungicida,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get daeMaturacaoCiclo => $composableBuilder(
      column: $table.daeMaturacaoCiclo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diasAntesR8Dessecante => $composableBuilder(
      column: $table.diasAntesR8Dessecante,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diasAntecipacaoColheitaReal => $composableBuilder(
      column: $table.diasAntecipacaoColheitaReal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diasDessecacaoPrePlantio => $composableBuilder(
      column: $table.diasDessecacaoPrePlantio,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get grupoRegulagemId => $composableBuilder(
      column: $table.grupoRegulagemId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get plantioDefinido => $composableBuilder(
      column: $table.plantioDefinido,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordem => $composableBuilder(
      column: $table.ordem, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get programaOperacionalIds => $composableBuilder(
      column: $table.programaOperacionalIds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$PlanosTableOrderingComposer get planoId {
    final $$PlanosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planoId,
        referencedTable: $db.planos,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanosTableOrderingComposer(
              $db: $db,
              $table: $db.planos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TalhoesTableOrderingComposer get talhaoId {
    final $$TalhoesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.talhaoId,
        referencedTable: $db.talhoes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesTableOrderingComposer(
              $db: $db,
              $table: $db.talhoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TalhoesSafraTableAnnotationComposer
    extends Composer<_$AppDatabase, $TalhoesSafraTable> {
  $$TalhoesSafraTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get cultura =>
      $composableBuilder(column: $table.cultura, builder: (column) => column);

  GeneratedColumn<String> get materialCultivar => $composableBuilder(
      column: $table.materialCultivar, builder: (column) => column);

  GeneratedColumn<DateTime> get dataPlantio => $composableBuilder(
      column: $table.dataPlantio, builder: (column) => column);

  GeneratedColumn<int> get diasEmergencia => $composableBuilder(
      column: $table.diasEmergencia, builder: (column) => column);

  GeneratedColumn<int> get daePosEmergente => $composableBuilder(
      column: $table.daePosEmergente, builder: (column) => column);

  GeneratedColumn<int> get diasRecuperacaoPosEmergente => $composableBuilder(
      column: $table.diasRecuperacaoPosEmergente, builder: (column) => column);

  GeneratedColumn<int> get intervaloFungicidaDias => $composableBuilder(
      column: $table.intervaloFungicidaDias, builder: (column) => column);

  GeneratedColumn<int> get totalAplicacoesFungicida => $composableBuilder(
      column: $table.totalAplicacoesFungicida, builder: (column) => column);

  GeneratedColumn<int> get daeMaturacaoCiclo => $composableBuilder(
      column: $table.daeMaturacaoCiclo, builder: (column) => column);

  GeneratedColumn<int> get diasAntesR8Dessecante => $composableBuilder(
      column: $table.diasAntesR8Dessecante, builder: (column) => column);

  GeneratedColumn<int> get diasAntecipacaoColheitaReal => $composableBuilder(
      column: $table.diasAntecipacaoColheitaReal, builder: (column) => column);

  GeneratedColumn<int> get diasDessecacaoPrePlantio => $composableBuilder(
      column: $table.diasDessecacaoPrePlantio, builder: (column) => column);

  GeneratedColumn<String> get grupoRegulagemId => $composableBuilder(
      column: $table.grupoRegulagemId, builder: (column) => column);

  GeneratedColumn<bool> get plantioDefinido => $composableBuilder(
      column: $table.plantioDefinido, builder: (column) => column);

  GeneratedColumn<int> get ordem =>
      $composableBuilder(column: $table.ordem, builder: (column) => column);

  GeneratedColumn<String> get programaOperacionalIds => $composableBuilder(
      column: $table.programaOperacionalIds, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$PlanosTableAnnotationComposer get planoId {
    final $$PlanosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planoId,
        referencedTable: $db.planos,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanosTableAnnotationComposer(
              $db: $db,
              $table: $db.planos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TalhoesTableAnnotationComposer get talhaoId {
    final $$TalhoesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.talhaoId,
        referencedTable: $db.talhoes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesTableAnnotationComposer(
              $db: $db,
              $table: $db.talhoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TalhoesSafraTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TalhoesSafraTable,
    TalhoesSafraData,
    $$TalhoesSafraTableFilterComposer,
    $$TalhoesSafraTableOrderingComposer,
    $$TalhoesSafraTableAnnotationComposer,
    $$TalhoesSafraTableCreateCompanionBuilder,
    $$TalhoesSafraTableUpdateCompanionBuilder,
    (TalhoesSafraData, $$TalhoesSafraTableReferences),
    TalhoesSafraData,
    PrefetchHooks Function({bool planoId, bool talhaoId})> {
  $$TalhoesSafraTableTableManager(_$AppDatabase db, $TalhoesSafraTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TalhoesSafraTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TalhoesSafraTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TalhoesSafraTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> planoId = const Value.absent(),
            Value<String> talhaoId = const Value.absent(),
            Value<String> cultura = const Value.absent(),
            Value<String> materialCultivar = const Value.absent(),
            Value<DateTime> dataPlantio = const Value.absent(),
            Value<int> diasEmergencia = const Value.absent(),
            Value<int> daePosEmergente = const Value.absent(),
            Value<int> diasRecuperacaoPosEmergente = const Value.absent(),
            Value<int> intervaloFungicidaDias = const Value.absent(),
            Value<int> totalAplicacoesFungicida = const Value.absent(),
            Value<int> daeMaturacaoCiclo = const Value.absent(),
            Value<int> diasAntesR8Dessecante = const Value.absent(),
            Value<int> diasAntecipacaoColheitaReal = const Value.absent(),
            Value<int> diasDessecacaoPrePlantio = const Value.absent(),
            Value<String> grupoRegulagemId = const Value.absent(),
            Value<bool> plantioDefinido = const Value.absent(),
            Value<int> ordem = const Value.absent(),
            Value<String> programaOperacionalIds = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TalhoesSafraCompanion(
            uid: uid,
            userId: userId,
            planoId: planoId,
            talhaoId: talhaoId,
            cultura: cultura,
            materialCultivar: materialCultivar,
            dataPlantio: dataPlantio,
            diasEmergencia: diasEmergencia,
            daePosEmergente: daePosEmergente,
            diasRecuperacaoPosEmergente: diasRecuperacaoPosEmergente,
            intervaloFungicidaDias: intervaloFungicidaDias,
            totalAplicacoesFungicida: totalAplicacoesFungicida,
            daeMaturacaoCiclo: daeMaturacaoCiclo,
            diasAntesR8Dessecante: diasAntesR8Dessecante,
            diasAntecipacaoColheitaReal: diasAntecipacaoColheitaReal,
            diasDessecacaoPrePlantio: diasDessecacaoPrePlantio,
            grupoRegulagemId: grupoRegulagemId,
            plantioDefinido: plantioDefinido,
            ordem: ordem,
            programaOperacionalIds: programaOperacionalIds,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            Value<String?> userId = const Value.absent(),
            required String planoId,
            required String talhaoId,
            required String cultura,
            Value<String> materialCultivar = const Value.absent(),
            required DateTime dataPlantio,
            Value<int> diasEmergencia = const Value.absent(),
            Value<int> daePosEmergente = const Value.absent(),
            Value<int> diasRecuperacaoPosEmergente = const Value.absent(),
            Value<int> intervaloFungicidaDias = const Value.absent(),
            Value<int> totalAplicacoesFungicida = const Value.absent(),
            Value<int> daeMaturacaoCiclo = const Value.absent(),
            Value<int> diasAntesR8Dessecante = const Value.absent(),
            Value<int> diasAntecipacaoColheitaReal = const Value.absent(),
            Value<int> diasDessecacaoPrePlantio = const Value.absent(),
            Value<String> grupoRegulagemId = const Value.absent(),
            Value<bool> plantioDefinido = const Value.absent(),
            Value<int> ordem = const Value.absent(),
            Value<String> programaOperacionalIds = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TalhoesSafraCompanion.insert(
            uid: uid,
            userId: userId,
            planoId: planoId,
            talhaoId: talhaoId,
            cultura: cultura,
            materialCultivar: materialCultivar,
            dataPlantio: dataPlantio,
            diasEmergencia: diasEmergencia,
            daePosEmergente: daePosEmergente,
            diasRecuperacaoPosEmergente: diasRecuperacaoPosEmergente,
            intervaloFungicidaDias: intervaloFungicidaDias,
            totalAplicacoesFungicida: totalAplicacoesFungicida,
            daeMaturacaoCiclo: daeMaturacaoCiclo,
            diasAntesR8Dessecante: diasAntesR8Dessecante,
            diasAntecipacaoColheitaReal: diasAntecipacaoColheitaReal,
            diasDessecacaoPrePlantio: diasDessecacaoPrePlantio,
            grupoRegulagemId: grupoRegulagemId,
            plantioDefinido: plantioDefinido,
            ordem: ordem,
            programaOperacionalIds: programaOperacionalIds,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TalhoesSafraTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({planoId = false, talhaoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (planoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.planoId,
                    referencedTable:
                        $$TalhoesSafraTableReferences._planoIdTable(db),
                    referencedColumn:
                        $$TalhoesSafraTableReferences._planoIdTable(db).uid,
                  ) as T;
                }
                if (talhaoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.talhaoId,
                    referencedTable:
                        $$TalhoesSafraTableReferences._talhaoIdTable(db),
                    referencedColumn:
                        $$TalhoesSafraTableReferences._talhaoIdTable(db).uid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TalhoesSafraTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TalhoesSafraTable,
    TalhoesSafraData,
    $$TalhoesSafraTableFilterComposer,
    $$TalhoesSafraTableOrderingComposer,
    $$TalhoesSafraTableAnnotationComposer,
    $$TalhoesSafraTableCreateCompanionBuilder,
    $$TalhoesSafraTableUpdateCompanionBuilder,
    (TalhoesSafraData, $$TalhoesSafraTableReferences),
    TalhoesSafraData,
    PrefetchHooks Function({bool planoId, bool talhaoId})>;
typedef $$ProgramasOperacionaisTableCreateCompanionBuilder
    = ProgramasOperacionaisCompanion Function({
  required String uid,
  Value<String?> userId,
  required String planoId,
  required String talhaoId,
  Value<String?> programaPaiId,
  required String tipo,
  required String regraCalculo,
  Value<String?> estadioId,
  Value<int?> aplicacaoIndice,
  Value<int> ordem,
  Value<bool> incluirAdubacao,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$ProgramasOperacionaisTableUpdateCompanionBuilder
    = ProgramasOperacionaisCompanion Function({
  Value<String> uid,
  Value<String?> userId,
  Value<String> planoId,
  Value<String> talhaoId,
  Value<String?> programaPaiId,
  Value<String> tipo,
  Value<String> regraCalculo,
  Value<String?> estadioId,
  Value<int?> aplicacaoIndice,
  Value<int> ordem,
  Value<bool> incluirAdubacao,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncState,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$ProgramasOperacionaisTableReferences extends BaseReferences<
    _$AppDatabase, $ProgramasOperacionaisTable, ProgramasOperacionai> {
  $$ProgramasOperacionaisTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PlanosTable _planoIdTable(_$AppDatabase db) => db.planos.createAlias(
      $_aliasNameGenerator(db.programasOperacionais.planoId, db.planos.uid));

  $$PlanosTableProcessedTableManager get planoId {
    final $_column = $_itemColumn<String>('plano_id')!;

    final manager = $$PlanosTableTableManager($_db, $_db.planos)
        .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TalhoesTable _talhaoIdTable(_$AppDatabase db) =>
      db.talhoes.createAlias($_aliasNameGenerator(
          db.programasOperacionais.talhaoId, db.talhoes.uid));

  $$TalhoesTableProcessedTableManager get talhaoId {
    final $_column = $_itemColumn<String>('talhao_id')!;

    final manager = $$TalhoesTableTableManager($_db, $_db.talhoes)
        .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_talhaoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $EstadiosTable _estadioIdTable(_$AppDatabase db) =>
      db.estadios.createAlias($_aliasNameGenerator(
          db.programasOperacionais.estadioId, db.estadios.uid));

  $$EstadiosTableProcessedTableManager? get estadioId {
    final $_column = $_itemColumn<String>('estadio_id');
    if ($_column == null) return null;
    final manager = $$EstadiosTableTableManager($_db, $_db.estadios)
        .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_estadioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ProgramasOperacionaisTableFilterComposer
    extends Composer<_$AppDatabase, $ProgramasOperacionaisTable> {
  $$ProgramasOperacionaisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get programaPaiId => $composableBuilder(
      column: $table.programaPaiId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get regraCalculo => $composableBuilder(
      column: $table.regraCalculo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get aplicacaoIndice => $composableBuilder(
      column: $table.aplicacaoIndice,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordem => $composableBuilder(
      column: $table.ordem, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get incluirAdubacao => $composableBuilder(
      column: $table.incluirAdubacao,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$PlanosTableFilterComposer get planoId {
    final $$PlanosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planoId,
        referencedTable: $db.planos,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanosTableFilterComposer(
              $db: $db,
              $table: $db.planos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TalhoesTableFilterComposer get talhaoId {
    final $$TalhoesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.talhaoId,
        referencedTable: $db.talhoes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesTableFilterComposer(
              $db: $db,
              $table: $db.talhoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EstadiosTableFilterComposer get estadioId {
    final $$EstadiosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.estadioId,
        referencedTable: $db.estadios,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EstadiosTableFilterComposer(
              $db: $db,
              $table: $db.estadios,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProgramasOperacionaisTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgramasOperacionaisTable> {
  $$ProgramasOperacionaisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get programaPaiId => $composableBuilder(
      column: $table.programaPaiId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get regraCalculo => $composableBuilder(
      column: $table.regraCalculo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get aplicacaoIndice => $composableBuilder(
      column: $table.aplicacaoIndice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordem => $composableBuilder(
      column: $table.ordem, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get incluirAdubacao => $composableBuilder(
      column: $table.incluirAdubacao,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$PlanosTableOrderingComposer get planoId {
    final $$PlanosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planoId,
        referencedTable: $db.planos,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanosTableOrderingComposer(
              $db: $db,
              $table: $db.planos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TalhoesTableOrderingComposer get talhaoId {
    final $$TalhoesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.talhaoId,
        referencedTable: $db.talhoes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesTableOrderingComposer(
              $db: $db,
              $table: $db.talhoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EstadiosTableOrderingComposer get estadioId {
    final $$EstadiosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.estadioId,
        referencedTable: $db.estadios,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EstadiosTableOrderingComposer(
              $db: $db,
              $table: $db.estadios,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProgramasOperacionaisTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgramasOperacionaisTable> {
  $$ProgramasOperacionaisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get programaPaiId => $composableBuilder(
      column: $table.programaPaiId, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get regraCalculo => $composableBuilder(
      column: $table.regraCalculo, builder: (column) => column);

  GeneratedColumn<int> get aplicacaoIndice => $composableBuilder(
      column: $table.aplicacaoIndice, builder: (column) => column);

  GeneratedColumn<int> get ordem =>
      $composableBuilder(column: $table.ordem, builder: (column) => column);

  GeneratedColumn<bool> get incluirAdubacao => $composableBuilder(
      column: $table.incluirAdubacao, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$PlanosTableAnnotationComposer get planoId {
    final $$PlanosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planoId,
        referencedTable: $db.planos,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanosTableAnnotationComposer(
              $db: $db,
              $table: $db.planos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TalhoesTableAnnotationComposer get talhaoId {
    final $$TalhoesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.talhaoId,
        referencedTable: $db.talhoes,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TalhoesTableAnnotationComposer(
              $db: $db,
              $table: $db.talhoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EstadiosTableAnnotationComposer get estadioId {
    final $$EstadiosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.estadioId,
        referencedTable: $db.estadios,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EstadiosTableAnnotationComposer(
              $db: $db,
              $table: $db.estadios,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProgramasOperacionaisTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProgramasOperacionaisTable,
    ProgramasOperacionai,
    $$ProgramasOperacionaisTableFilterComposer,
    $$ProgramasOperacionaisTableOrderingComposer,
    $$ProgramasOperacionaisTableAnnotationComposer,
    $$ProgramasOperacionaisTableCreateCompanionBuilder,
    $$ProgramasOperacionaisTableUpdateCompanionBuilder,
    (ProgramasOperacionai, $$ProgramasOperacionaisTableReferences),
    ProgramasOperacionai,
    PrefetchHooks Function({bool planoId, bool talhaoId, bool estadioId})> {
  $$ProgramasOperacionaisTableTableManager(
      _$AppDatabase db, $ProgramasOperacionaisTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgramasOperacionaisTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgramasOperacionaisTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgramasOperacionaisTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> planoId = const Value.absent(),
            Value<String> talhaoId = const Value.absent(),
            Value<String?> programaPaiId = const Value.absent(),
            Value<String> tipo = const Value.absent(),
            Value<String> regraCalculo = const Value.absent(),
            Value<String?> estadioId = const Value.absent(),
            Value<int?> aplicacaoIndice = const Value.absent(),
            Value<int> ordem = const Value.absent(),
            Value<bool> incluirAdubacao = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProgramasOperacionaisCompanion(
            uid: uid,
            userId: userId,
            planoId: planoId,
            talhaoId: talhaoId,
            programaPaiId: programaPaiId,
            tipo: tipo,
            regraCalculo: regraCalculo,
            estadioId: estadioId,
            aplicacaoIndice: aplicacaoIndice,
            ordem: ordem,
            incluirAdubacao: incluirAdubacao,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            Value<String?> userId = const Value.absent(),
            required String planoId,
            required String talhaoId,
            Value<String?> programaPaiId = const Value.absent(),
            required String tipo,
            required String regraCalculo,
            Value<String?> estadioId = const Value.absent(),
            Value<int?> aplicacaoIndice = const Value.absent(),
            Value<int> ordem = const Value.absent(),
            Value<bool> incluirAdubacao = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String> syncState = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProgramasOperacionaisCompanion.insert(
            uid: uid,
            userId: userId,
            planoId: planoId,
            talhaoId: talhaoId,
            programaPaiId: programaPaiId,
            tipo: tipo,
            regraCalculo: regraCalculo,
            estadioId: estadioId,
            aplicacaoIndice: aplicacaoIndice,
            ordem: ordem,
            incluirAdubacao: incluirAdubacao,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ProgramasOperacionaisTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {planoId = false, talhaoId = false, estadioId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (planoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.planoId,
                    referencedTable: $$ProgramasOperacionaisTableReferences
                        ._planoIdTable(db),
                    referencedColumn: $$ProgramasOperacionaisTableReferences
                        ._planoIdTable(db)
                        .uid,
                  ) as T;
                }
                if (talhaoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.talhaoId,
                    referencedTable: $$ProgramasOperacionaisTableReferences
                        ._talhaoIdTable(db),
                    referencedColumn: $$ProgramasOperacionaisTableReferences
                        ._talhaoIdTable(db)
                        .uid,
                  ) as T;
                }
                if (estadioId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.estadioId,
                    referencedTable: $$ProgramasOperacionaisTableReferences
                        ._estadioIdTable(db),
                    referencedColumn: $$ProgramasOperacionaisTableReferences
                        ._estadioIdTable(db)
                        .uid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ProgramasOperacionaisTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ProgramasOperacionaisTable,
        ProgramasOperacionai,
        $$ProgramasOperacionaisTableFilterComposer,
        $$ProgramasOperacionaisTableOrderingComposer,
        $$ProgramasOperacionaisTableAnnotationComposer,
        $$ProgramasOperacionaisTableCreateCompanionBuilder,
        $$ProgramasOperacionaisTableUpdateCompanionBuilder,
        (ProgramasOperacionai, $$ProgramasOperacionaisTableReferences),
        ProgramasOperacionai,
        PrefetchHooks Function({bool planoId, bool talhaoId, bool estadioId})>;
typedef $$LocalMetadataTableCreateCompanionBuilder = LocalMetadataCompanion
    Function({
  required String key,
  required String value,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$LocalMetadataTableUpdateCompanionBuilder = LocalMetadataCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$LocalMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $LocalMetadataTable> {
  $$LocalMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalMetadataTable> {
  $$LocalMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocalMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalMetadataTable> {
  $$LocalMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalMetadataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalMetadataTable,
    LocalMetadataData,
    $$LocalMetadataTableFilterComposer,
    $$LocalMetadataTableOrderingComposer,
    $$LocalMetadataTableAnnotationComposer,
    $$LocalMetadataTableCreateCompanionBuilder,
    $$LocalMetadataTableUpdateCompanionBuilder,
    (
      LocalMetadataData,
      BaseReferences<_$AppDatabase, $LocalMetadataTable, LocalMetadataData>
    ),
    LocalMetadataData,
    PrefetchHooks Function()> {
  $$LocalMetadataTableTableManager(_$AppDatabase db, $LocalMetadataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalMetadataCompanion(
            key: key,
            value: value,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalMetadataCompanion.insert(
            key: key,
            value: value,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalMetadataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalMetadataTable,
    LocalMetadataData,
    $$LocalMetadataTableFilterComposer,
    $$LocalMetadataTableOrderingComposer,
    $$LocalMetadataTableAnnotationComposer,
    $$LocalMetadataTableCreateCompanionBuilder,
    $$LocalMetadataTableUpdateCompanionBuilder,
    (
      LocalMetadataData,
      BaseReferences<_$AppDatabase, $LocalMetadataTable, LocalMetadataData>
    ),
    LocalMetadataData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalUsersTableTableManager get localUsers =>
      $$LocalUsersTableTableManager(_db, _db.localUsers);
  $$ClientesTableTableManager get clientes =>
      $$ClientesTableTableManager(_db, _db.clientes);
  $$FazendasTableTableManager get fazendas =>
      $$FazendasTableTableManager(_db, _db.fazendas);
  $$TalhoesTableTableManager get talhoes =>
      $$TalhoesTableTableManager(_db, _db.talhoes);
  $$CatalogoProdutosTableTableManager get catalogoProdutos =>
      $$CatalogoProdutosTableTableManager(_db, _db.catalogoProdutos);
  $$ReferenciasTecnicasTableTableManager get referenciasTecnicas =>
      $$ReferenciasTecnicasTableTableManager(_db, _db.referenciasTecnicas);
  $$PlanosTableTableManager get planos =>
      $$PlanosTableTableManager(_db, _db.planos);
  $$EstadiosTableTableManager get estadios =>
      $$EstadiosTableTableManager(_db, _db.estadios);
  $$ProdutosAplicacaoTableTableManager get produtosAplicacao =>
      $$ProdutosAplicacaoTableTableManager(_db, _db.produtosAplicacao);
  $$EscoposAlocacaoTableTableManager get escoposAlocacao =>
      $$EscoposAlocacaoTableTableManager(_db, _db.escoposAlocacao);
  $$AlocacoesTalhaoTableTableManager get alocacoesTalhao =>
      $$AlocacoesTalhaoTableTableManager(_db, _db.alocacoesTalhao);
  $$SementesTalhaoTableTableManager get sementesTalhao =>
      $$SementesTalhaoTableTableManager(_db, _db.sementesTalhao);
  $$CronogramasSojaTalhaoTableTableManager get cronogramasSojaTalhao =>
      $$CronogramasSojaTalhaoTableTableManager(_db, _db.cronogramasSojaTalhao);
  $$TalhoesSafraTableTableManager get talhoesSafra =>
      $$TalhoesSafraTableTableManager(_db, _db.talhoesSafra);
  $$ProgramasOperacionaisTableTableManager get programasOperacionais =>
      $$ProgramasOperacionaisTableTableManager(_db, _db.programasOperacionais);
  $$LocalMetadataTableTableManager get localMetadata =>
      $$LocalMetadataTableTableManager(_db, _db.localMetadata);
}
