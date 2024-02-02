import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:towner_final_round/widgets/snackbar_messenger.dart';

class FirestoreCRUD {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new document to a collection
  Future<DocumentReference?> addDocument(
      String collectionPath, Map<String, dynamic> data) async {
    try {
      return await _firestore.collection(collectionPath).add(data);
    } on FirebaseException catch (e) {
      log('Error adding document: ${e.message}');
      getxSnackbar(isError: true, message: e.message!);
      return null;
    } catch (e) {
      log('Error adding document: $e');
      getxSnackbar(isError: true, message: 'An unexpected error occurred.');
      rethrow; // Rethrow for unexpected errors
    }
  }

  // Get all documents from a collection
  Future<QuerySnapshot?> getDocuments(String collectionPath) async {
    try {
      return await _firestore.collection(collectionPath).get();
    } on FirebaseException catch (e) {
      log('Error getting documents: ${e.message}');
      getxSnackbar(isError: true, message: e.message!);
      return null;
    } catch (e) {
      log('Error getting documents: $e');
      getxSnackbar(isError: true, message: 'An unexpected error occurred.');
      rethrow;
    }
  }

  // Get a specific document by ID
  Future<DocumentSnapshot?> getDocumentById(
      String collectionPath, String docId) async {
    try {
      return await _firestore.collection(collectionPath).doc(docId).get();
    } on FirebaseException catch (e) {
      log('Error getting document: ${e.message}');
      getxSnackbar(isError: true, message: e.message!);
      return null;
    } catch (e) {
      log('Error getting document: $e');
      getxSnackbar(isError: true, message: 'An unexpected error occurred.');
      rethrow;
    }
  }

  // Update a document
  Future<void> updateDocument(
      String collectionPath, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).update(data);
    } on FirebaseException catch (e) {
      log('Error updating document: ${e.message}');
      getxSnackbar(isError: true, message: e.message!);
    } catch (e) {
      log('Error updating document: $e');
      getxSnackbar(isError: true, message: 'An unexpected error occurred.');
      rethrow;
    }
  }

  // Delete a document
  Future<void> deleteDocument(String collectionPath, String docId) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).delete();
    } on FirebaseException catch (e) {
      log('Error deleting document: ${e.message}');
      getxSnackbar(isError: true, message: e.message!);
    } catch (e) {
      log('Error deleting document: $e');
      getxSnackbar(isError: true, message: 'An unexpected error occurred.');
      rethrow;
    }
  }
}
