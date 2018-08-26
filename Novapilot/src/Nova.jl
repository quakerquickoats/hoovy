module Nova

#########################################

using CoordinateTransformations, StaticArrays

struct Actor pos :: SVector end

render(a::Actor) = println("nothing")

struct Cell end

render(c::Cell) = nothing

struct Layer
    actors :: Dict{String,Actor}
    cells :: Array{Cell,2}
end

render(l::Layer) = foreach(render, l.actors)

#########################################

using SimpleDirectMediaLayer
const SDL = SimpleDirectMediaLayer

struct Screen
    window
    context
    width :: Cint
    height :: Cint

    layers :: Array{Layer}
end

#Screen(w, h) = Screen(nothing, nothing, w, h, [])
#screen = Screen()

######

error(msg) = begin
    println(msg)
    exit()
end

init(w::Int, h::Int) :: Screen = begin
    #screen = Screen(w, h)

    #if screen.window != nothing
#        return
#else
    if SDL.Init(SDL.INIT_VIDEO) < 0
        error("SDL could not initialise! SDL_Error: $(SDL.GetError())")
    end

    zero = convert(Cint, 0)
    w2 = convert(Cint, w)
    h2 = convert(Cint, h)
    window = SDL.CreateWindow("Nova",
                              zero, zero,
                              w2, h2,
                              SDL.WINDOW_OPENGL | SDL.WINDOW_SHOWN)
    
    if window == C_NULL
        error("Window could not be created! SDL_Error: $(SDL.GetError())")
    end

    context = SDL.GL_CreateContext(window)
    SDL.GL_SetAttribute(SDL.GL_CONTEXT_MAJOR_VERSION, 2)
    SDL.GL_SetAttribute(SDL.GL_CONTEXT_MINOR_VERSION, 1)
    SDL.GL_SetAttribute(SDL.GL_DOUBLEBUFFER, 1)
    SDL.GL_SetSwapInterval(convert(Cint, 1))

    # glViewport(0, 0, screen_width, screen_height);
    # //glClearColor(0.0, 0.0, 0.0, 1.0);
    # //glClear(GL_COLOR_BUFFER_BIT);

    Screen(window, context, w2, h2, [])
end

shutdown(s::Screen) = begin
    SDL.GL_DeleteContext(s.context)
    SDL.DestroyWindow(s.window)
    SDL.Quit()
end

update() = begin
    e :: SDL.Event
    
    SDL.Delay(200)
end

endFrame(s::Screen) = begin
    println("sdasdasd ok..")
    SDL.GL_SwapWindow(s.window)
end

end
