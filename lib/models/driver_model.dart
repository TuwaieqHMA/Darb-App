class Driver {
  Driver({
    required this.id,
    required this.noTrips,
    required this.hasBus,
    required this.supervisorId,
  });
  late final String id;
  late final int noTrips;
  late final bool hasBus;
  late final String supervisorId;
  
  Driver.fromJson(Map<String, dynamic> json){
    id = json['id'];
    noTrips = json['no_trips'];
    hasBus = json['has_bus'];
    supervisorId = json['supervisor_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['no_trips'] = noTrips;
    _data['has_bus'] = hasBus;
    _data['supervisor_id'] = supervisorId;
    return _data;
  }
}

// {
//      "id": "dasjd9n29973927",
//      "no_trips": 0,
//      "has_bus": false,
//      "supervisor_id": "wjbijwbe9785762"
// }