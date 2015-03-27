
(
SynthDef(\sub, { | freq = 40, gate = 1, lpf |
	var sig1, sig2, sig3, mix;
	var env;

	sig1 = LFPulse.ar(freq.midicps, 0, 0.1, 2 - SinOsc.kr(1)) * EnvGen.ar(Env.adsr(0.2,1,0.2,0.2), gate, doneAction: 2);
	sig2 = LFPulse.ar(freq.midicps + SinOsc.ar(0.2), 0, 0.12, 8 - SinOsc.kr(2)) * EnvGen.ar(Env.adsr(0.1,1,0.3,0.2), gate, doneAction: 2);
	sig3 = LFPulse.ar(freq.midicps) * EnvGen.ar(Env.adsr(0,1,0,0));
	mix = [
		LPF.ar(sig1.distort.distort + sig3, 300, 0.5),
		LPF.ar(sig2.distort.distort + sig3, 340, 0.5)
	];
	Out.ar(0, mix);
 }).store;
)


(
p = Pbind(
	\instrument, \sub,
	\freq, Pseq([24, 31], inf),
	\dur, 4
).play(quant: 1);
)
