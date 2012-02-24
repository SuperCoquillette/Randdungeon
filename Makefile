VALAC = valac
LIBS	= --pkg gee-1.0 --pkg sdl --pkg sdl-gfx -X -lSDL_gfx --pkg sdl-image -X -lSDL_image
OPTS	= $(LIBS)
DEPS  = Main.vala Cardinals.vala Chunk.vala Generator.vala \
			  Map.vala Colors.vala

all: Randdungeon

Randdungeon: $(DEPS)
	$(VALAC) $(OPTS) $^ -o $@

clean:
