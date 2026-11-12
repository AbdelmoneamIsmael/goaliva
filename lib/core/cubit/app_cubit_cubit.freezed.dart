// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_cubit_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppCubitState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AppCubitState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AppCubitState()';
}


}

/// @nodoc
class $AppCubitStateCopyWith<$Res>  {
$AppCubitStateCopyWith(AppCubitState _, $Res Function(AppCubitState) __);
}


/// Adds pattern-matching-related methods to [AppCubitState].
extension AppCubitStatePatterns on AppCubitState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _AlarmTriggered value)?  alarmTriggered,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _AlarmTriggered() when alarmTriggered != null:
return alarmTriggered(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _AlarmTriggered value)  alarmTriggered,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _AlarmTriggered():
return alarmTriggered(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _AlarmTriggered value)?  alarmTriggered,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _AlarmTriggered() when alarmTriggered != null:
return alarmTriggered(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( int alarmId)?  alarmTriggered,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _AlarmTriggered() when alarmTriggered != null:
return alarmTriggered(_that.alarmId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( int alarmId)  alarmTriggered,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _AlarmTriggered():
return alarmTriggered(_that.alarmId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( int alarmId)?  alarmTriggered,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _AlarmTriggered() when alarmTriggered != null:
return alarmTriggered(_that.alarmId);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AppCubitState {
  const _Initial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AppCubitState.initial()';
}


}




/// @nodoc


class _AlarmTriggered implements AppCubitState {
  const _AlarmTriggered(this.alarmId);
  

 final  int alarmId;

/// Create a copy of AppCubitState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlarmTriggeredCopyWith<_AlarmTriggered> get copyWith => __$AlarmTriggeredCopyWithImpl<_AlarmTriggered>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlarmTriggered&&(identical(other.alarmId, alarmId) || other.alarmId == alarmId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,alarmId);
}

@override
String toString() {
    return 'AppCubitState.alarmTriggered(alarmId: $alarmId)';
}


}

/// @nodoc
abstract mixin class _$AlarmTriggeredCopyWith<$Res> implements $AppCubitStateCopyWith<$Res> {
  factory _$AlarmTriggeredCopyWith(_AlarmTriggered value, $Res Function(_AlarmTriggered) _then) = __$AlarmTriggeredCopyWithImpl;
@useResult
$Res call({
 int alarmId
});




}
/// @nodoc
class __$AlarmTriggeredCopyWithImpl<$Res>
    implements _$AlarmTriggeredCopyWith<$Res> {
  __$AlarmTriggeredCopyWithImpl(this._self, this._then);

  final _AlarmTriggered _self;
  final $Res Function(_AlarmTriggered) _then;

/// Create a copy of AppCubitState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? alarmId = null,}) {
  return _then(_AlarmTriggered(
null == alarmId ? _self.alarmId : alarmId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
