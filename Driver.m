function[TestData, FitResults,SearchSegEnd] =  Driver(file, sheet, radius, vs, seg_sizes, skip, CSM, SS_fit)

TestData = LoadTest(file, sheet, radius, vs, skip, CSM);
SearchSegEnd = TestData.LoadSegmentEnd;
FitResults = SingleSearchAllSegments(seg_sizes, TestData, SearchSegEnd,SS_fit);
end