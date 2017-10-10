% function[TestData, FitResults] =  Driver(file, sheet, radius, vs, seg_sizes, skip)
function[TestData] =  Driver(file, sheet, radius, vs, skip, seg_start, seg_end, limzerox, limx)

TestData = LoadTest(file, sheet, radius, vs, skip, seg_start, seg_end);
plotint(TestData, seg_start, seg_end, limx, limzerox);
% FitResults = SingleSearchAllSegments(seg_sizes, TestData);
end