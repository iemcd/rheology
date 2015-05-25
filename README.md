# rheology
These are tools I wrote while doing some work with rheological spectra. The end result was my paper [1].

specgen.m
===
specgen.m is a matlab script that generates a discrete rheological spectrum with error according to the method in Honerkamp and Weese [2].

ToDo
---
* The RNG might not produce the same error between runs. It's unclear if this is desirable anyway, but I should at least be clear about it.
* Currently I integrate the spectrum numerically, but it can in fact be done exactly and I don't know why I didn't do this.
* More realistic error might be generated according to the methods in section D of Anderssen and Davies [3].
* I dislike Matlab, but I may need to make some changes to make it an idiomatic octave script.

spectrumcalc
===
spectrumcalc is a perl script that takes a discrete rheological spectrum and a list of points, and calculates relevant material functions at those points. If the input spectrum is a relaxation spectrum, then the points are interpreted as frequencies and dynamic moduli will be calculated. If the input spectrum is a retardation spectrum, then the points are interpreted as times, and creep compliances will be calculated. An overview of these calculations can be found in many books, but my favorite is Ferry [4].

References
===
[1]Inferring meaningful relaxation spectra from experimental data  
McDougall, Ian and Orbey, Nese and Dealy, John M., Journal of Rheology (1978-present), 58, 779-797 (2014), DOI:[http://dx.doi.org/10.1122/1.4870967](http://dx.doi.org/10.1122/1.4870967)

[2] Determination of the relaxation spectrum by a regularization method  
J. Honerkamp and J. Weese, Macromolecules, 1989, 22 (11), pp 4372-4377, DOI:[http://dx.doi.org/10.1021/ma00201a036](http://dx.doi.org/10.1021/ma00201a036)

[3] Simple moving-average formulae for the direct recovery of the relaxation spectrum  
Anderssen, R. S. and Davies, A. R., Journal of Rheology (1978-present), 45, 1-27 (2001), DOI:[http://dx.doi.org/10.1122/1.1332787](http://dx.doi.org/10.1122/1.1332787)

[4] Viscoelastic Properties of Polymers, 2nd ed.  
J. D. Ferry; Wiley: New York, 1970 (current edition is 3rd: [see here](http://www.wiley.com/WileyCDA/WileyTitle/productCd-0471048941.html))

