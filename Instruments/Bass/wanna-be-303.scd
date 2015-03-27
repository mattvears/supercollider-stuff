(
SynthDef(\bass, { | freq = 440, gate = 1, lpf = 1000, res = 0.8, width = 0.05, amp = 1 |
	var sig, env;
	var sig2, env2;

	// ghetto 303
	env = Env.adsr(0.05, 2, 0, 0.3, 0.8, -12);
	sig = LFPulse.ar(freq, width: width) + Pulse.ar(freq, width: 0.9);
	sig = sig * EnvGen.ar(env, gate, amp, doneAction: 2);
	sig = RLPF.ar(sig, lpf, res);

	env2 = Env.adsr(0.03, 2, 0, 0.3, 0.8, -13);
	sig2 = LFPulse.ar(freq, width: width)  + Pulse.ar(freq, width: 0.9);
	sig2 = FreqShift.ar(sig2, 3);
	sig2 = sig2 * EnvGen.ar(env2, gate, amp, doneAction: 2);
	sig2 = RLPF.ar(sig2, lpf, res);


	Out.ar(0, [sig, sig2]);

}).store
)


(
p = Pbind(
	\instrument, \bass,
	\scale, #[0, 2, 3, 4, 5, 6, 8],
    \root, -5,
	\degree, Ppatlace([Pseq(#[rest, 5, rest, 3, -0.1, 0.3], inf), Pn(1, inf), Pwhite(1, 5, inf)], inf),
	\lpf, Pwhite(100, 2000, inf),
	\res, Pwhite(0.0, 0.9, inf),
	\dur, 0.25,
).play(quant: 0.5)
)
