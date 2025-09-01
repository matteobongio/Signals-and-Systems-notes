#import "lib.typ": *

= Signals and Systems

#bluebox("What is a continuous signal?", [
  - A mathematical function of time, $x(t)$
  - deflection versus time (amplitude is maximum deflection)
])

#Notationbox([
  () analogue, [] digital
])

#Definitionbox("Sinusoidal Signal", [
  always use $cos$ instead of $sin$ ($phi -= pi/2$)

  $ x(t) = A cos(2 pi omega t + phi) = Re(A e^(i phi) e^(i omega t)) $

  Radian Frequency: $omega$ radians

  Cyclic Frequencey: $f = omega / (2pi)$

  Period: $T = 1 / f$

  Amplitude $A$

  phase $phi$

  #line()

  period: $T = 2pi / omega$

  peak: $(omega t + phi) = 0$

  Zero: peak $plus.minus T/4$

  $ phi = - omega t_m$
])

#Examplebox([
  Sol (440Hz)
  $ x(t) = A cos(2 pi (440)t + phi) $
])


#Definitionbox("Frequency", [
  $ f = 1 / T $
  $T$ is the time for 1 oscilation
])

#Definitionbox("fourirer analysis", [
  breaking a signal into a sum of sinosoids, can be done for all signals
])

#pinkbox("Speech signals", [
  nearly periodic signals in vowels
])

Common values
= TODO: study values of sin and cos

= TODO: finish this
$
  sin(k pi) = 0 \
  sin((2k + 1/2))
$


= when going from polar to cartesion complext numbers use atan2()

= Eulers formula

= cos and sin from eulrers formula


sum of two sinosoids of the sam freq, the result always has that freq, but diff amp and phase


== Learning Outcomes
+ Mathematically analyse continuous-time signals;
+ Mathematically analyse and practically implement linear filters;
+ Implement and use (fast) Fourier transforms for 1D and 2D signal processing;
+ Do frequency-domain analysis on signals via Fourier transforms.
+ Pattern Matching on 1D and 2D
