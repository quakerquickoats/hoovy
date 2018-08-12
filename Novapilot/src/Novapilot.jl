module Novapilot

export greet
greet() = print("Hello World!")

const Scalar = Float32

struct Point
    x :: Scalar
    y :: Scalar
end

struct Actor
    pos :: Point
end

struct Layer
    actors :: Dict{String,Actor}
    cells :: AbstractArray
end

struct GameState
    score :: Int
    time :: Scalar

    layers :: Array{Layer}
end

GameState() = GameState(0, 0, [])

render(g::GameState) = foreach(render, g.layers)
render(l::Layer) = foreach(render, l.actors)
render(a::Actor) = println("nothing")


main() = println("boot nova...")

end
