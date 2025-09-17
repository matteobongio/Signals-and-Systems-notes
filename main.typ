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

= Lecture 3

#Definitionbox("Beat Notes/Amplitude Modulation", [
  Amplitude changes over time

  $ c(t) = v(t) cos(2 pi f_c t) $

  *Beat Notes*: product of 2 sinusoids
  $
    x(t) = cos(2 pi f_1 t) + cos(2 pi f_2 t) = 2 cos(2 pi f_c t) cos(2 pi f_Delta t)
  $
  - $f_c$: $frac(f_1 + f_2, 2)$
  - $f_Delta$: $frac(f_1 - f_2, 2)$
])

#Definitionbox("Chirps/Frequency Modulation", [
  Frequency changes over time

  $ x(t) = cos(2 pi f_0 t + v(t) + phi) $

  *Chirps*: Quadratic angle function, linear instantaneous frequency
  $ c(t) = A cos(alpha t^2 + 2 pi f_0 t + phi) $
  - Frequency changes linearly over time
  - _instantaneous frequency_: derivative
    $ x (t) + A cos(Psi(t)) => omega_i(t) = d/(d t) Psi(t) $
])

#Definitionbox("Sampling", [
  - aliasing
    - folding
  - spectrum for digitial signals

  *Uniform Sampling*:
    - Sampling Time Interval $T_s$: time between two samples
    - Samplig Rate $f_s = 1/T_s$
    
  Uniform Sampling at $t = n dot T_s = n/f_s$

  $x[n] = x(n dot T_s) = x(n / f_s)$
])

#Examplebox([
  *Audio CD*:

  CD rate is 44 100 samples per secound, 16-bit samples, 2 channels (stereo)
  $ 2 times (16/8) times 60 times 44100 = 10.584 "MB per minute" $
])

== Discrete-Time Sinusoid
- A-D conversion:
  $ 
  x[n] = A cos(hat(omega) n + phi) \
  hat(omega) = omega T_s = omega/f_s = (2 pi f)/f_s
  $
  - $hat(omega)$ varies from $0$ to $2 pi$, as $f$ varies from $0$ to the sampling frequency
  - Units: radians

#Definitionbox("Aliasing", [
  - Different Frequencies may yield the same $hat(omega)$
  $
    x(t) = A cos(2 pi (f + ell f_s) t + phi)\
    hat(omega) = omega T_s + (2 pi f)/f_s plus.minus 2 pi ell
  $
  *principal alias*: $ell = 0$

  - Adding or Subtracting integer multiples of $f_s$ to the frequency yields that same $x[n]$

  - negative frequencies are also affected, but their phase becomes negative:
  $
    x(t) &= A cos(2 pi (-f + ell f_s) t + phi) \
    => x[n] &= A(hat(omega) n - phi)
  $

  - *Folding*: a type of aliasing
  $
    f_s = 1000 \
    cos(2 pi (100) t) &-> cos[2 pi (0.1) n]\
    cos(2 pi (1100) t) &-> cos[2 pi (0.1) n]\
    cos(2 pi (900) t) &-> cos[2 pi (0.1) n]
  $
    - folding frequency = $1/2 f_s$
])

- D-A reconstruction:
  $y[n] -> y(t)$: replace $n$ with $f_s t$

  ambiguous due to aliasing, we choose the signal with the lowest frequency
  
  - Stair-step approximation: for every sample, make a constant function, with the sample time in the middle
  - Interpolation: for every sample draw a line until the next sample
  - Sinc: optimal pulse: $p(t) = frac(sin (pi t)/T_s, (pi t)/T_s), p(0)=1$


#TheoremBox("Shannon Sampling Theorem", [
  $ "Sampling Rate" > 2 ("Highest Frequency Component") $

  also called _Nyquist Rate_

  This only works for bandlimited signals, so not the square wave, as it is an infinite sum
])
