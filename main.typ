#import "lib.typ": *

= Signals and Systems

== Learning Outcomes
+ Mathematically analyse continuous-time signals;
+ Mathematically analyse and practically implement linear filters;
+ Implement and use (fast) Fourier transforms for 1D and 2D signal processing;
+ Do frequency-domain analysis on signals via Fourier transforms.
+ Pattern Matching on 1D and 2D

== Lecture 1
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

  *Plotting from Formula*: 
  - determine the _period_ : $T = 2pi / omega$
  - determine the _peak_ : $(omega t + phi) = 0$
  - _Zero crossing_ : peak $plus.minus T/4$

  *Time Shift*:

  phase represents _time-shift_

  $ phi = - omega t_m $

  *Formula from Plot*
  - *Measure* height of positive peak: $A$
  - *Measure* the period: $T$
    - *Compute* Frequency: $omega = (2 pi) / T$
  - *Measure* time of the peak: $t_m$
    - *compute* phase: $phi = - omega t_m$
  
  *Phase is Ambiguous*
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
  sin(k pi) &= 0 \
  sin((2k + 1/2) pi) &= 1 \
  sin((2k + 3/2) pi) &= -1 \
  cos((k + 1/2) pi) &= 0 \
  cos(2 k pi) &= 1 \
  cos((2 k + 1) pi) &= -1 
$

#redbox("IMPORTANT", [
  When going from polar to cartesion complext numbers use `atan2()`
])

#purplebox("Complex Number Identities", [
  $
    Re {z} &= frac(z + overline(z), 2) \ 
    Im {z} &= frac(z - overline(z), 2 i) \ 
    |z| &= sqrt(z overline(z))
  $
])

#bluebox("Polar to Cartesion forms", [
  $
      r &= sqrt(x^2 + y^2) \
      theta &= arctan(y/x) \
      x &= r cos theta \ 
      y &= r sin theta \ 
  $
])

#yellowbox("Eulers formula", [
  $ 
    r e^(i theta) = r cos theta + i r sin theta \
    cos theta = frac(e^(i theta) + e^(- i theta), 2) \
    sin theta = frac(e^(i theta) - e^(- i theta), 2i) \
  $
])

*DeMoivre's Law*: $root(N, z) = e^(i 2 pi k/N) quad k=0, 1, 2, ..., N- 1$

sum of two sinosoids of the same frequency,
the result always has that frequency, but different amplitude and phase


