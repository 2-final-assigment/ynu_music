class Lyric {
  List<LyricModel> list;

  Lyric(this.list);
}

class LyricModel {
  int millisecond; //歌词片段开始时间
  String lrc; //片段内容
  String tlyric; //片段翻译

  LyricModel(this.millisecond, this.lrc, this.tlyric);
}
