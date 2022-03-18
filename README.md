# ASIAA-blazar-variability
Some data and code to study blazar variation timescale and amplitude, and try to find their dependence with blazar source size, which is observed by VLBI

Including OVRO monitering sources, and some sources from Sasha (a Russain Phd student)

We used SF to structure function (SF) to characterize the variability of the sources, and we used a model fit to fit the SF, whcih is a simple random stochastic process.

Uncertainty is also include in the model fit.

As the model fit reach its half of its maximum value at saturation, we define it as characteristic timescale.

We define the SF amplitude at 1000 days, becuae timelag is sufficiently large such that the SF already saturates in a large number of sources, but not too large such that the SF amplitudes are dominated by measurement uncertainties due to the smaller number of flux density pairs.

We used Matlab to do the analysis
