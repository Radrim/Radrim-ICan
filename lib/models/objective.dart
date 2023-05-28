class Objective 
{
   String? id;
   String? description;
   String? idTarget;
   bool? isFinished;

  Objective(
    {
      this.id,
      this.description,
      this.idTarget,
      this.isFinished,
    });

  factory Objective.fromMap(Map<dynamic, dynamic> map) {

    return Objective(
      id: map['id'] ?? '',
      idTarget: map['idTarget'] ?? '',
      description: map['description'] ?? '',
      isFinished: map['isFinished'] ??'',
    );
  }
}
