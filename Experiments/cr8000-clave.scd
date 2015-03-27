(
{
	var freq = 2330;
	var sig = LFTri.ar(freq);
	BPF.ar(sig, freq, 0.9, EnvGen.ar(Env.adsr(0.001, 0.02, 0, 0, curve: -2)));
}.play
)

