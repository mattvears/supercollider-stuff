(
SynthDef(\syn1, {
	arg lpFreq = 1000, vol = 1, gate = 1;
	var sig1, sig2;
	var triEnv;
	var shifted1;
	var shifted2;
	var sinEnv;
	var sin1, sin2;
	var mixed;
	var sig3;
	var noiseEnv;

	// tri -> final mixer
	triEnv = Env.adsr(0, 0.4, 0, 0, curve: -4,  peakLevel: 0.5);
	sig1 = LFTri.ar(111, 0, 0.5) * EnvGen.kr(triEnv, gate: gate, doneAction: 2);
	shifted1 = FreqShift.ar(sig1, 175);
	shifted2 = FreqShift.ar(sig1, 224);
	sig1 = Mix.new([shifted1, shifted2]);

	// sines -> final mixer
	sin1 = SinOsc.ar(330, mul: 0.2);
	sin2 = SinOsc.ar(180, mul: 0.2);
	sinEnv = Env.adsr(0, 0.2, 0, 0);
	sig2 = Mix.new([sin1, sin2]) * EnvGen.kr(sinEnv, gate: gate, doneAction: 2);

	// noise -> final mixer
	noiseEnv = Env.adsr(0, 0.3, 0, 0);
	sig3 = LPF.ar(WhiteNoise.ar() * EnvGen.kr(noiseEnv, gate: gate, doneAction: 2), 1000);
	sig3 = HPF.ar(sig3, 600);

	mixed = Mix.new([sig1, sig2, sig3]);
	mixed = LPF.ar(mixed, lpFreq) * vol;
	Out.ar(0, mixed  ! 2);
}).store)

(
p = Pbind(
	\instrument, \syn1,
	\lpFreq, Pseq([100, 2000, 300, 400], inf),
	\vol, Pseq([0.1, 1, 0.1, 1], inf),
	\dur, Pseq([1.05, 0.95], inf)
).play(quant: 4);
)


