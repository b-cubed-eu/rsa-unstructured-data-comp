# Function to get pentad code from decimal co-ordinates

get_pentad <- function(lat, lon) {
  
  latSep<-unlist(stringr::str_split(lat, "\\.")) # separate integer from fractional part of latitude
  deglatpen<-gsub("-","",latSep[1]) # remove - sign if required from the integer
  
  declat<-as.numeric(paste0("0.", latSep[2]))*60 # Add a zero in front of the fractional part of latitude and multiply by 60
  declatpen<-sprintf('%02d', plyr::round_any(declat, 5, floor)) # round down to nearest number divisible by 5
  
  lonSep<-unlist(stringr::str_split(lon, "\\.")) # separate integer from fractional part of longitude
  deglonpen<-gsub("-","",lonSep[1]) # remove - sign if required from the integer
  
  declon<-as.numeric(paste0("0.", lonSep[2]))*60 # Add a zero in front of the fractional part of longitude and multiply by 60
  declonpen<-sprintf('%02d', plyr::round_any(declon, 5, floor)) # round down to nearest number divisible by 5
  
 paste0(deglatpen, declatpen, "_", deglonpen, declonpen) # create the code
  
}

# Implementation for a single point

get_pentad(-34.205, 21.380)

# Implementation for a dataframe
x<-c("South Africa", "South Africa", "South Africa", "South Africa")
coordLat<-c(-34.001, -34.467, -34.220, -34.278)
coordLong<-c(20.797, 21.380, 20.974, 20.633)
df<- as.data.frame(cbind(x, coordLat, coordLong))
df$coordLat<-as.numeric(df$coordLat)
df$coordLong<-as.numeric(df$coordLong)

apply(df[,c('coordLat','coordLong')], 1, function(y) get_pentad(y['coordLat'],y['coordLong']))

