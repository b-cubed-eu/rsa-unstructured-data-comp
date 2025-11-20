# Function to get quarter degree grid cell codes from decimal-coordinates

get_qdgc_code <- function(lat, lon) {
  dirLon <- lon < 0 # true if longitude is negative
  dirLat <- lat < 0 # true if latitude is negative

  DegLonCod <- ifelse(dirLon == TRUE, "W", "E") # assign east/west
  DegLatCod <- ifelse(dirLat == TRUE, "S", "N") # assign north/south

  DegLon <- ifelse(dirLon == TRUE, -1 * ceiling(lon), floor(lon)) # extract the integer from longitude (always needs to be positive)
  DegLat <- ifelse(dirLat == TRUE, -1 * ceiling(lat), floor(lat)) # extract the integer from latitude (always needs to be positive)

  declat <- as.numeric(paste0("0.", unlist(stringr::str_split(lat, "\\."))[2])) # extract the fractional part of latitude
  declon <- as.numeric(paste0("0.", unlist(stringr::str_split(lon, "\\."))[2])) # extract the fractional part of longitude

  # Determine first code based on fractional portions

  DegCode <- ifelse(declat < 0.5 & declon < 0.5, "A",
    ifelse(declat < 0.5 & declon > 0.5, "B",
      ifelse(declat > 0.5 & declon < 0.5, "C", "D")
    )
  )

  # Determine second code based on fractional portions

  DegCode <- ifelse(declat < 0.5 & declon < 0.5, "A",
    ifelse(declat < 0.5 & declon > 0.5, "B",
      ifelse(declat > 0.5 & declon < 0.5, "C", "D")
    )
  )


  if (DegCode == "A") {
    QDegCode <- ifelse(declat < 0.25 & declon < 0.25, "A",
      ifelse(declat < 0.25 & declon > 0.25, "B",
        ifelse(declat > 0.25 & declon < 0.25, "C", "D")
      )
    )
  }

  if (DegCode == "B") {
    QDegCode <- ifelse(declat < 0.25 & declon < 0.75, "A",
      ifelse(declat < 0.25 & declon > 0.75, "B",
        ifelse(declat > 0.25 & declon < 0.75, "C", "D")
      )
    )
  }

  if (DegCode == "C") {
    QDegCode <- ifelse(declat < 0.75 & declon < 0.25, "A",
      ifelse(declat < 0.75 & declon > 0.25, "B",
        ifelse(declat > 0.75 & declon < 0.25, "C", "D")
      )
    )
  }

  if (DegCode == "D") {
    QDegCode <- ifelse(declat < 0.75 & declon < 0.75, "A",
      ifelse(declat < 0.75 & declon > 0.75, "B",
        ifelse(declat > 0.75 & declon < 0.75, "C", "D")
      )
    )
  }

  # Construct QDGC string

  paste0(DegLonCod, "0", DegLon, DegLatCod, DegLat, DegCode, QDegCode)
}


# Examples

## Set of co-ordinates

get_qdgc(lat = -33.95792, lon = 20.79125)

## Co-ordinates in a data frame
x <- c("South Africa", "South Africa", "South Africa", "South Africa")
coordLat <- c(-34.044, -34.129, -34.362, -34.362)
coordLong <- c(20.792, 21.376, 21.873, 21.543)
df <- as.data.frame(cbind(x, coordLat, coordLong))
df$coordLat <- as.numeric(df$coordLat)
df$coordLong <- as.numeric(df$coordLong)

apply(df[, c("coordLat", "coordLong")], 1, function(y) get_qdgcCode(y["coordLat"], y["coordLong"]))
