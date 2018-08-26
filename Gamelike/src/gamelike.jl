module Gamelike

greet() = print("Hello World!")

abstract type AbstractActor end


struct PlayerCharacter <: AbstractActor
end

abstract type AbstractPlayerClass end

macro defplayerclass(x)
    :(abstract type $x end)
end

abstract type Chef <: AbstractPlayerClass end


end
