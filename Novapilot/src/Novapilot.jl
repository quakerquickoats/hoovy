module Novapilot

export greet
greet() = print("Hello World!")

using CoordinateTransformations, StaticArrays

#######################

struct Actor
    pos :: SVector
end

render(a::Actor) = println("nothing")

########################

struct Cell
end

render(c::Cell) = nothing

struct Layer
    actors :: Dict{String,Actor}
    cells :: Array{Cell,2}
end

################################

struct GameState
    score :: Int
    time :: Scalar

    layers :: Array{Layer}
end

GameState() = GameState(0, 0, [])

render(g::GameState) = foreach(render, g.layers)
render(l::Layer) = foreach(render, l.actors)

locatecell(g::GameState, x,y,z) = nothing  # layers == Z

###########################

menu() = Dict("Story Mode" => storymode,
              "Edit Mode" => editmode,
              "Scores" => scoremode,
              "Options" => optionmode)

main() = println("boot nova...")

end
