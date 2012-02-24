using Gee;

namespace Randdungeon {
  class Map {
    private uint                        _size;
    private ArrayList<ArrayList<Chunk>> _map;

    public Map(uint size){
      this._size = size;
			_map = new ArrayList<ArrayList<Chunk>>();

			for(int i = 0; i < _size; ++i){
				_map.add(new ArrayList<Chunk>());
			}

			foreach(ArrayList<Chunk> c in _map){
				for(int i = 0; i < _size; ++i){
					c.add(new Chunk());
				}
			}
    }

    public void randomize(){
			foreach(ArrayList<Chunk> c in _map){
				for(int i = 0; i < _size; ++i){
					c[i] = Chunk.random();
				}
			}
    }

		public uint size {
			get {
				return _size;
			}

			set {
			}
		}

    public ArrayList<ArrayList<Chunk>> map {
      get {
        return _map;
      }

      set {
      }
    }

    public void set_chunk(int x, int y, Chunk c)
      requires(x >= 0)
      requires(y >= 0)
      requires(c != null)
    {
      _map[x][y] = c;
    }

		public string to_string(){
			StringBuilder ret = new StringBuilder();
			int x = 0, y = 0;
			string coord = "";
			foreach(ArrayList<Chunk> c in _map){
				y = 0;
				foreach(Chunk d in c){
					ret.append(x.to_string() + ", " + y.to_string() + " : ");
					ret.append(coord);
					ret.append(d.to_string());
					ret.append("\n");
					++y;
				}
				++x;
				ret.append("\n");
			}
			return ret.str;
		}
  }
}
