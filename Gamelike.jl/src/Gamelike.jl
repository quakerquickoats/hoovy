module Gamelike

greet() = print("Hello Butty!")

abstract type AbstractActor end
struct PlayerCharacter <: AbstractActor end

abstract type AbstractPlayerClass end

macro defplayerclass(x)
    :(abstract type $x end)
    end

abstract type Chef <: AbstractPlayerClass end

###################

struct Actor
    name::String
    end

struct Cell
    end

const CellMap = Array{Union{Cell,Missing},3}

struct World
    actors::Array{Actor}
    map::CellMap
    end

genworld() = begin
    actors = [Actor(string(rand(1:9999))) for n in 1:rand(1:20)]
    w = World(actors,
              CellMap(missing, (16,16,16)))
    return w
    end

turn(a::Actor) = begin
    print(a.name)
    end

turn(w::World) = begin
    foreach(turn, w.actors)
    end

end
