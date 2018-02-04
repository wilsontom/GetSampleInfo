context('get-sample-info')

test_that('sample-info', {

  raw_file <- system.file('extdata/QC01.raw', package = 'GetSampleInfo')

  expect_true(is.data.frame(GetSampleInfo(raw_file)))

})
