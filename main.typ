#import "lib.typ": *

#outline(target: figure)

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

= Lecture 2

== Phasor Addition Rule with same frequency

$
  x(t) &= sum_(k = 1)^N A_k cos(omega_0 t + phi_k) \
  &= A cos(omega_0 t + phi) \

  &sum_(k = 1)^N A_k e^(i phi k) = A e^(i phi)
$

#Examplebox("Phasor Addition", [
  $
    x_1(t) &= 5 cos(2 pi (100) t + pi/3) = Re{5 e^(i pi/3) e^(i 2 pi (100) t)} \
    x_2(t) &= 4 cos(2 pi (100) t + pi/4) = Re{4 e^(-i pi / 4) e^(i 2 pi (100) t)} \
    x_1(t) + x_2(t) &=  Re{e^(i 2 pi (100) t) (5 e^(i pi/3) + 4 e^(-i pi / 4))} \
    5e^(i pi / 3) &= 5 cos(pi/3) + i 5 sin(pi/3) = 5(1/2 + i 1/2 sqrt(3)) \
    4 e^(-i pi / 4) &= 4 cos(-pi/4) + i 4 sin(-pi/4) = 4(sqrt(2)/2 - i sqrt(2)/2) \
    5 e^(i pi/3) + 4 e^(-i pi / 4) &= 5(1/2 + i 1/2 sqrt(3)) + 4(sqrt(2)/2 - i sqrt(2)/2) \
    &approx 5.3284 + i 1.5017 \
    A &= sqrt(5.3284^2 + 1.5017^2) approx 5.5 \
    phi &= arctan(1.5017/5.3284) approx 0.3 \
    x_1(t) + x_2(t) &= Re{5.5e^(i 0.3) e^i(2 pi (100) t)} \
    &= 5.5 cos(2 pi (100) t + 0.3)
  $
])


#Definitionbox("Harmonic Frequencies", [
  $ f_k = k dot f_0 $
  - frequencies that are integer mulitples of some fundamental frequency
  - $f_k$ is called the $k^(t h)$ harmonic of $f_0$
  - fundamental frequency is the GCD of all the frequencies
])

== Spectrum Interpretation

cosine is the sum of 2 complex exponentials, one term witha apositive frequency, the other with a negative,
the magnitude of each component is half the amplitude.

$
  cos theta = frac(e^(i theta) + e^(- i theta), 2)
$

#Examplebox("Spectrum to Sinusoid", [
  #table(columns: 3,
    [Frequency], [Amplitude], [Phase], 
    [-250 Hz], [4], [$- pi / 2$],
    [-100 Hz], [7], [$- pi / 3$],
    [0 Hz], [10], [0],
    [100], [7], [$- pi / 3$],
    [250 Hz], [4], [$- pi / 2$],
  )

  $
    x(t) &= 10 + 7 e^(-i pi/3) e^(i 2 pi (100) t) 
    + 7 e^(e^(i pi/3)) e^(-i 2 pi (100) t)
    + 4e^(i pi/2) e^(i 2 pi (250) t) + 4 e^(i pi/2) e^(-i 2 pi (250) t) \
    &= 10 + 14 cos(2 pi (100) t - pi/3) + 8 cos(2 pi (250)t + pi / 2)
  $
  *DC* is the name of the 0 frequency component, alsways has $phi = 0$ (or $phi = pi$ if the value is negative)
])


#Definitionbox("Fourier Series", [
  #Notationbox([
    $
      a_K = cases(
        1/2 X &"for" k > 0,
        X_0  &"for" k = 0,
        1/2 X_K^* &"for" k < 0,
      ) \
      f_(-k) = - f_k "for" k>0
    $
  ])

  $
    x(t) = sum_(k = -N)^N a_k e^(i 2 pi f_k t)
  $

  *for harmonic signal*
  $
    x(t) = sum_(k = -infinity)^infinity a_k e^(i 2 pi k f_0 t)
  $
])


#redbox([Orthogonalitry of $e$], [
  $
    integral_0^T_0 e^(i(2pi/T_0)k t) e^(-i(2 pi / T_0) ell t) d t = cases(0 quad &k != ell, T_0 &k = ell)
  $
])


#Examplebox([
  $
    x(t) &= sin^3(3 pi t) \
      &= (frac(e^(i 3 pi t) - e^(-i 3 pi t), 2 i))^2 \
      &= i/8 e^(i 9 pi t) + (-3 i)/8 e^(i 3 pi t) + (3 i)/8 e^(-i 3 pi t) + (-i)/8 e^(-i 9 pi t)\
  $
])

#Definitionbox("Gibbs' Phenomenon", [
  At Discontinuities, there is always an overshoot in the fourier analysis
])
