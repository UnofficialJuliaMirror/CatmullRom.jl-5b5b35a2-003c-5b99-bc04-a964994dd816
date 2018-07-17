#=

    service functions that allow us to use interpolants as if travel along the curve is uniform and linear
    
=#

square(x) = x*x

integralofcubic(a::T, b::T, c::T, x) where {T} = (6*a + x * (3*b + (x * (2*c)))) * x / 6
1/6 x (6 a + x (3 b + 2 c x)) + constant

integralofcubic(k::T, a::T, b::T, c::T) where {T} = Poly([k, a, b / 2, c / 3])

# lineal distance between two points, each point given in Cartesian coordinates
distance_lineal(point₀, point₁) = sqrt(sum(square.(point₁ .- point₀)))

# centripetal adjustment to the distance between two points, each point given in Cartesian coordinates
distance_centripetal(point₀, point₁) = sqrt(distance_lineal(point₀, point₁))

distances_centripetal(points) = [distance_centripetal(points[i], points[i+1]) for i=1:(length(points)-1)]

totaldistance_centripetal(points) = sum(distances_centripetal(points))


centripetal_pullback(points) = [0.0, (cumsum(distances_centripetal(points)) ./ totaldistance_centripetal(points))...,]

