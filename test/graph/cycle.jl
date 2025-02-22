#
# This file is a part of MolecularGraph.jl
# Licensed under the MIT License http://opensource.org/licenses/MIT
#

@testset "graph.cycle" begin

@testset "minimumcyclebasis" begin
    p5 = pathgraph(5)
    @test isempty(minimumcyclebasis(p5))
    c5 = cyclegraph(5)
    @test length(minimumcyclebasis(c5)[1]) == 5
    k44 = completebipartite(3, 3)
    @test sum(map(length, minimumcyclebasis(k44))) == 16
    k5 = completegraph(5)
    @test sum(map(length, minimumcyclebasis(k5))) == 18
    cycs = plaingraph(6, [(1, 2), (2, 3), (3, 1), (3, 4), (4, 5), (5, 6), (6, 4)])
    @test length(minimumcyclebasis(cycs)) == 2
end

end # graph.cycle
