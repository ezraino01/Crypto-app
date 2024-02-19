import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../UserModel.dart';

class SignUpUser {
  final auth = FirebaseAuth.instance;
  late UserCredential? userCredential;
  final accountCollection = FirebaseFirestore.instance.collection("user");
  late User? user;
  // bool _stopLoading=false;

  Future<List> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      }) async {
    try {
      final cred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = cred.user;

    } on FirebaseException catch (error) {
      print('object.......................$error');
      if (error.code == 'weak-password') {
        return [false, 'the password provided is too weak'];
      } else if (error.code == 'email-already-in-use') {
        print('object.......................$error');
        return [false, 'An account with such email already exist'];
      }
    } catch (error) {
      return [false, error.toString()];
    }

    return [true, 'Signed Up successfully'];
  }

  Future<List> loginWithEmailandPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      // Users users = await getUsers(uid:user!.uid);
      //print(user.photoURL);
      return [true, 'reg successful'];
    } on FirebaseException catch (error) {
      // if (error.code=="wrong-password"){

      print(error.code);
      return [false, "email and password combination not correct"];

      //}
    }
    // return [true, 'reg successful',];
  }

  Future<void> registeration({required Users user}) async {
    try {
      await accountCollection
          .doc(this.user!.uid)
          .set(user.toMap(), SetOptions(merge: false));
    } catch (error) {}
  }

  Future<Users> getUsers({required String uid}) async {
    try {
      final myUser = await accountCollection.doc(uid).get();
      print('//////////s7jB9k3UFJSHKawmL70QwMCgctp2////////////${myUser.data()}');
      return Users.fromMap(myUser.data()!);
    } catch (error) {
      rethrow;
    }
  }

  Future<List> updateUser({required Users user}) async {
    try {
      await accountCollection
          .doc(user.Id)
          .set(user.toMap(), SetOptions(merge: true));
      return [true, 'your account have been updated successfully'];
    } catch (error) {
      print('......................................${error.toString()}');
      return [false, 'Not success'];
    }
  }

  // Future<List> uploadImage(
  //     {required String file, required String userId}) async {
  //   try {
  //     final storageReference =
  //     FirebaseStorage.instance.ref().child('profile_images/$userId');
  //     UploadTask uploadTask = storageReference.putFile(File(file));
  //     TaskSnapshot taskSnapshot = await uploadTask;
  //
  //     // Get the download URL of the updated image
  //     String newProfileImageUrl = await taskSnapshot.ref.getDownloadURL();
  //
  //     // Update profile image URL in Firestore
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userId)
  //         .update({"profileImage": newProfileImageUrl});
  //     return [true, 'Profile image updated successfully'];
  //   } on Exception catch (e) {
  //     // TODO
  //     print(e);
  //     return [false, '$e'];
  //   }
  // }
  Future<List> uploadImage(
      {required String file, required String userId}) async {
    try {
      final storageReference =
      FirebaseStorage.instance.ref().child('profile_images/$userId');
      UploadTask uploadTask = storageReference.putFile(File(file));
      TaskSnapshot taskSnapshot = await uploadTask;

      // Get the download URL of the updated image
      String newProfileImageUrl = await taskSnapshot.ref.getDownloadURL();

      // Update profile image URL in Firestore
      await FirebaseFirestore.instance
          .collection('user')
          .doc(userId)
          .update({"profileImage": newProfileImageUrl});
      return [true, 'Profile image updated successfully'];
    } on Exception catch (e) {
      // TODO
      print(e);
      return [false, '$e'];
    }
  }
  Future<List> transferMoney(
      {required String senderEmail, required String receiverEmail, required double amount}) async {
    final firestore = FirebaseFirestore.instance;

    try {
      // Get user references based on email
      final senderQuery =
      await accountCollection.where('email', isEqualTo: senderEmail).get();
      final receiverQuery = await accountCollection
          .where('email', isEqualTo: receiverEmail)
          .get();

      if (senderQuery.docs.isNotEmpty && receiverQuery.docs.isNotEmpty) {
        final senderDoc = accountCollection.doc(senderQuery.docs.first.id);
        final receiverDoc = accountCollection.doc(receiverQuery.docs.first.id);
        print('...............Sender............$senderDoc');
        print('..................Receiver.........$receiverDoc');
        // Start a Firestore transaction
        await firestore.runTransaction((transaction) async {
          // Get the latest balances
          final senderData = await transaction.get(senderDoc);
          final receiverData = await transaction.get(receiverDoc);
          double convertSenderBalance = double.parse(senderData['accBalance']);
          double convertReceiverBalance = double.parse(receiverData['accBalance']);
          // Check if the sender has enough balance
          print('...............convertSender............$convertSenderBalance');
          print('..................convertReceiver.........$convertReceiverBalance');
          if (convertSenderBalance >= amount) {
            // Update balances
            print('...............convertSenderBalance............$convertSenderBalance');
            print('..................convertReceiverBalance.........$convertReceiverBalance');
            transaction
                .update(senderDoc, {'accBalance':( convertSenderBalance - amount).toString()});
            transaction.update(
                receiverDoc, {'accBalance': (convertReceiverBalance + amount).toString()});
          } else {
            throw Exception('Insufficient balancemmmmmmm');
            //return [false,'Insufficient balance'];
            // Handle insufficient balance

          }
          //return [true,'Transaction successfully'];
        });
      } else {
        throw Exception('User not found');
        return [false,'User not found based on email'];
        // Handle user not found based on email

      }
      return [true,'Transaction successfully'];
    } catch (e) {
      print('Transaction failed: $e');
      throw Exception('Transaction failure or user not found $e');
      return [false,'Transaction failure or user not found'];
      // Handle transaction failure or user not found

    }

  }
  Future <List<Users>>getAllUsers() async {
    List<Users> userList = [];
    try {


      final data = await accountCollection.get();
      for(QueryDocumentSnapshot<Map<String, dynamic>> document in data.docs){
        Users user = Users.fromMap(document.data());
        userList.add(user);
        print('All users: ${userList.first.accBalance}');
      }
      // Do something with the userList

    } catch (e) {
      print('Error getting users: $e');
    }
    return userList;
  }

}
