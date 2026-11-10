// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarm_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AlarmState {

 List<Alarm> get alarms;
/// Create a copy of AlarmState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlarmStateCopyWith<AlarmState> get copyWith => _$AlarmStateCopyWithImpl<AlarmState>(this as AlarmState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AlarmState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlarmState&&const DeepCollectionEquality().equals(other.alarms, _this.alarms));
}


@override
int get hashCode {
  final _this = this as AlarmState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.alarms));
}

@override
String toString() {
  final _this = this as AlarmState;
  return 'AlarmState(alarms: ${_this.alarms})';
}


}

/// @nodoc
abstract mixin class $AlarmStateCopyWith<$Res>  {
  factory $AlarmStateCopyWith(AlarmState value, $Res Function(AlarmState) _then) = _$AlarmStateCopyWithImpl;
@useResult
$Res call({
 List<Alarm> alarms
});




}
/// @nodoc
class _$AlarmStateCopyWithImpl<$Res>
    implements $AlarmStateCopyWith<$Res> {
  _$AlarmStateCopyWithImpl(this._self, this._then);

  final AlarmState _self;
  final $Res Function(AlarmState) _then;

/// Create a copy of AlarmState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? alarms = null,}) {
  return _then(AlarmState(
alarms: null == alarms ? _self.alarms : alarms // ignore: cast_nullable_to_non_nullable
as List<Alarm>,
  ));
}

}


/// Adds pattern-matching-related methods to [AlarmState].
extension AlarmStatePatterns on AlarmState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlarmState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlarmState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlarmState value)  $default,){
final _that = this;
switch (_that) {
case _AlarmState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlarmState value)?  $default,){
final _that = this;
switch (_that) {
case _AlarmState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Alarm> alarms)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlarmState() when $default != null:
return $default(_that.alarms);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Alarm> alarms)  $default,) {final _that = this;
switch (_that) {
case _AlarmState():
return $default(_that.alarms);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Alarm> alarms)?  $default,) {final _that = this;
switch (_that) {
case _AlarmState() when $default != null:
return $default(_that.alarms);case _:
  return null;

}
}

}

/// @nodoc


class _AlarmState extends AlarmState {
  const _AlarmState({required  List<Alarm> alarms}): _alarms = alarms,super._();
  

 final  List<Alarm> _alarms;
@override List<Alarm> get alarms {
  if (_alarms is EqualUnmodifiableListView) return _alarms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_alarms);
}


/// Create a copy of AlarmState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlarmStateCopyWith<_AlarmState> get copyWith => __$AlarmStateCopyWithImpl<_AlarmState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlarmState&&const DeepCollectionEquality().equals(other.alarms, _alarms));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_alarms));
}

@override
String toString() {
    return 'AlarmState(alarms: $alarms)';
}


}

/// @nodoc
abstract mixin class _$AlarmStateCopyWith<$Res> implements $AlarmStateCopyWith<$Res> {
  factory _$AlarmStateCopyWith(_AlarmState value, $Res Function(_AlarmState) _then) = __$AlarmStateCopyWithImpl;
@override @useResult
$Res call({
 List<Alarm> alarms
});




}
/// @nodoc
class __$AlarmStateCopyWithImpl<$Res>
    implements _$AlarmStateCopyWith<$Res> {
  __$AlarmStateCopyWithImpl(this._self, this._then);

  final _AlarmState _self;
  final $Res Function(_AlarmState) _then;

/// Create a copy of AlarmState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? alarms = null,}) {
  return _then(_AlarmState(
alarms: null == alarms ? _self._alarms : alarms // ignore: cast_nullable_to_non_nullable
as List<Alarm>,
  ));
}


}

// dart format on
