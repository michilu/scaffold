// GENERATED CODE - DO NOT MODIFY BY HAND

part of hackernews;

// **************************************************************************
// JsWrappingGenerator
// **************************************************************************

@GeneratedFrom(_HackerNews)
class HackerNews extends JsInterface {
  HackerNews(String baseUrl)
      : this.created(JsObject(context['hackernews']['HackerNews'], [baseUrl]));
  HackerNews.created(JsObject o) : super.created(o);

  JsObject GetFeed(String name, num page) =>
      asJsObject(this).callMethod('GetFeed', [name, page]);
  JsObject GetItem(String id) => asJsObject(this).callMethod('GetItem', [id]);

  Future<List<Map>> getFeed(String name, num page) {
    Completer c = Completer();
    JsObject o = GetFeed(name, page);
    o.callMethod('then', [c.complete]);
    return c.future;
  }

  Future<Map> getItem(String id) {
    Completer c = Completer();
    JsObject o = GetItem(id);
    o.callMethod('then', [c.complete]);
    return c.future;
  }
}
