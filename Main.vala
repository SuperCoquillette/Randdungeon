using SDL;
using SDLGraphics;
using Gee;

namespace Randdungeon {
  class SDLRendering {
    private const int SCREEN_WIDTH = 640;
    private const int SCREEN_HEIGHT = 480;
    private const int SCREEN_BPP = 32;
    private const int DELAY = 10;

    public Map m;

    private unowned SDL.Screen screen;
    private GLib.Rand rand;
    private bool done;

    public SDLRendering () {
      this.rand = new GLib.Rand ();
    }

    public void run () {
      init_video ();

      while (!done) {
        draw ();
        process_events ();
        SDL.Timer.delay (DELAY);
      }
    }

    private void init_video () {
      uint32 video_flags = SurfaceFlag.DOUBLEBUF
        | SurfaceFlag.HWACCEL
        | SurfaceFlag.HWSURFACE;

      this.screen = Screen.set_video_mode (SCREEN_WIDTH, SCREEN_HEIGHT,
          SCREEN_BPP, video_flags);
      if (this.screen == null) {
        stderr.printf ("Could not set video mode.\n");
      }

      SDL.WindowManager.set_caption ("Vala SDL Demo", "");
    }

    private static string gfx_location_from_signature(string signature){
      return "gfx/" + signature + ".PNG";
    }

    private void draw () {
      ArrayList<ArrayList<Chunk>> map = m.map;

      int16 x = 0, y = 0;
      int16 imgs = 32;

			foreach(ArrayList<Chunk> c in map){
        x = 0;
				foreach(Chunk d in c){

          Surface img = SDLImage.load(gfx_location_from_signature(d.chunk_composition.to_string()));

          if(img == null){
            stderr.printf("Error while loading graphic ressource\n");
          }

          imgs = (int16)img.w;

          Rect rdest = SDL.Rect();
          rdest.x = (int16)x;
          rdest.y = (int16)y;
          img.blit(null, this.screen, rdest);

          x += imgs;
				}
        y += imgs;
			}
      this.screen.flip();
    }

    private void process_events () {
      Event event;
      while (Event.poll (out event) == 1) {
        switch (event.type) {
          case EventType.QUIT:
            this.done = true;
            break;
          case EventType.KEYDOWN:
            this.on_keyboard_event (event.key);
            break;
        }
      }
    }

    private void on_keyboard_event (KeyboardEvent event) {
      if (is_alt_enter (event.keysym)) {
        WindowManager.toggle_fullscreen (screen);
      }else if (event.keysym.sym == KeySymbol.q) {
        this.done = true;
      }
    }

    private static bool is_alt_enter (Key key) {
      return ((key.mod & KeyModifier.LALT)!=0)
        && (key.sym == KeySymbol.RETURN
            || key.sym == KeySymbol.KP_ENTER);
    }

  }

  int main(string args[]){
    Map m = new Map(8);
    m.randomize();
    stdout.printf("%s\n", m.to_string());

    var sample = new SDLRendering();
    sample.m = m;

    SDL.init(InitFlag.VIDEO);

    sample.run();

    SDL.quit();

    return 0;
  }
}
