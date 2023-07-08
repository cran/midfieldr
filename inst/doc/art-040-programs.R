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
knitr::opts_chunk$set(fig.path = "../man/figures/art-040-")

## -----------------------------------------------------------------------------
library("midfieldr")
df <- filter_cip("^41")
n41 <- nrow(df)
n4102 <- nrow(filter_cip("^4102", cip = df))
n4103 <- nrow(filter_cip("^4103", cip = df))
name41 <- unique(df[, cip2name])

df24 <- filter_cip("^24")
n24 <- nrow(df24)
name24 <- unique(df24[, cip2name])

df51 <- filter_cip("^51")
n51 <- nrow(df51)
name51 <- unique(df51[, cip2name])

df1313 <- filter_cip("^1313")
n1313 <- nrow(df1313)
name1313 <- unique(df1313[, cip2name])

## -----------------------------------------------------------------------------
x <- filter_cip("^41")
x[2:9, cip2name := "\U2003\U02193"]
x[c(4, 5, 7, 8), cip4name := "\U2003\U02193"]

x |>
  kableExtra::kbl(
    align = "rlrlrl",
    caption = "Table 1: CIP taxonomy"
  ) |>
  kableExtra::kable_paper(lightable_options = "basic", full_width = TRUE) |>
  kableExtra::row_spec(0, background = "#c7eae5") |>
  kableExtra::column_spec(1:6, color = "black", background = "white")

## -----------------------------------------------------------------------------
library(midfieldr)
library(data.table)

## -----------------------------------------------------------------------------
# Loads with midfieldr
cip

## -----------------------------------------------------------------------------
# Names and class of the CIP variables
cip[, lapply(.SD, class)]

## -----------------------------------------------------------------------------
# 2-digit level
sort(unique(cip$cip2))

# 4-digit level
length(unique(cip$cip4))

# 6-digit level
length(unique(cip$cip6))

## -----------------------------------------------------------------------------
set.seed(20210613)

## -----------------------------------------------------------------------------
# 2-digit name sample
sample(cip[, cip2name], 10)

# 4-digit name sample
sample(cip[, cip4name], 10)

# 6-digit name sample
sample(cip[, cip6name], 10)

## -----------------------------------------------------------------------------
set.seed(NULL)

## -----------------------------------------------------------------------------
# First argument named, CIP argument if used must be named
x <- filter_cip(keep_text = c("engineering"), cip = cip)

# First argument unnamed, use default CIP argument
y <- filter_cip("engineering")

# Demonstrate equivalence
same_content(x, y)

## -----------------------------------------------------------------------------
# Filter basics
filter_cip("engineering")

## -----------------------------------------------------------------------------
# Optional arguments drop_text and select
filter_cip("engineering",
  drop_text = c("related", "technology", "technologies"),
  select = c("cip6", "cip6name")
)

## -----------------------------------------------------------------------------
#  # Example 1 filter using keywords
#  filter_cip("civil")

## -----------------------------------------------------------------------------
filter_cip("civil") |>
  kableExtra::kbl(align = "rlrlrl", caption = "Table 2. Search results.") |>
  kableExtra::kable_paper(lightable_options = "basic", full_width = TRUE) |>
  kableExtra::row_spec(0, background = "#c7eae5") |>
  kableExtra::column_spec(1:6, color = "black", background = "white")

## -----------------------------------------------------------------------------
# First search
first_pass <- filter_cip("civil")

# Refine the search
second_pass <- filter_cip("engineering", cip = first_pass)

# Refine further
third_pass <- filter_cip(drop_text = "technology", cip = second_pass)

## -----------------------------------------------------------------------------
third_pass |>
  kableExtra::kbl(align = "rlrlrl", caption = "Table 3. Search results.") |>
  kableExtra::kable_paper(lightable_options = "basic", full_width = TRUE) |>
  kableExtra::row_spec(0, background = "#c7eae5") |>
  kableExtra::column_spec(1:6, color = "black", background = "white")

## -----------------------------------------------------------------------------
# Three passes
x <- filter_cip("civil")
x <- filter_cip("engineering", cip = x)
x <- filter_cip(drop_text = "technology", cip = x)

# Combined search
y <- filter_cip("civil engineering", drop_text = "technology")

# Demonstrate equivalence
same_content(x, y)

## -----------------------------------------------------------------------------
#  # Search on text
#  filter_cip("german")

## -----------------------------------------------------------------------------
filter_cip("german") |>
  kableExtra::kbl(align = "rlrlrl", caption = "Table 4. Search results.") |>
  kableExtra::kable_paper(lightable_options = "basic", full_width = TRUE) |>
  kableExtra::row_spec(0, background = "#c7eae5") |>
  kableExtra::column_spec(1:6, color = "black", background = "white")

## -----------------------------------------------------------------------------
#  # Search on codes
#  filter_cip(c("050125", "160501"))

## -----------------------------------------------------------------------------
filter_cip(c("050125", "160501")) |>
  kableExtra::kbl(align = "rlrlrl", caption = "Table 5. Search results.") |>
  kableExtra::kable_paper(lightable_options = "basic", full_width = TRUE) |>
  kableExtra::row_spec(0, background = "#c7eae5") |>
  kableExtra::column_spec(1:6, color = "black", background = "white")

## -----------------------------------------------------------------------------
# Search that produces an error
filter_cip(c(050125, 160501))

## -----------------------------------------------------------------------------
#  # example 3 filter using regular expressions
#  filter_cip(c("^1410", "^1419"))

## -----------------------------------------------------------------------------
filter_cip(c("^1410", "^1419")) |>
  kableExtra::kbl(align = "rlrlrl", caption = "Table 6. Search results.") |>
  kableExtra::kable_paper(lightable_options = "basic", full_width = TRUE) |>
  kableExtra::row_spec(0, background = "#c7eae5") |>
  kableExtra::column_spec(1:6, color = "black", background = "white")

## -----------------------------------------------------------------------------
#  # Search on 2-digit code
#  filter_cip("^54")

## -----------------------------------------------------------------------------
filter_cip("^54") |>
  kableExtra::kbl(align = "rlrlrl", caption = "Table 7. Search results.") |>
  kableExtra::kable_paper(lightable_options = "basic", full_width = TRUE) |>
  kableExtra::row_spec(0, background = "#c7eae5") |>
  kableExtra::column_spec(1:6, color = "black", background = "white")

## -----------------------------------------------------------------------------
#  # Search on vector of codes
#  codes_we_want <- c("^24", "^4102", "^450202")
#  filter_cip(codes_we_want)

## -----------------------------------------------------------------------------
codes_we_want <- c("^24", "^4102", "^450202")
filter_cip(codes_we_want) |>
  kableExtra::kbl(align = "rlrlrl", caption = "Table 8. Search results.") |>
  kableExtra::kable_paper(lightable_options = "basic", full_width = TRUE) |>
  kableExtra::row_spec(0, background = "#c7eae5") |>
  kableExtra::column_spec(1:6, color = "black", background = "white")

## -----------------------------------------------------------------------------
# Unsuccessful terms produce a message
sub_cip <- filter_cip(c("050125", "111111", "160501", "Bogus", "^55"))

# But the successful terms are returned
sub_cip

## -----------------------------------------------------------------------------
# When none of the search terms are found
filter_cip(c("111111", "Bogus", "^55"))

## -----------------------------------------------------------------------------
# Name and class of variables (columns) in cip
unlist(lapply(cip, FUN = class))

## -----------------------------------------------------------------------------
# Changing the number of rows to print
options(datatable.print.nrows = 15)

# Four engineering programs
four_programs <- filter_cip(c("^1408", "^1410", "^1419", "^1427", "^1435", "^1436", "^1437"))

# Retain the needed columns
four_programs <- four_programs[, .(cip6, cip4name)]
four_programs

## -----------------------------------------------------------------------------
# Assign a new column
four_programs[, program := NA_character_]
four_programs

## -----------------------------------------------------------------------------
#  # Run in Console
#  ? `%like%`

## -----------------------------------------------------------------------------
# Recode program using the 4-digit name
four_programs[cip4name %ilike% "electrical", program := "EE"]
four_programs

## -----------------------------------------------------------------------------
# Recode program using the 4-digit code
four_programs[cip6 %like% "^1408", program := "CE"]
four_programs

## -----------------------------------------------------------------------------
# Recode all program values
four_programs[, program := fcase(
  cip6 %like% "^1408", "CE",
  cip6 %like% "^1410", "EE",
  cip6 %like% "^1419", "ME",
  cip6 %chin% c("142701", "143501", "143601", "143701"), "ISE"
)]
four_programs <- four_programs[, .(cip6, program)]
four_programs

## -----------------------------------------------------------------------------
# Demonstrate equivalence
same_content(four_programs, study_programs)

## -----------------------------------------------------------------------------
# Edit as required for different programs
selected_programs <- filter_cip(c("^1408", "^1410", "^1419", "^1427", "^1435", "^1436", "^1437"))

## -----------------------------------------------------------------------------
# Recode program labels. Edit as required.
selected_programs[, program := fcase(
  cip6 %like% "^1408", "CE",
  cip6 %like% "^1410", "EE",
  cip6 %like% "^1419", "ME",
  cip6 %chin% c("142701", "143501", "143601", "143701"), "ISE"
)]
selected_programs <- selected_programs[, .(cip6, program)]

## -----------------------------------------------------------------------------
# Restore the user options (saved in common-setup.Rmd)
options(backup_options)

# Restore user random number seed if any
if (!is.null(oldseed)) {.Random.seed <- oldseed}

# to change the CSS file
# per https://github.com/rstudio/rmarkdown/issues/732
knitr::opts_chunk$set(echo = FALSE)

