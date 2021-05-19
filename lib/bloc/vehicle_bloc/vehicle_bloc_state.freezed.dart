// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'vehicle_bloc_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$VehicleStateBlocTearOff {
  const _$VehicleStateBlocTearOff();

  VehicleStateInitial initial() {
    return const VehicleStateInitial();
  }

  VehicleStateLoad load() {
    return const VehicleStateLoad();
  }

  VehicleStateLoaded loaded({required VehicleState vehicleState}) {
    return VehicleStateLoaded(
      vehicleState: vehicleState,
    );
  }

  VehicleStateFailed failed({required String error}) {
    return VehicleStateFailed(
      error: error,
    );
  }
}

/// @nodoc
const $VehicleStateBloc = _$VehicleStateBlocTearOff();

/// @nodoc
mixin _$VehicleStateBloc {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(VehicleState vehicleState) loaded,
    required TResult Function(String error) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(VehicleState vehicleState)? loaded,
    TResult Function(String error)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VehicleStateInitial value) initial,
    required TResult Function(VehicleStateLoad value) load,
    required TResult Function(VehicleStateLoaded value) loaded,
    required TResult Function(VehicleStateFailed value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VehicleStateInitial value)? initial,
    TResult Function(VehicleStateLoad value)? load,
    TResult Function(VehicleStateLoaded value)? loaded,
    TResult Function(VehicleStateFailed value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleStateBlocCopyWith<$Res> {
  factory $VehicleStateBlocCopyWith(
          VehicleStateBloc value, $Res Function(VehicleStateBloc) then) =
      _$VehicleStateBlocCopyWithImpl<$Res>;
}

/// @nodoc
class _$VehicleStateBlocCopyWithImpl<$Res>
    implements $VehicleStateBlocCopyWith<$Res> {
  _$VehicleStateBlocCopyWithImpl(this._value, this._then);

  final VehicleStateBloc _value;
  // ignore: unused_field
  final $Res Function(VehicleStateBloc) _then;
}

/// @nodoc
abstract class $VehicleStateInitialCopyWith<$Res> {
  factory $VehicleStateInitialCopyWith(
          VehicleStateInitial value, $Res Function(VehicleStateInitial) then) =
      _$VehicleStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$VehicleStateInitialCopyWithImpl<$Res>
    extends _$VehicleStateBlocCopyWithImpl<$Res>
    implements $VehicleStateInitialCopyWith<$Res> {
  _$VehicleStateInitialCopyWithImpl(
      VehicleStateInitial _value, $Res Function(VehicleStateInitial) _then)
      : super(_value, (v) => _then(v as VehicleStateInitial));

  @override
  VehicleStateInitial get _value => super._value as VehicleStateInitial;
}

/// @nodoc

class _$VehicleStateInitial implements VehicleStateInitial {
  const _$VehicleStateInitial();

  @override
  String toString() {
    return 'VehicleStateBloc.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is VehicleStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(VehicleState vehicleState) loaded,
    required TResult Function(String error) failed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(VehicleState vehicleState)? loaded,
    TResult Function(String error)? failed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VehicleStateInitial value) initial,
    required TResult Function(VehicleStateLoad value) load,
    required TResult Function(VehicleStateLoaded value) loaded,
    required TResult Function(VehicleStateFailed value) failed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VehicleStateInitial value)? initial,
    TResult Function(VehicleStateLoad value)? load,
    TResult Function(VehicleStateLoaded value)? loaded,
    TResult Function(VehicleStateFailed value)? failed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class VehicleStateInitial implements VehicleStateBloc {
  const factory VehicleStateInitial() = _$VehicleStateInitial;
}

/// @nodoc
abstract class $VehicleStateLoadCopyWith<$Res> {
  factory $VehicleStateLoadCopyWith(
          VehicleStateLoad value, $Res Function(VehicleStateLoad) then) =
      _$VehicleStateLoadCopyWithImpl<$Res>;
}

/// @nodoc
class _$VehicleStateLoadCopyWithImpl<$Res>
    extends _$VehicleStateBlocCopyWithImpl<$Res>
    implements $VehicleStateLoadCopyWith<$Res> {
  _$VehicleStateLoadCopyWithImpl(
      VehicleStateLoad _value, $Res Function(VehicleStateLoad) _then)
      : super(_value, (v) => _then(v as VehicleStateLoad));

  @override
  VehicleStateLoad get _value => super._value as VehicleStateLoad;
}

/// @nodoc

class _$VehicleStateLoad implements VehicleStateLoad {
  const _$VehicleStateLoad();

  @override
  String toString() {
    return 'VehicleStateBloc.load()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is VehicleStateLoad);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(VehicleState vehicleState) loaded,
    required TResult Function(String error) failed,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(VehicleState vehicleState)? loaded,
    TResult Function(String error)? failed,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VehicleStateInitial value) initial,
    required TResult Function(VehicleStateLoad value) load,
    required TResult Function(VehicleStateLoaded value) loaded,
    required TResult Function(VehicleStateFailed value) failed,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VehicleStateInitial value)? initial,
    TResult Function(VehicleStateLoad value)? load,
    TResult Function(VehicleStateLoaded value)? loaded,
    TResult Function(VehicleStateFailed value)? failed,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class VehicleStateLoad implements VehicleStateBloc {
  const factory VehicleStateLoad() = _$VehicleStateLoad;
}

/// @nodoc
abstract class $VehicleStateLoadedCopyWith<$Res> {
  factory $VehicleStateLoadedCopyWith(
          VehicleStateLoaded value, $Res Function(VehicleStateLoaded) then) =
      _$VehicleStateLoadedCopyWithImpl<$Res>;
  $Res call({VehicleState vehicleState});
}

/// @nodoc
class _$VehicleStateLoadedCopyWithImpl<$Res>
    extends _$VehicleStateBlocCopyWithImpl<$Res>
    implements $VehicleStateLoadedCopyWith<$Res> {
  _$VehicleStateLoadedCopyWithImpl(
      VehicleStateLoaded _value, $Res Function(VehicleStateLoaded) _then)
      : super(_value, (v) => _then(v as VehicleStateLoaded));

  @override
  VehicleStateLoaded get _value => super._value as VehicleStateLoaded;

  @override
  $Res call({
    Object? vehicleState = freezed,
  }) {
    return _then(VehicleStateLoaded(
      vehicleState: vehicleState == freezed
          ? _value.vehicleState
          : vehicleState // ignore: cast_nullable_to_non_nullable
              as VehicleState,
    ));
  }
}

/// @nodoc

class _$VehicleStateLoaded implements VehicleStateLoaded {
  const _$VehicleStateLoaded({required this.vehicleState});

  @override
  final VehicleState vehicleState;

  @override
  String toString() {
    return 'VehicleStateBloc.loaded(vehicleState: $vehicleState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is VehicleStateLoaded &&
            (identical(other.vehicleState, vehicleState) ||
                const DeepCollectionEquality()
                    .equals(other.vehicleState, vehicleState)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(vehicleState);

  @JsonKey(ignore: true)
  @override
  $VehicleStateLoadedCopyWith<VehicleStateLoaded> get copyWith =>
      _$VehicleStateLoadedCopyWithImpl<VehicleStateLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(VehicleState vehicleState) loaded,
    required TResult Function(String error) failed,
  }) {
    return loaded(vehicleState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(VehicleState vehicleState)? loaded,
    TResult Function(String error)? failed,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(vehicleState);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VehicleStateInitial value) initial,
    required TResult Function(VehicleStateLoad value) load,
    required TResult Function(VehicleStateLoaded value) loaded,
    required TResult Function(VehicleStateFailed value) failed,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VehicleStateInitial value)? initial,
    TResult Function(VehicleStateLoad value)? load,
    TResult Function(VehicleStateLoaded value)? loaded,
    TResult Function(VehicleStateFailed value)? failed,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class VehicleStateLoaded implements VehicleStateBloc {
  const factory VehicleStateLoaded({required VehicleState vehicleState}) =
      _$VehicleStateLoaded;

  VehicleState get vehicleState => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VehicleStateLoadedCopyWith<VehicleStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleStateFailedCopyWith<$Res> {
  factory $VehicleStateFailedCopyWith(
          VehicleStateFailed value, $Res Function(VehicleStateFailed) then) =
      _$VehicleStateFailedCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class _$VehicleStateFailedCopyWithImpl<$Res>
    extends _$VehicleStateBlocCopyWithImpl<$Res>
    implements $VehicleStateFailedCopyWith<$Res> {
  _$VehicleStateFailedCopyWithImpl(
      VehicleStateFailed _value, $Res Function(VehicleStateFailed) _then)
      : super(_value, (v) => _then(v as VehicleStateFailed));

  @override
  VehicleStateFailed get _value => super._value as VehicleStateFailed;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(VehicleStateFailed(
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VehicleStateFailed implements VehicleStateFailed {
  const _$VehicleStateFailed({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'VehicleStateBloc.failed(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is VehicleStateFailed &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  $VehicleStateFailedCopyWith<VehicleStateFailed> get copyWith =>
      _$VehicleStateFailedCopyWithImpl<VehicleStateFailed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(VehicleState vehicleState) loaded,
    required TResult Function(String error) failed,
  }) {
    return failed(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(VehicleState vehicleState)? loaded,
    TResult Function(String error)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VehicleStateInitial value) initial,
    required TResult Function(VehicleStateLoad value) load,
    required TResult Function(VehicleStateLoaded value) loaded,
    required TResult Function(VehicleStateFailed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VehicleStateInitial value)? initial,
    TResult Function(VehicleStateLoad value)? load,
    TResult Function(VehicleStateLoaded value)? loaded,
    TResult Function(VehicleStateFailed value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class VehicleStateFailed implements VehicleStateBloc {
  const factory VehicleStateFailed({required String error}) =
      _$VehicleStateFailed;

  String get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VehicleStateFailedCopyWith<VehicleStateFailed> get copyWith =>
      throw _privateConstructorUsedError;
}
