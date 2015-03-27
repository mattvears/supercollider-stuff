


(
Routine.run({
	loop({
		play({
			PMOsc.ar(200, 280, Line.kr(0.0, 12, 1), mul: EnvGen.ar(Env.adsr(0.003,0.2,0,0), levelScale: 0.3, doneAction: 2)) ! 2;
		});
		1.wait;
	})
})
)


(
SynthDef(\fmtom, { | freq = 200, gate = 1, vol = 0.01 |
	var tom = PMOsc.ar(freq, 280, Line.kr(0.0, 12, 1), mul: EnvGen.ar(Env.adsr(0.003,0.2,0,0), gate, levelScale: 0.3, doneAction: 2));
	Out.ar(0, tom * vol ! 2);
}).store;
)

(
p = Pbind(
	\instrument, \fmtom,
	\scale, #[0, 2, 3, 4, 5, 6, 8],
    \root, 1,
	\degree, Ppatlace([Pseq(#[rest, 5, rest, 3], inf), Pn(1, inf), Pwhite(-0.9, 0.9, inf)], inf),
	\dur, 0.25,
	\vol, Pseq([1,0.5,1,1], inf),
).play(quant: 0.5)
)