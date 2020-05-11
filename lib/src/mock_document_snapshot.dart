import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/src/mock_document_reference.dart';
import 'package:mockito/mockito.dart';

Map<String, dynamic> _deepCopy(Map<String, dynamic> source) {
  return source.map(
      (key, value) => MapEntry(key, value is Map ? _deepCopy(value) : value));
}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {
  final String _documentId;
  final Map<String, dynamic> _document;
  final bool _exists;
  final MockDocumentReference _reference;

  MockDocumentSnapshot(this._reference, this._documentId,
      Map<String, dynamic> document, this._exists)
      : _document = _deepCopy(document);

  @override
  String get documentID => _documentId;

  @override
  dynamic operator [](String key) {
    return _document[key];
  }

  @override
  Map<String, dynamic> get data {
    if (_exists) {
      return _document;
    } else {
      return null;
    }
  }

  @override
  bool get exists => _exists;

  @override
  DocumentReference get reference => _reference;
}
