@JsName('hackernews')
library hackernews;

import 'dart:async';

import 'package:js_wrapping/js_wrapping.dart';

part 'hackernews.g.dart';

abstract class _HackerNews implements JsInterface {
  factory _HackerNews(String baseUrl) => null;

  JsObject GetFeed(String name, num page);
  JsObject GetItem(String id);

  Future<List<Map>> getFeed(String name, num page) {
    final Completer c = Completer();
    final JsObject o = GetFeed(name, page);
    o.callMethod('then', [c.complete]);
    return c.future;
  }

  Future<Map> getItem(String id) {
    final Completer c = Completer();
    final JsObject o = GetItem(id);
    o.callMethod('then', [c.complete]);
    return c.future;
  }
}
