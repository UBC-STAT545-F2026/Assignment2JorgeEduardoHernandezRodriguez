#' @title Statistics and distribution of grouped numerical variable in a data set
#'
#' @description
#'  This function makes a table with the main descriptive statistics of a numerical variable in a data set grouped by a categorical variable. The user must input the titles of the categorical and numerical variables contained in their data set for the function to work. Furthermore this function creates a histogram of the distribution of the numerical variable grouped. As a first step if unsure of the types of your variable in your data set you can use the function srt(dataset)
#'
#' @param data data set to investigate
#' @param grouping_var the categorical variable in a data set to group the numerical variables. The name of this argument allows the user to understand that this argument will contain the categorical variable to group the data.
#' @param num_var the numerical variable in the data set to investigate the statistics and distribution grouped by the categorical variable. The name of this argument is intuitive so the user can select one numerical variable from the data set to investigate the statistics
#' @param na.rm allow the user to decide to keep or not the NA values, default is na.rm=TRUE. The name is intuitive an follow R language.
#' @importFrom rlang :=
#' @returns A summary table of the mean, median, max, and min values of the numerical variable grouped by a categorical variables. And a histogram showing the distribution of the data
#' @examples
#' library(palmerpenguins)
#' #Making a stats summary of the bill_length using the penguins dataset grouping by species
#' grouped_main_stats(palmerpenguins::penguins, species, bill_length_mm)
#' #Using another categorical and numerical variable in the penguins dataset
#' grouped_main_stats(palmerpenguins::penguins, island, bill_depth_mm)
#'
#' @export
grouped_main_stats <- function(data, grouping_var, num_var, na.rm=TRUE) {
  # Making the function to stop if the grouping variable is not categorical
  if(!is.factor(dplyr::pull(data, {{grouping_var}}))){ # need to pull th
    stop("`grouping_var` must be categorical ")
  }
  # Making the function to stop if the numerical variable is not numerical
  if(!is.numeric(dplyr::pull(data, {{num_var}}))){
    stop("`num_var` must be numerical ")
  }
  # Making the function to stop if the na.rm is not TRUE or FALSE
  if(!is.logical(na.rm)){
    stop("`na.rm` must be logical (TRUE or FALSE)")
  }

  summary <- data|> # making data set as first argument of the next
    dplyr::group_by({{grouping_var}})|> # grouping by the categorical variable
    # Making the summary table with mean, median, min and max
    dplyr::summarize("mean_{{num_var}}" := mean({{num_var}}, na.rm=na.rm), #AI was used here to make the title of each variable in the table since the paste function I originally used was producing an error, since I want to use mean + title of the numerical variable
              "median_{{num_var}}" := stats::median({{num_var}}, na.rm=na.rm),
              "min_{{num_var}}" := min({{num_var}}, na.rm=na.rm),
              "max_{{num_var}}" := max({{num_var}}, na.rm=na.rm))
  # making another output for making the histogram plot to show the distribution
  plot <- data|>
    ggplot2::ggplot(ggplot2::aes(x={{num_var}}, fill = {{grouping_var}}))+
    ggplot2::geom_histogram()

  print(summary)
  print(plot)
}
