# Example for Jags-Ybinom-XnomSsubjCcat-MbinomBetaOmegaKappa.R 
#------------------------------------------------------------------------------- 
# Optional generic preliminaries:
graphics.off() # This closes all of R's graphics windows.
rm(list=ls())  # Careful! This clears all of R's memory!
#------------------------------------------------------------------------------- 
# Read the data 
myData = read.csv("race_data.csv")
#------------------------------------------------------------------------------- 
# Load the relevant model into R's working memory:
source("JobData-JAGS.R")
#------------------------------------------------------------------------------- 
# Optional: Specify filename root and graphical format for saving output.
# Otherwise specify as NULL or leave saveName and saveType arguments 
# out of function calls.
fileNameRoot = "Company-POST-" 
graphFileType = "eps" 
#------------------------------------------------------------------------------- 
# Generate the MCMC chain:
startTime = proc.time()
mcmcCoda = genMCMC( data=myData , 
                    zName="Hits", NName="AtBats", sName="Player", cName="PriPos",
                    numSavedSteps=5000 , saveName=fileNameRoot ,
                    thinSteps=20 )
stopTime = proc.time()
elapsedTime = stopTime - startTime
show(elapsedTime)
#------------------------------------------------------------------------------- 
# Display diagnostics of chain, for specified parameters:
parameterNames = varnames(mcmcCoda) # get all parameter names for reference
for ( parName in c("omega[1]","omegaO","kappa[1]","kappaO","theta[1]") ) { 
  diagMCMC( codaObject=mcmcCoda , parName=parName , 
                saveName=fileNameRoot , saveType=graphFileType )
}
#------------------------------------------------------------------------------- 
# Get summary statistics of chain:

#options(error=NULL)

summaryInfo = smryMCMC( mcmcCoda , compVal=NULL)  
                        # diffSVec=c(1000,2000,3000,4000) , 
                        # diffCVec=c(1,2,3) , 
                        # compValDiff=0.0 , saveName=fileNameRoot )
# Display posterior information:
plotMCMC( mcmcCoda , data=myData , 
          zName="Hits", NName="AtBats", sName="Player", cName="PriPos",
          compVal=NULL ,
          diffSList=list( c("Apple","Adobe") ,
                          c("Adobe","Intel") ) , 
          diffCList=list( c("big","medium") , 
                          c("big","small") , 
                          c("medium","small") ) , 
          compValDiff=0.0, #ropeDiff = c(-0.05,0.05) ,
          saveName=fileNameRoot , saveType=graphFileType )
#------------------------------------------------------------------------------- 
