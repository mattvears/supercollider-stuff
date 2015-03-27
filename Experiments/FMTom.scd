


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
SynthDef(\fmtom, { | gate = 1, vol = 0.01 |
	var tom = PMOsc.ar(200, 280, Line.kr(0.0, 12, 1), mul: EnvGen.ar(Env.adsr(0.003,0.2,0,0), gate, levelScale: 0.3, doneAction: 2));
	Out.ar(0, tom * vol ! 2);
}).store;
)

(
p = Pbind(
	\instrument, \fmtom,
	\dur, 0.25,
	\vol, Pseq([0,0.5,0,1], inf),
).play(quant: 0.5)
)