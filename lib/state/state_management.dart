
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final user_logged=StateProvider((ref)=>FirebaseAuth.instance.currentUser);