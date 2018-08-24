@JsName('hackernews')
library hackernews;

import 'dart:async';

import 'package:js_wrapping/js_wrapping.dart';

part 'hackernews.g.dart';

abstract class _HackerNews implements JsInterface {
  factory _HackerNews(String baseUrl) => null;

  JsObject GetFeed(String name, num page);
  JsObject GetItem(String id);

  Future<List<Map>> getFeed(String name, num page) async {
    Completer c = Completer();
    JsObject o = GetFeed(name, page);
    o.callMethod('then', [
      (v) {
        c.complete(v);
      }
    ]);
    return c.future.then((v) {
      return List<Map>.from(v);
    });
  }

  Future<Map> getItem(String id) async {
    Completer c = Completer();
    JsObject o = GetItem(id);
    o.callMethod('then', [
      (v) {
        c.complete(v);
      }
    ]);
    return c.future.then((v) {
      return Map.from(v);
    });
  }
}
