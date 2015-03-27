(

	SynthDef(\ghostwind, { | carPartial = 1, modPartial = 2.5, index = 3, freq = 340, res = 0.8, gate = 1 |
	var env = EnvGen.ar(Env.adsr(0.3, 1, 0.5, 1), gate, doneAction: 2);
	var mod = BPF.ar(BBandPass.ar(WhiteNoise.ar(), freq: freq * modPartial, bw: 0.1, mul: freq * index));
	var sig = BPF.ar(SinOsc.ar((freq * carPartial) + mod, 0, mod), freq, res) * env;
	Out.ar(0, sig * 0.001 ! 2);
	}).store
)

(
p = Pbind(
	\instrument, \ghostwind,
	\scale, #[0, 2, 3, 4, 5, 6, 8],
    \root, 1,
	\degree, Ppatlace([Pseq(#[rest, 5, rest, 3], inf), Pn(1, inf), Pwhite(-0.9, 0.9, inf)], inf),
	\dur, 4,
).play(quant: 0.5)
)