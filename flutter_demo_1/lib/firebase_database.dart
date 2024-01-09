class FirebaseDatabase {

  FirebaseDatabase._();

  FirebaseDatabase? _instance;

  FirebaseDatabase get instance {
    if (_instance == null) {
      _instance = FirebaseDatabase._();
    }
    return _instance!;
  }




  // Firebase firebaseFirestore = FirebaseFirestore.instance;
  
  
  add(){
    // firebaseFirestore;
  }
  update(){}
  delete(){}
  get(){}
}