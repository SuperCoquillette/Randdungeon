namespace Randdungeon {
	class Chunk {
		public enum ChunkType {
			FLOOR,
      UNREACHABLE,
			INPUT,
			OUTPUT;

      public static int32 size(){
        return 4;
      }
		}

		public enum ChunkComposition {
			GROUND,
			TREASURE,
			STONE,
			LAVA,
			WATER,
			SAND;

      public static int32 size(){
        return 6;
      }
		}

		private bool              _walls [4];
		private bool              _doors [4];
		private ChunkType         _type;
		private ChunkComposition  _composition;

    public ChunkComposition chunk_composition {
      get {
        return _composition;
      }

      set {
      }
    }

    public  ChunkType chunk_type {
      get {
        return _type;
      }

      set {
      }
    }

		public Chunk(ChunkType ct = ChunkType.UNREACHABLE,
                 ChunkComposition cc = ChunkComposition.STONE)
    {
      this._type        = ct;
      this._composition = cc;
		}

    public string to_string() {
      return @"$_type $_composition";
    }

		public static Chunk random() {
      GLib.Rand rand = new GLib.Rand();
      return new Chunk((ChunkType)rand.int_range(0, ChunkType.size()),
                       (ChunkComposition)rand.int_range(0, ChunkComposition.size()));
		}
	}
}
