//
//  Generated code. Do not modify.
//  source: file.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class Message extends $pb.GeneratedMessage {
  factory Message({
    $core.int? vendor,
    $core.int? version,
    $core.int? seqnum,
    $core.int? uid,
    $core.int? flag,
    $fixnum.Int64? time,
    $core.int? lang,
    $core.int? starttime,
    $core.int? offtime,
    $core.Iterable<Word>? words,
  }) {
    final $result = create();
    if (vendor != null) {
      $result.vendor = vendor;
    }
    if (version != null) {
      $result.version = version;
    }
    if (seqnum != null) {
      $result.seqnum = seqnum;
    }
    if (uid != null) {
      $result.uid = uid;
    }
    if (flag != null) {
      $result.flag = flag;
    }
    if (time != null) {
      $result.time = time;
    }
    if (lang != null) {
      $result.lang = lang;
    }
    if (starttime != null) {
      $result.starttime = starttime;
    }
    if (offtime != null) {
      $result.offtime = offtime;
    }
    if (words != null) {
      $result.words.addAll(words);
    }
    return $result;
  }
  Message._() : super();
  factory Message.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Message', package: const $pb.PackageName(_omitMessageNames ? '' : 'call_summary'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'vendor', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'version', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'seqnum', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'uid', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'flag', $pb.PbFieldType.O3)
    ..aInt64(6, _omitFieldNames ? '' : 'time')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'lang', $pb.PbFieldType.O3)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'starttime', $pb.PbFieldType.O3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'offtime', $pb.PbFieldType.O3)
    ..pc<Word>(10, _omitFieldNames ? '' : 'words', $pb.PbFieldType.PM, subBuilder: Word.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Message clone() => Message()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Message copyWith(void Function(Message) updates) => super.copyWith((message) => updates(message as Message)) as Message;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Message create() => Message._();
  Message createEmptyInstance() => create();
  static $pb.PbList<Message> createRepeated() => $pb.PbList<Message>();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message>(create);
  static Message? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get vendor => $_getIZ(0);
  @$pb.TagNumber(1)
  set vendor($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVendor() => $_has(0);
  @$pb.TagNumber(1)
  void clearVendor() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get version => $_getIZ(1);
  @$pb.TagNumber(2)
  set version($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get seqnum => $_getIZ(2);
  @$pb.TagNumber(3)
  set seqnum($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSeqnum() => $_has(2);
  @$pb.TagNumber(3)
  void clearSeqnum() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get uid => $_getIZ(3);
  @$pb.TagNumber(4)
  set uid($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUid() => $_has(3);
  @$pb.TagNumber(4)
  void clearUid() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get flag => $_getIZ(4);
  @$pb.TagNumber(5)
  set flag($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFlag() => $_has(4);
  @$pb.TagNumber(5)
  void clearFlag() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get time => $_getI64(5);
  @$pb.TagNumber(6)
  set time($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearTime() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get lang => $_getIZ(6);
  @$pb.TagNumber(7)
  set lang($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLang() => $_has(6);
  @$pb.TagNumber(7)
  void clearLang() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get starttime => $_getIZ(7);
  @$pb.TagNumber(8)
  set starttime($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasStarttime() => $_has(7);
  @$pb.TagNumber(8)
  void clearStarttime() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get offtime => $_getIZ(8);
  @$pb.TagNumber(9)
  set offtime($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasOfftime() => $_has(8);
  @$pb.TagNumber(9)
  void clearOfftime() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<Word> get words => $_getList(9);
}

class Word extends $pb.GeneratedMessage {
  factory Word({
    $core.String? text,
    $core.int? startMs,
    $core.int? durationMs,
    $core.bool? isFinal,
    $core.double? confidence,
  }) {
    final $result = create();
    if (text != null) {
      $result.text = text;
    }
    if (startMs != null) {
      $result.startMs = startMs;
    }
    if (durationMs != null) {
      $result.durationMs = durationMs;
    }
    if (isFinal != null) {
      $result.isFinal = isFinal;
    }
    if (confidence != null) {
      $result.confidence = confidence;
    }
    return $result;
  }
  Word._() : super();
  factory Word.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Word.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Word', package: const $pb.PackageName(_omitMessageNames ? '' : 'call_summary'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'startMs', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'durationMs', $pb.PbFieldType.O3)
    ..aOB(4, _omitFieldNames ? '' : 'isFinal')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'confidence', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Word clone() => Word()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Word copyWith(void Function(Word) updates) => super.copyWith((message) => updates(message as Word)) as Word;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Word create() => Word._();
  Word createEmptyInstance() => create();
  static $pb.PbList<Word> createRepeated() => $pb.PbList<Word>();
  @$core.pragma('dart2js:noInline')
  static Word getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Word>(create);
  static Word? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get startMs => $_getIZ(1);
  @$pb.TagNumber(2)
  set startMs($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStartMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartMs() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get durationMs => $_getIZ(2);
  @$pb.TagNumber(3)
  set durationMs($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDurationMs() => $_has(2);
  @$pb.TagNumber(3)
  void clearDurationMs() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isFinal => $_getBF(3);
  @$pb.TagNumber(4)
  set isFinal($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsFinal() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsFinal() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get confidence => $_getN(4);
  @$pb.TagNumber(5)
  set confidence($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasConfidence() => $_has(4);
  @$pb.TagNumber(5)
  void clearConfidence() => clearField(5);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
