
(
SynthDef(\cym, { | gate = 1 |
	var sig1, sig2, env2, mix, env, p3, env3;
	var p1 = LFPulse.ar(1250, width: 0.9);
	var p2 = LFPulse.ar(p1 * 2450, width: 0.4);
	//p2 = Mix.new([p2, FreqShift.ar(p2, -200)]);
	sig1 = BPF.ar(p2, 1050);

	// initial impact
	env = Env.adsr(0,0.8,0,1);
	sig1 = sig1 * EnvGen.ar(env, gate, doneAction: 2);

	// body and decay
	env2 = Env.adsr(0.05, 2, 0, 1);
	sig2 = HPF.ar(p2, 2640, EnvGen.kr(env2, gate, doneAction: 2));
	sig2 = sig2;
	env3 = EnvGen.ar(Env.adsr(0, 0.8, 0, 1), gate);
	mix = Mix.new([sig1, sig2 * 0.4]);
	Out.ar(0, [mix * env3] ! 2);
}).store
)

(
p = Pbind(
	\instrument, \kick,
	\dur, Pseq([1,1,1,1],inf)
).play(quant: 0.5)
)
(
p = Pbind(
	\instrument, \cym,
	\dur, Pseq([2,2,1,1,2,2,2,1,0.25,0.25,0.25,0.25],inf)
).play(quant: 1)
)
