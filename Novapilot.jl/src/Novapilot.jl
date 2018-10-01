module Novapilot

using Nova

struct GameWorld
    score :: Int
    time :: Scalar
end

GameWorld() = GameWorld(0, 0, [])
render(g::GameWorld) = foreach(render, g.layers)
locatecell(g::GameWorld, x,y,z) = nothing  # layers == Z

###########################

menu() = Dict("Story Mode" => storymode,
              "Edit Mode" => editmode,
              "Scores" => scoremode,
              "Options" => optionmode)

renderFrame() = begin
  #     (gl:color 1 0 0)
  # (gl:with-primitives :lines
  #   (gl:vertex -16 -16)
  #   (gl:vertex 16 16)
  #   )

end

mainLoop(world) = begin
    global running
    while running && Nova.update()
        global world
		  # (gl:clear :color-buffer :depth-buffer)
		  # (gl:matrix-mode :projection)
		  # (gl:load-identity)

		  # (gl:ortho 16 -16 16 -16 -1 1)
  
		  # ;;(glu:perspective 50 (/ width height) 0.5 20)
		  # (gl:matrix-mode :modelview)
		  # (gl:load-identity)

		  # (gl:flush)

		# (render-frame state)
        Nova.endFrame()
        mainLoop(world)
    end
end

main() = begin
    println("boot nova...")
    Nova.init(512, 512)

    # (gl:cull-face :back)
    # (gl:depth-func :less)
    # (gl:disable :dither)

    #global running
    #while running ...
    #    mainLoop()
    #end

    Nova.shutdown()
end

end
