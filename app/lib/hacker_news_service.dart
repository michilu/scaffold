import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:angular/angular.dart';

import 'package:hackernews/hackernews.dart';

/// Represents the base URL for HTTP requests using [HackerNewsService].
const baseUrl = const OpaqueToken<String>('baseUrl');

const defaultBaseUrl = 'https://api.hnpwa.com/v0';

class HackerNewsService {
  final String _baseUrl;
  HackerNews hackernews;

  // Store the last feed in memory to instantly load when requested.
  String _cacheFeedKey;
  List<Map> _cacheFeedResult;

  HackerNewsService(@baseUrl this._baseUrl) {
    hackernews = new HackerNews(_baseUrl);
  }

  Future<List<Map>> getFeed(String name, int page) async {
    final url = '$_baseUrl/$name/$page.json';
    if (_cacheFeedKey == url) {
      return _cacheFeedResult;
    }
    final decoded = await hackernews.getFeed(name, page);
    _cacheFeedKey = url;
    _cacheFeedResult = decoded;
    final Completer c = new Completer();
    c.complete(_cacheFeedResult);
    return c.future;
  }

  Future<Map> getItem(String id) async {
    return await hackernews.getItem(id);
  }
}
