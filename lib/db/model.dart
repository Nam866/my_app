class ListModel {
  int id;
  String title;

  ListModel(this.title);
  ListModel.withId(
    this.id,
    this.title,
  );

  // Converting a data list object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['title'] = title;
    return map;
  }

  // Extract a Data List object from a Map object
  ListModel.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
  }
}
