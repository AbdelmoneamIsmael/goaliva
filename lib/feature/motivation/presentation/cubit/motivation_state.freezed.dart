// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'motivation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MotivationState {

 List<MotivationTopic> get topics;
/// Create a copy of MotivationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MotivationStateCopyWith<MotivationState> get copyWith => _$MotivationStateCopyWithImpl<MotivationState>(this as MotivationState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MotivationState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MotivationState&&const DeepCollectionEquality().equals(other.topics, _this.topics));
}


@override
int get hashCode {
  final _this = this as MotivationState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.topics));
}

@override
String toString() {
  final _this = this as MotivationState;
  return 'MotivationState(topics: ${_this.topics})';
}


}

/// @nodoc
abstract mixin class $MotivationStateCopyWith<$Res>  {
  factory $MotivationStateCopyWith(MotivationState value, $Res Function(MotivationState) _then) = _$MotivationStateCopyWithImpl;
@useResult
$Res call({
 List<MotivationTopic> topics
});




}
/// @nodoc
class _$MotivationStateCopyWithImpl<$Res>
    implements $MotivationStateCopyWith<$Res> {
  _$MotivationStateCopyWithImpl(this._self, this._then);

  final MotivationState _self;
  final $Res Function(MotivationState) _then;

/// Create a copy of MotivationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topics = null,}) {
  return _then(MotivationState(
topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<MotivationTopic>,
  ));
}

}


/// Adds pattern-matching-related methods to [MotivationState].
extension MotivationStatePatterns on MotivationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MotivationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MotivationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MotivationState value)  $default,){
final _that = this;
switch (_that) {
case _MotivationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MotivationState value)?  $default,){
final _that = this;
switch (_that) {
case _MotivationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MotivationTopic> topics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MotivationState() when $default != null:
return $default(_that.topics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MotivationTopic> topics)  $default,) {final _that = this;
switch (_that) {
case _MotivationState():
return $default(_that.topics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MotivationTopic> topics)?  $default,) {final _that = this;
switch (_that) {
case _MotivationState() when $default != null:
return $default(_that.topics);case _:
  return null;

}
}

}

/// @nodoc


class _MotivationState extends MotivationState {
  const _MotivationState({required  List<MotivationTopic> topics}): _topics = topics,super._();
  

 final  List<MotivationTopic> _topics;
@override List<MotivationTopic> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}


/// Create a copy of MotivationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MotivationStateCopyWith<_MotivationState> get copyWith => __$MotivationStateCopyWithImpl<_MotivationState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MotivationState&&const DeepCollectionEquality().equals(other.topics, _topics));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_topics));
}

@override
String toString() {
    return 'MotivationState(topics: $topics)';
}


}

/// @nodoc
abstract mixin class _$MotivationStateCopyWith<$Res> implements $MotivationStateCopyWith<$Res> {
  factory _$MotivationStateCopyWith(_MotivationState value, $Res Function(_MotivationState) _then) = __$MotivationStateCopyWithImpl;
@override @useResult
$Res call({
 List<MotivationTopic> topics
});




}
/// @nodoc
class __$MotivationStateCopyWithImpl<$Res>
    implements _$MotivationStateCopyWith<$Res> {
  __$MotivationStateCopyWithImpl(this._self, this._then);

  final _MotivationState _self;
  final $Res Function(_MotivationState) _then;

/// Create a copy of MotivationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topics = null,}) {
  return _then(_MotivationState(
topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<MotivationTopic>,
  ));
}


}

// dart format on
