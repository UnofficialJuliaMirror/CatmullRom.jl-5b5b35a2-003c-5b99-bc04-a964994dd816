# The sorts of structures understood to hold the coordinates of a point
const NumVec = Array{T,1} where {T<:Number};
const NumTup = NTuple{N,T} where {N,T<:Number};
const NumNT = NamedTuple{S,NTuple{N,T}} where {S,N,T<:Number};
const OnePoint = Union{NumVec, NumTup, NumNT}

# The sorts of sequences understood to hold point coordinates
const VecNumVec = AbstractArray{Array{T,1},1} where {T<:Number};
const VecNumTup = AbstractArray{NTuple{N,T},1} where {N,T<:Number};
const TupNumTup = NTuple{M,NTuple{N,T}} where {M,N,T<:Number};
const TupNumVec = NTuple{M,Array{T,1}} where {M,N,T<:Number};
const VecNumNT = AbstractArray{NamedTuple{S,NTuple{N,T}},1} where {S,N,T<:Number};
const TupNumNT = NTuple{M,NamedTuple{S,NTuple{N,T}}} where {M,S,N,T<:Number};

const Points = Union{VecNumVec, VecNumTup, TupNumTup, TupNumVec, VecNumNT, TupNumNT};

isclosed(firstpoint::OnePoint, lastpoint::OnePoint) = firstpoint == lastpoint
isclosed(points::Points) = isclosed(first(points), last(points))

npoints(pts::Points) = length(pts)
ncoords(pts::Points) = eltype(pts) <: NamedTuple ? length(Tuple(pts[1])) : length(pts[1])

coordtype(pts::Points) = eltype(eltype(pts))
coordtype(pt::OnePoint) = eltype(pts)

function coordtype(x::T) where {T}
    result = T
    !(result<:Number) ? (result = eltype(result)) : (return result)
    !(result<:Number) ? (result = eltype(result)) : (return result)
    !(result<:Number) ? (result = eltype(result)) : (return result)
    !(result<:Number) ? throw(ErrorException("unable to discern the coordinate type for $T")) : (return result)
end

function coordtype(::Type{T}) where {T}
    result = T
    !(result<:Number) ? (result = eltype(result)) : (return result)
    !(result<:Number) ? (result = eltype(result)) : (return result)
    !(result<:Number) ? (result = eltype(result)) : (return result)
    !(result<:Number) ? throw(ErrorException("unable to discern the coordinate type for $T")) : (return result)
end

Base.convert(::Type{Array{T,1}}, x::NTuple{N,T}) where {N,T} = [x...,]
Base.convert(::Type{NTuple{N,T}}, x::Array{T,1}) where {N,T} = (x...,)