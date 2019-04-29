class Student{
  final String name;
  final String lastName;

  Student(this.name, this.lastName);

  factory Student.fromJson(Map<String, dynamic> json){
    return Student(json['name'], json['lastName']);
  }

}