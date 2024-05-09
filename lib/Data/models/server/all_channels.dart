class ChannelModel {
  final String categoryId;
  final String name;
  final List<Channel> channels;

  ChannelModel({
    required this.categoryId,
    required this.name,
    this.channels = const [],
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    List<Channel> channels = [];
    if (json['channel'] != null) {
      channels = List<Channel>.from(json['channel'].map((x) => Channel.fromJson(x)));
    }
    return ChannelModel(
      categoryId: json['CategoryID'],
      name: json['Name'],
      channels: channels,
    );
  }
}

class Channel {
  final String channelId;
  final String name;
  final String type;

  Channel({
    required this.channelId,
    required this.name,
    required this.type,
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      channelId: json['ChannelID'],
      name: json['Name'],
      type: json['Type'],
    );
  }
}