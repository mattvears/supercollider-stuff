({
	PMOsc.ar(200, 280, Line.kr(0.0, 12, 1), mul: EnvGen.ar(Env.adsr(0.003,0.2,0,0), levelScale: 0.3, doneAction: 2)) ! 2
}.play
)