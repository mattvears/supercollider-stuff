(
SynthDef(\whitehh, { | gate = 1, delay = 0, trig = 1, swing = 0.1 |
	var env, sig, sig2;

	env = Env.adsr(0.01, 0.1, 0, 0.1, 0.6, -8);
	sig = WhiteNoise.ar(ToggleFF.ar(TDelay.ar(Impulse.ar(1), swing))) * EnvGen.ar(env, ToggleFF.ar(TDelay.ar(Impulse.ar(1), swing)));
	sig = BLowPass4.ar(sig, 1800, mul: 0.8);
	sig = BHiPass.ar(sig, 1500, mul:0.8);

	Out.ar(0, sig ! 2);
	}
).store
)


(
p = Pbind(
	\instrument, \whitehh,
	\swing, Pseq([0, 0.05], inf),
	\dur, 1
).play(quant: 0.25);
)
