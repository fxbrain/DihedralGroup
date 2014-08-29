using DihedralGroup

#=
    For the dihedral check digit method we will need a very special permutation, σ, of D₅. 
    We want σ to have the property that σ(a) * b != σ(b) * a for any distinct elements a 
    and b of D₅
=#
const s = [0, 4, 3, 2, 1, 8, 9, 5, 6, 7];
sigma(n::Int) = s[n]

function map_indexed{F}(::Type{F}, a::AbstractArray, index::Int=0)
    for i = 1:length(a)
        a[i] = F(a[i], i + index)
    end
end

function apply_n{A, B}(number::A, ::Type{B}, times::Int)
    for i = 1:times
        number = B(number)
    end
    return number
end


abstract Functor
abstract UnaryFunctor <: Functor
abstract BinaryFunctor <: Functor

type mult_ <: BinaryFunctor end
type pow_ <: BinaryFunctor end
type add_ <: BinaryFunctor end
type sub_ <: BinaryFunctor end

mult_(a, b) = a * b
pow_(a, b) = a^b
add_(a, b) = a + b
sub_(a, b) = a - b

#multiply{F}(::Type{F}, a, b) = F(a, b)
#power{F}(::Type{F}, a, b) = F(a, b)
#add{F}(::Type{F}, a, b) = F(a, b)
#sub{F}(::Type{F}, a, b) = F(a, b)

a = [1:5]
map_indexed(mult_, a, 1)
println(a)

a = [1:5]
map_indexed(pow_, a, 1)
println(a)

a = [1:5]
map_indexed(add_, a, 0)
println(a)

a = [1:5]
map_indexed(sub_, a, 0)
println(a)

type plus_2 <: UnaryFunctor end

plus_2(a) = a + 2

accumulate{F}(::Type{F}, a) = F(a)

a= [1:5]
map(x -> accumulate(plus_2, x), a)
