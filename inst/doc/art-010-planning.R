## ----child-common-setup-------------------------------------------------------
# code chunks
knitr::opts_chunk$set(fig.width = 8,
                      out.width = "100%",
                      collapse  = TRUE, 
                      comment   = "#>",
                      message   = FALSE, 
                      cache     = FALSE, 
                      error     = FALSE,
                      tidy      = FALSE, 
                      echo      = TRUE)

# inline numbers
knitr::knit_hooks$set(inline = function(x) {
    if (!is.numeric(x)) {
        x
    } else if (x >= 10000) {
        prettyNum(round(x, 2), big.mark = ",")
    } else {
        prettyNum(round(x, 2))
    }
})

# accented text
accent <- function (text_string){
    kableExtra::text_spec(text_string, color = "#b35806", bold = TRUE)
}

# Backup user options (load packages to capture default options)
suppressPackageStartupMessages(library(data.table))
backup_options <- options()

# Backup user random number seed
oldseed <- NULL
if (exists(".Random.seed")) oldseed <- .Random.seed

# data.table printout
options(datatable.print.nrows = 10,
        datatable.print.topn = 3,
        datatable.print.class = FALSE)

## -----------------------------------------------------------------------------
knitr::opts_chunk$set(fig.path = "../man/figures/art-010-")

## -----------------------------------------------------------------------------
#  # Not run
#  student <- fread("local_path_to_student_research_data")
#  course <- fread("local_path_to_course_research_data")
#  term <- fread("local_path_to_term_research_data")
#  degree <- fread("local_path_to_degree_research_data")

## -----------------------------------------------------------------------------
#  # Load practice data
#  library(midfielddata)
#  data(student, course, term, degree)

## -----------------------------------------------------------------------------
# Restore the user options (saved in common-setup.Rmd)
options(backup_options)

# Restore user random number seed if any
if (!is.null(oldseed)) {.Random.seed <- oldseed}

# to change the CSS file
# per https://github.com/rstudio/rmarkdown/issues/732
knitr::opts_chunk$set(echo = FALSE)

