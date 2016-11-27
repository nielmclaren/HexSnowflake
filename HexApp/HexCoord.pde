
public class HexCoord {
  public int col;
  public int row;
  
  HexCoord(int c, int r) {
    col = c;
    row = r;
  }

  ArrayList<HexCoord> getNeighbors(HexCoord hex) {
    ArrayList<HexCoord> result = new ArrayList<HexCoord>();
    result.add(new HexCoord(hex.col - 1, hex.row - 1));
    result.add(new HexCoord(hex.col + 0, hex.row - 2));
    result.add(new HexCoord(hex.col + 1, hex.row - 1));
    result.add(new HexCoord(hex.col + 1, hex.row + 1));
    result.add(new HexCoord(hex.col + 0, hex.row + 2));
    result.add(new HexCoord(hex.col - 1, hex.row + 1));
    return result;
  }
  
  boolean isNeighbor(HexCoord hex) {
    int dCol = abs(hex.col - col);
    int dRow = abs(hex.row - row);
    if (dCol == 1 && dRow == 1) {
      return true;
    }
    if (dCol == 0 && dRow == 2) {
      return true;
    }
    return false;
  }
}