#
# This file is a part of MolecularGraph.jl
# Licensed under the MIT License http://opensource.org/licenses/MIT
#

export
    SDFileBond, SmilesBond,
    setorder, setnotation, setstereo, todict


struct SDFileBond <: Bond
    """Bond
    * Notation
        * Single bond
            * 0: u - v
            * 1: u ◀ v (Up-arrow)
            * 2: v ◀ u -> for SMILES coordgen compatibility
            * 4: u ~ v (Up or down)
            * 6: u ◁ v (Down-arrow)
            * 7: v ◁ u -> for SMILES coordgen compatibility
        * Double bond
            * 0: v ニ u (clockwise, default)
            * 1: u ニ v (counter-clockwise)
            * 2: u ＝ v (equal length, for terminal bond by default)
            * 3: u × v (Cis-Trans Unknown)
    """
    order::Int
    notation::Int
    stereo::Symbol
end

SDFileBond() = SDFileBond(1, 0, :unspecified)
SDFileBond(order) = SDFileBond(order, 0, :unspecified)
SDFileBond(order, notation) = SDFileBond(order, notation, :unspecified)

SDFileBond(data::Dict{String,Any}) = SDFileBond(
    data["order"],
    data["notation"],
    Symbol(data["stereo"])
)

function todict(b::SDFileBond)
    data = Dict{String,Any}()
    for field in fieldnames(SDFileBond)
        data[string(field)] = getfield(b, field)
    end
    return data
end

setorder(edge::SDFileBond, order
    ) = SDFileBond(order, edge.notation, edge.stereo)

setnotation(edge::SDFileBond, notation
    ) = SDFileBond(edge.order, notation, edge.stereo)

setstereo(edge::SDFileBond, cistrans
    ) = SDFileBond(edge.order, edge.notation, cistrans)



struct SmilesBond <: Bond
    order::Int
    isaromatic::Bool
    direction::Symbol
    stereo::Symbol
end

SmilesBond() = SmilesBond(1, false, :unspecified, :unspecified)
SmilesBond(order) = SmilesBond(order, false, :unspecified, :unspecified)
SmilesBond(order, isaromatic, direction
    ) = SmilesBond(order, isaromatic, direction, :unspecified)

SmilesBond(data::Dict{String,Any}) = SmilesBond(
    data["order"],
    data["isaromatic"],
    Symbol(data["direction"]),
    Symbol(data["stereo"])
)

function todict(b::SmilesBond)
    data = Dict{String,Any}()
    for field in fieldnames(SmilesBond)
        data[string(field)] = getfield(b, field)
    end
    return data
end

setorder(edge::SmilesBond, order
    ) = SmilesBond(order, edge.isaromatic, edge.direction, edge.stereo)

setstereo(edge::SmilesBond, cistrans
    ) = SmilesBond(edge.order, edge.isaromatic, edge.direction, cistrans)
