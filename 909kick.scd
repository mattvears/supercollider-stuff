
// Fill buffer for waveshaping.
(
x = Signal.sineFill(513, [0.5, 0.2, 0.3, 0.0, 0.2]);
x.plot;
b = Buffer.alloc(s, 1024, 1);
)

b.sendCollection(x.asWavetableNoWrap);


// Kick synth definition
(
SynthDef(\kick, { | startPitch = 100, lpf1 = 100, lpf2 = 200, lpf3 = 200, gate = 1 |
	var sig1, adsr1;
	var sig2, sig3, adsr2, adsr3, mixed;

	adsr1 = Env.adsr(0, 1, 0, 0.1, curve: -4);
	adsr2 = Env.adsr(0, 0.1, 0, 0.1, curve: -8);
	adsr3 = Env.adsr(0, 0.1, 0, 0.1);

	sig1 = Saw.ar(XLine.ar(startPitch, 1, 8, doneAction: 2));
	sig1 = Shaper.ar(b.bufnum, sig1);
	sig1 = sig1 * EnvGen.kr(adsr1, gate: gate, doneAction: 2);
	sig1 = LPF.ar(sig1, lpf1);

	sig2 = LFPulse.ar(50, 0.1, 0.2) * EnvGen.kr(adsr2, gate: gate, doneAction: 2);
	sig2 = LPF.ar(sig2, lpf2);

	sig3 = WhiteNoise.ar(0.5) * EnvGen.kr(adsr3, gate: gate, doneAction: 2);
	sig3 = LPF.ar(sig3, lpf3);

	Out.ar(0, Mix.new([sig1, sig2, sig3]) ! 2);
	}
).store;
)

// A pattern with some swing.
(
p = Pbind(
	\instrument, \kick,
	\dur, Pseq([1.05,0.95],inf)
).play(quant: 1)
)