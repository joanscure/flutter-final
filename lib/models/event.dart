class Event {
  final String title;
  final String vet;
  final String time;
  final String notes;
  final String pet;
  final String status;

  const Event(this.title,this.vet, this.time, this.notes, this.pet, this.status);

  @override
  String toString() => title;
}
