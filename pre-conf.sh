#!/bin/bash


#reason of this script is that dockerfile only execute one command at the time but we need sometimes at the moment we create 
#the docker image to run more that one software for expecified configuration like when you need mysql running to chnage or create
#database for the container ...

python -m IPython.external.mathjax

jupyter notebook --generate-config

julia -e 'Pkg.init(); Pkg.add("IJulia"); Pkg.add("PyPlot"); Pkg.add("SIUnits"); Pkg.add("Gadfly"); Pkg.add("DataStructures"); Pkg.add("HDF5"); Pkg.add("Iterators"); Pkg.add("MCMC"); Pkg.add("NumericExtensions"); Pkg.add("SymPy"); Pkg.add("Interact"); Pkg.add("Roots");'

julia -e 'Pkg.add("DataFrames"); Pkg.add("RDatasets"); Pkg.add("Distributions"); Pkg.add("SVM"); Pkg.add("Clustering"); Pkg.add("GLM"); Pkg.add("MCMC");'

julia -e 'Pkg.add("Optim"); Pkg.add("JuMP"); Pkg.add("GLPKMathProgInterface"); Pkg.add("Clp"); Pkg.add("NLopt"); Pkg.add("Ipopt");'

julia -e 'Pkg.add("Cairo");'

julia -e 'Pkg.add("Images"); Pkg.add("ImageView"); Pkg.add("WAV"); Pkg.add("ODE"); Pkg.add("Sundials"); Pkg.add("LinearLeastSquares");'

julia -e 'Pkg.add("BayesNets"); Pkg.add("PGFPlots"); Pkg.add("GraphLayout");'


#to make sure don't return with error from installing IJulia
echo 'done pre-configuration'
