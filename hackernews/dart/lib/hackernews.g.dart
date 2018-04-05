// GENERATED CODE - DO NOT MODIFY BY HAND

part of hackernews;

// **************************************************************************
// Generator: JsWrappingGenerator
// **************************************************************************

@GeneratedFrom(_HackerNews)
class HackerNews extends JsInterface {
  HackerNews.created(JsObject o) : super.created(o);
  HackerNews(String baseUrl)
      : this.created(
            new JsObject(context['hackernews']['HackerNews'], [baseUrl]));

  JsObject GetFeed(String name, num page) =>
      asJsObject(this).callMethod('GetFeed', [name, page]);
  JsObject GetItem(String id) => asJsObject(this).callMethod('GetItem', [id]);

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
