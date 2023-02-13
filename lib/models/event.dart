class Event {
  final String title;
  final String vet;
  final String time;
  final String notes;
  final String pet;

  const Event(this.title,this.vet, this.time, this.notes, this.pet);

  @override
  String toString() => title;
}
