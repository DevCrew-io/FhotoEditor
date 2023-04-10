part of fhoto_editor;

/// Rotate given Image

Widget rotate(Image img, double rotation){
  return  Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationZ(
        rotation,
      ),
      child: img
  );
}

/// set math.pi 0r 0 for 180 degree horizontal/vertical flip

Widget flipImage(Image img, double rotation,bool isVertical){
  return Transform(
    alignment: Alignment.center,
    transform:isVertical? Matrix4.rotationY(rotation): Matrix4.rotationX(rotation),
    child: img,
  );
}