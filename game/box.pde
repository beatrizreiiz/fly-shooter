public class Box {
 float x1, x2;
 float y1, y2;

 Box( float x1, float y1, float x2, float y2 ) {
 this.x1 = x1;
 this.y1 = y1;

 this.x2 = x2;
 this.y2 = y2;
 }

 boolean isOverlap( Box b ) {
 if ((( x1 <= b.x1 && b.x1 <= x2 ) || ( x1 <= b.x2 && b.x2 <= x2 ))
 && (( y1 <= b.y1 && b.y1 <= y2 ) || ( y1 <= b.y2 && b.y2 <= y2 ))) {
 return true;
 }
 return false;
 }
}