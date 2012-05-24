module framework.implementation.math.matrixerrors;

class InvalidMatrixDimensionsError : Exception {
  this() {
    super( "Invalid matrix dimensions" );
  }
}

class InvalidRowLength : Exception {
  this() {
    super( "Invalid row length\n" );
  }
}

class InvalidColLength : Exception {
  this() {
    super( "Invalid column length\n" );
  }
}

class IncompatibleMatrices : Exception {
  this() {
    super( "Incompatible matrices\n" );
  }
}
