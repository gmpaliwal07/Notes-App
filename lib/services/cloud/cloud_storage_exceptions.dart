class CloundStorageException implements Exception {
  const CloundStorageException();
}

// C
class CouldNotCreateNoteException extends CloundStorageException {}

// R
class CouldNotGetAllNoteException extends CloundStorageException {}

// U
class CouldNotUpdateNoteException extends CloundStorageException {}

// D
class CouldNotDeleteNoteException extends CloundStorageException {}
