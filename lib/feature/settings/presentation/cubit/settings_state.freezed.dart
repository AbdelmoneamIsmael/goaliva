// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsState {

 bool get remindersEnabled; bool get dailySparkEnabled; bool get goalCheckInsEnabled; bool get soundEnabled;
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsStateCopyWith<SettingsState> get copyWith => _$SettingsStateCopyWithImpl<SettingsState>(this as SettingsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SettingsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState&&(identical(other.remindersEnabled, _this.remindersEnabled) || other.remindersEnabled == _this.remindersEnabled)&&(identical(other.dailySparkEnabled, _this.dailySparkEnabled) || other.dailySparkEnabled == _this.dailySparkEnabled)&&(identical(other.goalCheckInsEnabled, _this.goalCheckInsEnabled) || other.goalCheckInsEnabled == _this.goalCheckInsEnabled)&&(identical(other.soundEnabled, _this.soundEnabled) || other.soundEnabled == _this.soundEnabled));
}


@override
int get hashCode {
  final _this = this as SettingsState;
  return Object.hash(runtimeType,_this.remindersEnabled,_this.dailySparkEnabled,_this.goalCheckInsEnabled,_this.soundEnabled);
}

@override
String toString() {
  final _this = this as SettingsState;
  return 'SettingsState(remindersEnabled: ${_this.remindersEnabled}, dailySparkEnabled: ${_this.dailySparkEnabled}, goalCheckInsEnabled: ${_this.goalCheckInsEnabled}, soundEnabled: ${_this.soundEnabled})';
}


}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res>  {
  factory $SettingsStateCopyWith(SettingsState value, $Res Function(SettingsState) _then) = _$SettingsStateCopyWithImpl;
@useResult
$Res call({
 bool remindersEnabled, bool dailySparkEnabled, bool goalCheckInsEnabled, bool soundEnabled
});




}
/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? remindersEnabled = null,Object? dailySparkEnabled = null,Object? goalCheckInsEnabled = null,Object? soundEnabled = null,}) {
  return _then(SettingsState(
remindersEnabled: null == remindersEnabled ? _self.remindersEnabled : remindersEnabled // ignore: cast_nullable_to_non_nullable
as bool,dailySparkEnabled: null == dailySparkEnabled ? _self.dailySparkEnabled : dailySparkEnabled // ignore: cast_nullable_to_non_nullable
as bool,goalCheckInsEnabled: null == goalCheckInsEnabled ? _self.goalCheckInsEnabled : goalCheckInsEnabled // ignore: cast_nullable_to_non_nullable
as bool,soundEnabled: null == soundEnabled ? _self.soundEnabled : soundEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsState value)  $default,){
final _that = this;
switch (_that) {
case _SettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool remindersEnabled,  bool dailySparkEnabled,  bool goalCheckInsEnabled,  bool soundEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.remindersEnabled,_that.dailySparkEnabled,_that.goalCheckInsEnabled,_that.soundEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool remindersEnabled,  bool dailySparkEnabled,  bool goalCheckInsEnabled,  bool soundEnabled)  $default,) {final _that = this;
switch (_that) {
case _SettingsState():
return $default(_that.remindersEnabled,_that.dailySparkEnabled,_that.goalCheckInsEnabled,_that.soundEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool remindersEnabled,  bool dailySparkEnabled,  bool goalCheckInsEnabled,  bool soundEnabled)?  $default,) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.remindersEnabled,_that.dailySparkEnabled,_that.goalCheckInsEnabled,_that.soundEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsState implements SettingsState {
  const _SettingsState({this.remindersEnabled = true, this.dailySparkEnabled = true, this.goalCheckInsEnabled = false, this.soundEnabled = true});
  

@override@JsonKey() final  bool remindersEnabled;
@override@JsonKey() final  bool dailySparkEnabled;
@override@JsonKey() final  bool goalCheckInsEnabled;
@override@JsonKey() final  bool soundEnabled;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsStateCopyWith<_SettingsState> get copyWith => __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsState&&(identical(other.remindersEnabled, remindersEnabled) || other.remindersEnabled == remindersEnabled)&&(identical(other.dailySparkEnabled, dailySparkEnabled) || other.dailySparkEnabled == dailySparkEnabled)&&(identical(other.goalCheckInsEnabled, goalCheckInsEnabled) || other.goalCheckInsEnabled == goalCheckInsEnabled)&&(identical(other.soundEnabled, soundEnabled) || other.soundEnabled == soundEnabled));
}


@override
int get hashCode {
    return Object.hash(runtimeType,remindersEnabled,dailySparkEnabled,goalCheckInsEnabled,soundEnabled);
}

@override
String toString() {
    return 'SettingsState(remindersEnabled: $remindersEnabled, dailySparkEnabled: $dailySparkEnabled, goalCheckInsEnabled: $goalCheckInsEnabled, soundEnabled: $soundEnabled)';
}


}

/// @nodoc
abstract mixin class _$SettingsStateCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(_SettingsState value, $Res Function(_SettingsState) _then) = __$SettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool remindersEnabled, bool dailySparkEnabled, bool goalCheckInsEnabled, bool soundEnabled
});




}
/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(this._self, this._then);

  final _SettingsState _self;
  final $Res Function(_SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? remindersEnabled = null,Object? dailySparkEnabled = null,Object? goalCheckInsEnabled = null,Object? soundEnabled = null,}) {
  return _then(_SettingsState(
remindersEnabled: null == remindersEnabled ? _self.remindersEnabled : remindersEnabled // ignore: cast_nullable_to_non_nullable
as bool,dailySparkEnabled: null == dailySparkEnabled ? _self.dailySparkEnabled : dailySparkEnabled // ignore: cast_nullable_to_non_nullable
as bool,goalCheckInsEnabled: null == goalCheckInsEnabled ? _self.goalCheckInsEnabled : goalCheckInsEnabled // ignore: cast_nullable_to_non_nullable
as bool,soundEnabled: null == soundEnabled ? _self.soundEnabled : soundEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
