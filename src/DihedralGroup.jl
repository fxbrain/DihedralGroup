module DihedralGroup

export D₅, inverse, dhint, sigma, identitya

import Base.convert, Base.*, Base.promote_rule

typealias BitsInteger Union(Int32, Int64)
abstract AbstractDihedralGroup{T} <: Integer

immutable DihedralInteger{T <: BitsInteger} <: AbstractDihedralGroup{T}
    i::T
end

typealias dhint DihedralInteger{Int}

convert{T<:BitsInteger}(::Type{DihedralInteger{T}}, x::T) = DihedralInteger(x)

convert{T<:BitsInteger}(::Type{DihedralInteger{T}}, x::Int) = DihedralInteger(convert(T,x))

convert{T<:BitsInteger}(::Type{DihedralInteger{T}}, x::DihedralInteger{T}) = x

promote_rule{T<:BitsInteger}(::Type{DihedralInteger{T}}, ::Type{T}) = DihedralInteger{T}


const D₅ = [0:9];
const dihedral_group_table = ([D₅' ;
                       1 2 3 4 0 6 7 8 9 5;
                       2 3 4 0 1 7 8 9 5 6;
                       3 4 0 1 2 8 9 5 6 7;
                       4 0 1 2 3 9 5 6 7 8;
                       5 9 8 7 6 0 4 3 2 1;
                       6 5 9 8 7 1 0 4 3 2;
                       7 6 5 9 8 2 1 0 4 3;
                       8 7 6 5 9 3 2 1 0 4;
                       9 8 7 6 5 4 3 2 1 0]);

*{T}(i::DihedralInteger{T}, j::DihedralInteger{T}) = dihedral_group_table[i.i+1, j.i+1]

inverse{T <: BitsInteger}(n::DihedralInteger{T}) = n.i == 0 ? 0 : n.i < 5 ? 5 - n.i : n.i
inverse{T <: BitsInteger}(n::T) = inverse(convert(DihedralInteger{T}, n))
                       
identity{T <: BitsInteger}(n::DihedralInteger{T}) = dhint(0)

end
