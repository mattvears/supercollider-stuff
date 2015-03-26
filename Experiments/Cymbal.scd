(
{
	var pulse1, pulse2, sig, sig1, sig2;
	var env, env2, env3;
	var mix;

	pulse1 = LFPulse.ar(1047, width: 0.5);
	pulse2 = LFPulse.ar(2490 * pulse1, width: 0.6);

	sig1 = BPF.ar(pulse2, 1050);


	// initial impact
	env = Env.perc(0.01, 0.3);
	sig1 = sig1 * EnvGen.ar(env);

	// body and decay
	env2 = Env.linen(0.05, 0.2, 0.3, 3.6);
	sig2 = HPF.ar(pulse2, 2640, EnvGen.ar(env2));
	sig2 = sig2;

	mix = Mix.new([sig1, sig2 * 0.2]) * EnvGen.ar(Env.linen(0, 0, 0.736, 0.2));

	Out.ar(0, mix ! 2);

}.play
)



({
	var c = SinOsc.ar(220);
	SinOsc.ar(440 * c, 0);
}.plot
)


(
{
	var pulse1 = LFPulse.ar(1047, width: 0.5);
	LFPulse.ar(2490 * pulse1, width: 0.6);
}.plot
)