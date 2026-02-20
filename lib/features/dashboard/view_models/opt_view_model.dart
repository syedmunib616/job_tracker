
class OptViewModel {
  int calculateDays(DateTime start){
    return DateTime.now().difference(start).inDays;
  }
}