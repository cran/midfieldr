% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_data_sufficiency.R
\name{add_data_sufficiency}
\alias{add_data_sufficiency}
\title{Determine data sufficiency for every student}
\usage{
add_data_sufficiency(dframe, midfield_term = term)
}
\arguments{
\item{dframe}{Working data frame of student-level records
to which data-sufficiency columns are to be added. Required variables
are \code{mcid} and \code{timely_term.} See also \code{add_timely_term()}.}

\item{midfield_term}{MIDFIELD \code{term} data table or equivalent
with required variables \code{mcid}, \code{institution}, and \code{term}.}
}
\value{
A data frame in \code{data.table} format with the following
properties: rows are preserved; columns are preserved with the exception
that columns added by the function overwrite existing columns of the
same name (if any); grouping structures are not preserved. The added
columns are:
\describe{
\item{\code{term_i}}{Character. Initial term of a student's longitudinal
record, encoded YYYYT. Not overwritten if present in \code{dframe.}}
\item{\code{lower_limit}}{Character. Initial term of an institution's data
range, encoded YYYYT}
\item{\code{upper_limit}}{Character. Final term of an institution's data
range, encoded YYYYT}
\item{\code{data_sufficiency}}{Character. Label each observation for
inclusion or exclusion based on data sufficiency. Possible values are:
\code{include}, indicating that available data are sufficient for
estimating timely completion; \code{exclude-upper}, indicating
that data are insufficient at the upper limit of a data range; and
\code{exclude}-lower, indicating that data are insufficient at the
lower limit.}
}
}
\description{
Add a column to a data frame of student-level records that labels each row
for inclusion or exclusion based on data sufficiency near the upper and lower
bounds of an institution's data range.
}
\details{
The time span of MIDFIELD term data varies by institution, each having their
own lower and upper bounds. For some student records, being at or near these
bounds creates unavoidable ambiguity when trying to assess degree completion.
Such records must be identified and in most cases excluded to prevent false
summary counts.
}
\examples{
# Start with an excerpt from the student data set 
dframe <- toy_student[1:10, .(mcid)]

# Timely term column is required to add data sufficiency column
dframe <- add_timely_term(dframe, midfield_term = toy_term)

# Add data sufficiency column
add_data_sufficiency(dframe, midfield_term = toy_term)

# Existing data_sufficiency column, if any, is overwritten
dframe[, data_sufficiency := NA_character_]
add_data_sufficiency(dframe, midfield_term = toy_term)
}
\seealso{
Other add_*: 
\code{\link{add_completion_status}()},
\code{\link{add_timely_term}()}
}
\concept{add_*}
