
@testset "model.atom" begin

@testset "atom" begin
    @test atomnumber(:Fe) == 26

    sdfa = SDFileAtom(:Fe, 2, 1, nothing, [1.0, 2.0, 0.0], :anticlockwise)
    @test sdfa.symbol === :Fe
    @test atomnumber(sdfa) == 26
    @test sdfa.charge == 2
    @test sdfa.multiplicity == 1
    @test sdfa.coords == [1.0, 2.0, 0.0]
    @test sdfa.stereo === :anticlockwise

    smia = SmilesAtom(:C, 0, 1, 13.0, false, :clockwise)
    @test smia.symbol === :C
    @test atomnumber(smia) == 6
    @test smia.charge === 0
    @test smia.multiplicity == 1
    @test !smia.isaromatic
    @test smia.stereo === :clockwise
end

end # model.atom