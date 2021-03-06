% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/df.R
\name{readDfFromDb}
\alias{readDfFromDb}
\title{Read data.frame from a database connection}
\usage{
readDfFromDb(conn, tableName, row.names = FALSE, ...)
}
\arguments{
\item{conn}{A database connection}

\item{tableName}{The name of the table}

\item{row.names}{Logical, whether \code{row.names} are to be written}

\item{...}{Other parameters passed to \code{dbReadTable}

Compared with \code{\link{dbReadTable}}, \code{readDfFromDb} handles
\code{raw} vectors better so that printing the output \code{data.frame}
will not crash the R (or RStudio) session.}
}
\value{
\code{readDfFromDb} returns a data.frame object
}
\description{
Read data.frame from a database connection
}
\examples{
library(RSQLite)
myList <- list(list(MyTeam="HSV", Score=18),
               list(MyTeam="BVB", Score=16))
myTestDf <- data.frame(Number=c(3,4),
                       Complex=I(lapply(myList, function(x) { serialize(x, NULL)})))
myCon <- dbConnect(SQLite(), ":memory:")
writeDfToDb(myCon, myTestDf, tableName="testDataFrame")
myTestDfOut <- readDfFromDb(myCon, "testDataFrame")
myTestDfOut
unserialize(myTestDfOut$Complex[[1]])
testthat::expect_equal(myTestDf, myTestDfOut)

}
