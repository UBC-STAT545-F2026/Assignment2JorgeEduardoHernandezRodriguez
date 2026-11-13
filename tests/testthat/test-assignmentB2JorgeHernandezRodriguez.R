test_that("Testing if the grouped_main_stats works appropriately ",
          {
  expect_error(grouped_main_stats(palmerpenguins::penguins,species,sex), "must be numerical")
  expect_error(grouped_main_stats(palmerpenguins::penguins,species)) # test if no num_var is provided
  expect_error(grouped_main_stats(palmerpenguins::penguins, species, bill_depth_mm, na.rm = 0),
               "must be logical") #test if na.rm is not a TRUE/FALSE then a error is triggered.

  })
