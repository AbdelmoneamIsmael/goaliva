// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarm_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AlarmFormFieldErrors {

 String? get titleKey; String? get descriptionKey; String? get timeKey;
/// Create a copy of AlarmFormFieldErrors
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlarmFormFieldErrorsCopyWith<AlarmFormFieldErrors> get copyWith => _$AlarmFormFieldErrorsCopyWithImpl<AlarmFormFieldErrors>(this as AlarmFormFieldErrors, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AlarmFormFieldErrors;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlarmFormFieldErrors&&(identical(other.titleKey, _this.titleKey) || other.titleKey == _this.titleKey)&&(identical(other.descriptionKey, _this.descriptionKey) || other.descriptionKey == _this.descriptionKey)&&(identical(other.timeKey, _this.timeKey) || other.timeKey == _this.timeKey));
}


@override
int get hashCode {
  final _this = this as AlarmFormFieldErrors;
  return Object.hash(runtimeType,_this.titleKey,_this.descriptionKey,_this.timeKey);
}

@override
String toString() {
  final _this = this as AlarmFormFieldErrors;
  return 'AlarmFormFieldErrors(titleKey: ${_this.titleKey}, descriptionKey: ${_this.descriptionKey}, timeKey: ${_this.timeKey})';
}


}

/// @nodoc
abstract mixin class $AlarmFormFieldErrorsCopyWith<$Res>  {
  factory $AlarmFormFieldErrorsCopyWith(AlarmFormFieldErrors value, $Res Function(AlarmFormFieldErrors) _then) = _$AlarmFormFieldErrorsCopyWithImpl;
@useResult
$Res call({
 String? titleKey, String? descriptionKey, String? timeKey
});




}
/// @nodoc
class _$AlarmFormFieldErrorsCopyWithImpl<$Res>
    implements $AlarmFormFieldErrorsCopyWith<$Res> {
  _$AlarmFormFieldErrorsCopyWithImpl(this._self, this._then);

  final AlarmFormFieldErrors _self;
  final $Res Function(AlarmFormFieldErrors) _then;

/// Create a copy of AlarmFormFieldErrors
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? titleKey = freezed,Object? descriptionKey = freezed,Object? timeKey = freezed,}) {
  return _then(AlarmFormFieldErrors(
titleKey: freezed == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String?,descriptionKey: freezed == descriptionKey ? _self.descriptionKey : descriptionKey // ignore: cast_nullable_to_non_nullable
as String?,timeKey: freezed == timeKey ? _self.timeKey : timeKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AlarmFormFieldErrors].
extension AlarmFormFieldErrorsPatterns on AlarmFormFieldErrors {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlarmFormFieldErrors value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlarmFormFieldErrors() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlarmFormFieldErrors value)  $default,){
final _that = this;
switch (_that) {
case _AlarmFormFieldErrors():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlarmFormFieldErrors value)?  $default,){
final _that = this;
switch (_that) {
case _AlarmFormFieldErrors() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? titleKey,  String? descriptionKey,  String? timeKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlarmFormFieldErrors() when $default != null:
return $default(_that.titleKey,_that.descriptionKey,_that.timeKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? titleKey,  String? descriptionKey,  String? timeKey)  $default,) {final _that = this;
switch (_that) {
case _AlarmFormFieldErrors():
return $default(_that.titleKey,_that.descriptionKey,_that.timeKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? titleKey,  String? descriptionKey,  String? timeKey)?  $default,) {final _that = this;
switch (_that) {
case _AlarmFormFieldErrors() when $default != null:
return $default(_that.titleKey,_that.descriptionKey,_that.timeKey);case _:
  return null;

}
}

}

/// @nodoc


class _AlarmFormFieldErrors extends AlarmFormFieldErrors {
  const _AlarmFormFieldErrors({this.titleKey, this.descriptionKey, this.timeKey}): super._();
  

@override final  String? titleKey;
@override final  String? descriptionKey;
@override final  String? timeKey;

/// Create a copy of AlarmFormFieldErrors
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlarmFormFieldErrorsCopyWith<_AlarmFormFieldErrors> get copyWith => __$AlarmFormFieldErrorsCopyWithImpl<_AlarmFormFieldErrors>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlarmFormFieldErrors&&(identical(other.titleKey, titleKey) || other.titleKey == titleKey)&&(identical(other.descriptionKey, descriptionKey) || other.descriptionKey == descriptionKey)&&(identical(other.timeKey, timeKey) || other.timeKey == timeKey));
}


@override
int get hashCode {
    return Object.hash(runtimeType,titleKey,descriptionKey,timeKey);
}

@override
String toString() {
    return 'AlarmFormFieldErrors(titleKey: $titleKey, descriptionKey: $descriptionKey, timeKey: $timeKey)';
}


}

/// @nodoc
abstract mixin class _$AlarmFormFieldErrorsCopyWith<$Res> implements $AlarmFormFieldErrorsCopyWith<$Res> {
  factory _$AlarmFormFieldErrorsCopyWith(_AlarmFormFieldErrors value, $Res Function(_AlarmFormFieldErrors) _then) = __$AlarmFormFieldErrorsCopyWithImpl;
@override @useResult
$Res call({
 String? titleKey, String? descriptionKey, String? timeKey
});




}
/// @nodoc
class __$AlarmFormFieldErrorsCopyWithImpl<$Res>
    implements _$AlarmFormFieldErrorsCopyWith<$Res> {
  __$AlarmFormFieldErrorsCopyWithImpl(this._self, this._then);

  final _AlarmFormFieldErrors _self;
  final $Res Function(_AlarmFormFieldErrors) _then;

/// Create a copy of AlarmFormFieldErrors
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? titleKey = freezed,Object? descriptionKey = freezed,Object? timeKey = freezed,}) {
  return _then(_AlarmFormFieldErrors(
titleKey: freezed == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String?,descriptionKey: freezed == descriptionKey ? _self.descriptionKey : descriptionKey // ignore: cast_nullable_to_non_nullable
as String?,timeKey: freezed == timeKey ? _self.timeKey : timeKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$AlarmFormResult {

 int? get id; String get title; String get description; int get hour; int get minute; bool get repeats; int get year; int get month; int get day;
/// Create a copy of AlarmFormResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlarmFormResultCopyWith<AlarmFormResult> get copyWith => _$AlarmFormResultCopyWithImpl<AlarmFormResult>(this as AlarmFormResult, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AlarmFormResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlarmFormResult&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.hour, _this.hour) || other.hour == _this.hour)&&(identical(other.minute, _this.minute) || other.minute == _this.minute)&&(identical(other.repeats, _this.repeats) || other.repeats == _this.repeats)&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.day, _this.day) || other.day == _this.day));
}


@override
int get hashCode {
  final _this = this as AlarmFormResult;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,_this.hour,_this.minute,_this.repeats,_this.year,_this.month,_this.day);
}

@override
String toString() {
  final _this = this as AlarmFormResult;
  return 'AlarmFormResult(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, hour: ${_this.hour}, minute: ${_this.minute}, repeats: ${_this.repeats}, year: ${_this.year}, month: ${_this.month}, day: ${_this.day})';
}


}

/// @nodoc
abstract mixin class $AlarmFormResultCopyWith<$Res>  {
  factory $AlarmFormResultCopyWith(AlarmFormResult value, $Res Function(AlarmFormResult) _then) = _$AlarmFormResultCopyWithImpl;
@useResult
$Res call({
 int? id, String title, String description, int hour, int minute, bool repeats, int year, int month, int day
});




}
/// @nodoc
class _$AlarmFormResultCopyWithImpl<$Res>
    implements $AlarmFormResultCopyWith<$Res> {
  _$AlarmFormResultCopyWithImpl(this._self, this._then);

  final AlarmFormResult _self;
  final $Res Function(AlarmFormResult) _then;

/// Create a copy of AlarmFormResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = null,Object? description = null,Object? hour = null,Object? minute = null,Object? repeats = null,Object? year = null,Object? month = null,Object? day = null,}) {
  return _then(AlarmFormResult(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,repeats: null == repeats ? _self.repeats : repeats // ignore: cast_nullable_to_non_nullable
as bool,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AlarmFormResult].
extension AlarmFormResultPatterns on AlarmFormResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlarmFormResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlarmFormResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlarmFormResult value)  $default,){
final _that = this;
switch (_that) {
case _AlarmFormResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlarmFormResult value)?  $default,){
final _that = this;
switch (_that) {
case _AlarmFormResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String title,  String description,  int hour,  int minute,  bool repeats,  int year,  int month,  int day)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlarmFormResult() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.hour,_that.minute,_that.repeats,_that.year,_that.month,_that.day);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String title,  String description,  int hour,  int minute,  bool repeats,  int year,  int month,  int day)  $default,) {final _that = this;
switch (_that) {
case _AlarmFormResult():
return $default(_that.id,_that.title,_that.description,_that.hour,_that.minute,_that.repeats,_that.year,_that.month,_that.day);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String title,  String description,  int hour,  int minute,  bool repeats,  int year,  int month,  int day)?  $default,) {final _that = this;
switch (_that) {
case _AlarmFormResult() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.hour,_that.minute,_that.repeats,_that.year,_that.month,_that.day);case _:
  return null;

}
}

}

/// @nodoc


class _AlarmFormResult implements AlarmFormResult {
  const _AlarmFormResult({this.id, required this.title, required this.description, required this.hour, required this.minute, required this.repeats, required this.year, required this.month, required this.day});
  

@override final  int? id;
@override final  String title;
@override final  String description;
@override final  int hour;
@override final  int minute;
@override final  bool repeats;
@override final  int year;
@override final  int month;
@override final  int day;

/// Create a copy of AlarmFormResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlarmFormResultCopyWith<_AlarmFormResult> get copyWith => __$AlarmFormResultCopyWithImpl<_AlarmFormResult>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlarmFormResult&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.repeats, repeats) || other.repeats == repeats)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,hour,minute,repeats,year,month,day);
}

@override
String toString() {
    return 'AlarmFormResult(id: $id, title: $title, description: $description, hour: $hour, minute: $minute, repeats: $repeats, year: $year, month: $month, day: $day)';
}


}

/// @nodoc
abstract mixin class _$AlarmFormResultCopyWith<$Res> implements $AlarmFormResultCopyWith<$Res> {
  factory _$AlarmFormResultCopyWith(_AlarmFormResult value, $Res Function(_AlarmFormResult) _then) = __$AlarmFormResultCopyWithImpl;
@override @useResult
$Res call({
 int? id, String title, String description, int hour, int minute, bool repeats, int year, int month, int day
});




}
/// @nodoc
class __$AlarmFormResultCopyWithImpl<$Res>
    implements _$AlarmFormResultCopyWith<$Res> {
  __$AlarmFormResultCopyWithImpl(this._self, this._then);

  final _AlarmFormResult _self;
  final $Res Function(_AlarmFormResult) _then;

/// Create a copy of AlarmFormResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = null,Object? description = null,Object? hour = null,Object? minute = null,Object? repeats = null,Object? year = null,Object? month = null,Object? day = null,}) {
  return _then(_AlarmFormResult(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,repeats: null == repeats ? _self.repeats : repeats // ignore: cast_nullable_to_non_nullable
as bool,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$AlarmFormState {

 int? get id; String get title; String get description; int? get hour; int? get minute; int get year; int get month; int get day; bool get repeats; AlarmFormFieldErrors get fieldErrors;
/// Create a copy of AlarmFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlarmFormStateCopyWith<AlarmFormState> get copyWith => _$AlarmFormStateCopyWithImpl<AlarmFormState>(this as AlarmFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AlarmFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlarmFormState&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.hour, _this.hour) || other.hour == _this.hour)&&(identical(other.minute, _this.minute) || other.minute == _this.minute)&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.repeats, _this.repeats) || other.repeats == _this.repeats)&&(identical(other.fieldErrors, _this.fieldErrors) || other.fieldErrors == _this.fieldErrors));
}


@override
int get hashCode {
  final _this = this as AlarmFormState;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,_this.hour,_this.minute,_this.year,_this.month,_this.day,_this.repeats,_this.fieldErrors);
}

@override
String toString() {
  final _this = this as AlarmFormState;
  return 'AlarmFormState(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, hour: ${_this.hour}, minute: ${_this.minute}, year: ${_this.year}, month: ${_this.month}, day: ${_this.day}, repeats: ${_this.repeats}, fieldErrors: ${_this.fieldErrors})';
}


}

/// @nodoc
abstract mixin class $AlarmFormStateCopyWith<$Res>  {
  factory $AlarmFormStateCopyWith(AlarmFormState value, $Res Function(AlarmFormState) _then) = _$AlarmFormStateCopyWithImpl;
@useResult
$Res call({
 int? id, String title, String description, int? hour, int? minute, int year, int month, int day, bool repeats, AlarmFormFieldErrors fieldErrors
});


$AlarmFormFieldErrorsCopyWith<$Res> get fieldErrors;

}
/// @nodoc
class _$AlarmFormStateCopyWithImpl<$Res>
    implements $AlarmFormStateCopyWith<$Res> {
  _$AlarmFormStateCopyWithImpl(this._self, this._then);

  final AlarmFormState _self;
  final $Res Function(AlarmFormState) _then;

/// Create a copy of AlarmFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = null,Object? description = null,Object? hour = freezed,Object? minute = freezed,Object? year = null,Object? month = null,Object? day = null,Object? repeats = null,Object? fieldErrors = null,}) {
  return _then(AlarmFormState(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,hour: freezed == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int?,minute: freezed == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int?,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,repeats: null == repeats ? _self.repeats : repeats // ignore: cast_nullable_to_non_nullable
as bool,fieldErrors: null == fieldErrors ? _self.fieldErrors : fieldErrors // ignore: cast_nullable_to_non_nullable
as AlarmFormFieldErrors,
  ));
}
/// Create a copy of AlarmFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlarmFormFieldErrorsCopyWith<$Res> get fieldErrors {
  
  return $AlarmFormFieldErrorsCopyWith<$Res>(_self.fieldErrors, (value) {
    return _then(_self.copyWith(fieldErrors: value));
  });
}
}


/// Adds pattern-matching-related methods to [AlarmFormState].
extension AlarmFormStatePatterns on AlarmFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlarmFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlarmFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlarmFormState value)  $default,){
final _that = this;
switch (_that) {
case _AlarmFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlarmFormState value)?  $default,){
final _that = this;
switch (_that) {
case _AlarmFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String title,  String description,  int? hour,  int? minute,  int year,  int month,  int day,  bool repeats,  AlarmFormFieldErrors fieldErrors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlarmFormState() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.hour,_that.minute,_that.year,_that.month,_that.day,_that.repeats,_that.fieldErrors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String title,  String description,  int? hour,  int? minute,  int year,  int month,  int day,  bool repeats,  AlarmFormFieldErrors fieldErrors)  $default,) {final _that = this;
switch (_that) {
case _AlarmFormState():
return $default(_that.id,_that.title,_that.description,_that.hour,_that.minute,_that.year,_that.month,_that.day,_that.repeats,_that.fieldErrors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String title,  String description,  int? hour,  int? minute,  int year,  int month,  int day,  bool repeats,  AlarmFormFieldErrors fieldErrors)?  $default,) {final _that = this;
switch (_that) {
case _AlarmFormState() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.hour,_that.minute,_that.year,_that.month,_that.day,_that.repeats,_that.fieldErrors);case _:
  return null;

}
}

}

/// @nodoc


class _AlarmFormState extends AlarmFormState {
  const _AlarmFormState({this.id, this.title = '', this.description = '', this.hour, this.minute, required this.year, required this.month, required this.day, this.repeats = false, this.fieldErrors = const AlarmFormFieldErrors()}): super._();
  

@override final  int? id;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override final  int? hour;
@override final  int? minute;
@override final  int year;
@override final  int month;
@override final  int day;
@override@JsonKey() final  bool repeats;
@override@JsonKey() final  AlarmFormFieldErrors fieldErrors;

/// Create a copy of AlarmFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlarmFormStateCopyWith<_AlarmFormState> get copyWith => __$AlarmFormStateCopyWithImpl<_AlarmFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlarmFormState&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day)&&(identical(other.repeats, repeats) || other.repeats == repeats)&&(identical(other.fieldErrors, fieldErrors) || other.fieldErrors == fieldErrors));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,hour,minute,year,month,day,repeats,fieldErrors);
}

@override
String toString() {
    return 'AlarmFormState(id: $id, title: $title, description: $description, hour: $hour, minute: $minute, year: $year, month: $month, day: $day, repeats: $repeats, fieldErrors: $fieldErrors)';
}


}

/// @nodoc
abstract mixin class _$AlarmFormStateCopyWith<$Res> implements $AlarmFormStateCopyWith<$Res> {
  factory _$AlarmFormStateCopyWith(_AlarmFormState value, $Res Function(_AlarmFormState) _then) = __$AlarmFormStateCopyWithImpl;
@override @useResult
$Res call({
 int? id, String title, String description, int? hour, int? minute, int year, int month, int day, bool repeats, AlarmFormFieldErrors fieldErrors
});


@override $AlarmFormFieldErrorsCopyWith<$Res> get fieldErrors;

}
/// @nodoc
class __$AlarmFormStateCopyWithImpl<$Res>
    implements _$AlarmFormStateCopyWith<$Res> {
  __$AlarmFormStateCopyWithImpl(this._self, this._then);

  final _AlarmFormState _self;
  final $Res Function(_AlarmFormState) _then;

/// Create a copy of AlarmFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = null,Object? description = null,Object? hour = freezed,Object? minute = freezed,Object? year = null,Object? month = null,Object? day = null,Object? repeats = null,Object? fieldErrors = null,}) {
  return _then(_AlarmFormState(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,hour: freezed == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int?,minute: freezed == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int?,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,repeats: null == repeats ? _self.repeats : repeats // ignore: cast_nullable_to_non_nullable
as bool,fieldErrors: null == fieldErrors ? _self.fieldErrors : fieldErrors // ignore: cast_nullable_to_non_nullable
as AlarmFormFieldErrors,
  ));
}

/// Create a copy of AlarmFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlarmFormFieldErrorsCopyWith<$Res> get fieldErrors {
  
  return $AlarmFormFieldErrorsCopyWith<$Res>(_self.fieldErrors, (value) {
    return _then(_self.copyWith(fieldErrors: value));
  });
}
}

// dart format on
