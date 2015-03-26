(
SynthDef(\bass, { | midiNote = 40, gate = 1, lpf = 1000, res = 0.8, width = 0.05, amp = 1 |
	var sig, env;
	var sig2, env2;

	// ghetto 303
	env = Env.adsr(0.05, 2, 0, 0.3, 0.8, -12);
	sig = LFPulse.ar(midiNote.midicps, width: width) + Pulse.ar(midiNote.midicps, width: 0.9);
	sig = sig * EnvGen.ar(env, gate, amp, doneAction: 2);
	sig = RLPF.ar(sig, lpf, res);

	env2 = Env.adsr(0.03, 2, 0, 0.3, 0.8, -13);
	sig2 = LFPulse.ar(midiNote.midicps, width: width)  + Pulse.ar(midiNote.midicps, width: 0.9);
	sig2 = FreqShift.ar(sig2, 3);
	sig2 = sig2 * EnvGen.ar(env2, gate, amp, doneAction: 2);
	sig2 = RLPF.ar(sig2, lpf, res);


	Out.ar(0, [sig, sig2]);

}).store
)



(
p = Pbind(
	\instrument, \bass,
	\midiNote, Pseq([36, 36, 39, 36, 36, 36, 39, 36,  19, 19, 19, 34, 31, 31, 31, 29], 256),
	\lpf, Pseries(2000, -1, 256),
	\res, Pseries(0.01, 0.01, 256),
	\dur, 0.25,
).play(quant: 1)
)



(
p = Pbind(
	\instrument, \bass,
	\midiNote, Pseq([36, 36, 36, 36, 36, 36, 36, 36,  31, 31, 31, 31, 31, 31, 31, 31], inf),
	\lpf, Pwhite(100, 2000, inf),
	\res, Pwhite(0.0, 0.9, inf),
	\dur, Pseq([0.125, 0.125, 0.125, 0.125, 0.25, 0.25, 0.4, 0.1], inf)
).play(quant: 1)
)



(
p = Pseries(10, 2000, 128).asStream;
p.all.plot;
)

s.scope

Env.adsr(0.05, 2, 0, 0, 0.8, -8).plot

Env.adsr(0.05, 2, 0, 0, 0.8, -8).plot



SystemClock.beats % 100