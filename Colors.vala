namespace Randdungeon {
  class Colors {
    public static int32 RGBA(uint8 R, uint8 G, uint8 B, uint8 A){
      return (A << 24) | (R << 16) | (G << 8) | B; 
    }
  }
}
