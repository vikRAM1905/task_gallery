class GalleryModel {
  bool? success;
  Resp? resp;

  GalleryModel({this.success, this.resp});

  GalleryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    resp = json['resp'] != null ? new Resp.fromJson(json['resp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.resp != null) {
      data['resp'] = this.resp!.toJson();
    }
    return data;
  }
}

class Resp {
  String? id;
  String? image;

  Resp({this.id, this.image});

  Resp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}