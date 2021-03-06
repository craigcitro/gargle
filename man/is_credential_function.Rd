% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/registry.R
\name{is_credential_function}
\alias{is_credential_function}
\title{Check that f is a viable credential fetching function.}
\usage{
is_credential_function(f)
}
\arguments{
\item{f}{A function to check.}
}
\description{
In the abstract, a credential fetching function is any function which takes a
set of scopes and any number of additional arguments, and returns either a
valid \code{\link[httr:Token]{httr::Token()}} or \code{NULL}.
}
\details{
Here we say that a function is valid if its first argument is named
\code{scopes}, and it includes \code{...} as an argument, since it's
difficult to actually check the behavior of the function.
}
\keyword{internal}
