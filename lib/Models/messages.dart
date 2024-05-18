class Messages{


  String? id;
  String? candidate_id;
  String? recipient;
  bool? status;
  String? message;
  String? created_at;
  String? successful_count;
  String? pending_count;
  String? failed_count;


  Messages(
      {this.id,
      this.candidate_id,
      this.recipient,
      this.status,
      this.message,
      this.created_at,
      this.successful_count,
      this.pending_count,
      this.failed_count});

  Map toJson(){
    return {
        "id": id,
        "candidate_id": candidate_id,
        "recipient": recipient,
        "status": status,
        "message": message,
        "created_at": created_at,
      }
    ;
  }



  factory Messages.fromJson(Map<String,dynamic> json){
    return Messages(id: json['id'].toString(),
    candidate_id: json['candidate_id'].toString(),
      recipient: json['recipient'].toString(),
      status: bool.parse(json['status'].toString()),
      message: json['message'],
      created_at: json['created_at'],
    );
  }


  factory Messages.fromMessageCount(Map<String,dynamic> json){
    return Messages(
      successful_count: json['successful_count'].toString(),
      pending_count: json['pending_count'].toString(),
      failed_count: json['failed_count'].toString(),
    );
  }
}