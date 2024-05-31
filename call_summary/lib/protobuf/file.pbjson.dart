//
//  Generated code. Do not modify.
//  source: file.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use messageDescriptor instead')
const Message$json = {
  '1': 'Message',
  '2': [
    {'1': 'vendor', '3': 1, '4': 1, '5': 5, '10': 'vendor'},
    {'1': 'version', '3': 2, '4': 1, '5': 5, '10': 'version'},
    {'1': 'seqnum', '3': 3, '4': 1, '5': 5, '10': 'seqnum'},
    {'1': 'uid', '3': 4, '4': 1, '5': 5, '10': 'uid'},
    {'1': 'flag', '3': 5, '4': 1, '5': 5, '10': 'flag'},
    {'1': 'time', '3': 6, '4': 1, '5': 3, '10': 'time'},
    {'1': 'lang', '3': 7, '4': 1, '5': 5, '10': 'lang'},
    {'1': 'starttime', '3': 8, '4': 1, '5': 5, '10': 'starttime'},
    {'1': 'offtime', '3': 9, '4': 1, '5': 5, '10': 'offtime'},
    {'1': 'words', '3': 10, '4': 3, '5': 11, '6': '.call_summary.Word', '10': 'words'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode(
    'CgdNZXNzYWdlEhYKBnZlbmRvchgBIAEoBVIGdmVuZG9yEhgKB3ZlcnNpb24YAiABKAVSB3Zlcn'
    'Npb24SFgoGc2VxbnVtGAMgASgFUgZzZXFudW0SEAoDdWlkGAQgASgFUgN1aWQSEgoEZmxhZxgF'
    'IAEoBVIEZmxhZxISCgR0aW1lGAYgASgDUgR0aW1lEhIKBGxhbmcYByABKAVSBGxhbmcSHAoJc3'
    'RhcnR0aW1lGAggASgFUglzdGFydHRpbWUSGAoHb2ZmdGltZRgJIAEoBVIHb2ZmdGltZRIoCgV3'
    'b3JkcxgKIAMoCzISLmNhbGxfc3VtbWFyeS5Xb3JkUgV3b3Jkcw==');

@$core.Deprecated('Use wordDescriptor instead')
const Word$json = {
  '1': 'Word',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    {'1': 'start_ms', '3': 2, '4': 1, '5': 5, '10': 'startMs'},
    {'1': 'duration_ms', '3': 3, '4': 1, '5': 5, '10': 'durationMs'},
    {'1': 'is_final', '3': 4, '4': 1, '5': 8, '10': 'isFinal'},
    {'1': 'confidence', '3': 5, '4': 1, '5': 1, '10': 'confidence'},
  ],
};

/// Descriptor for `Word`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wordDescriptor = $convert.base64Decode(
    'CgRXb3JkEhIKBHRleHQYASABKAlSBHRleHQSGQoIc3RhcnRfbXMYAiABKAVSB3N0YXJ0TXMSHw'
    'oLZHVyYXRpb25fbXMYAyABKAVSCmR1cmF0aW9uTXMSGQoIaXNfZmluYWwYBCABKAhSB2lzRmlu'
    'YWwSHgoKY29uZmlkZW5jZRgFIAEoAVIKY29uZmlkZW5jZQ==');

