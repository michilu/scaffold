@JsName('hackernews')
library hackernews;

import 'dart:async';

import 'package:js_wrapping/js_wrapping.dart';

part 'hackernews.g.dart';

abstract class _HackerNews implements JsInterface {
  factory _HackerNews(String baseUrl) => null;

  JsObject GetFeed(String name, num page);
  JsObject GetItem(String id);

  Future<List<Map<String, dynamic>>> getFeed(String name, num page) async {
    Completer c = new Completer();
    JsObject o = GetFeed(name, page);
    o.callMethod('then', [
      (JsArray v) {
        c.complete(__codec2.decode(v));
      }
    ]);
    return c.future;
  }

  Future<Map<String, dynamic>> getItem(String id) async {
    Completer c = new Completer();
    JsObject o = GetItem(id);
    o.callMethod('then', [
      (JsObject v) {
        c.complete(__codec1.decode(v));
      }
    ]);
    return c.future;
  }
}

/// codec for null.dynamic
final __codec0 = new DynamicCodec();

/// codec for dart.core.Map<String, dynamic>
final __codec1 = new JsObjectAsMapCodec<dynamic>(__codec0);

/// codec for dart.core.List<Map<String, dynamic>>
final __codec2 = new JsListCodec<Map<String, dynamic>>(__codec1);
