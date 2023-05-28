
var jabar = boun.filter(ee.Filter.eq('ADM1_NAME', 'Jawa Barat'));


// Nighttime Data 2018
var dataset_18 = ee.ImageCollection('NOAA/VIIRS/DNB/MONTHLY_V1/VCMSLCFG')
                  .filter(ee.Filter.date('2018-01-01', '2018-12-31'));
var nighttime_18 = dataset_18.select('avg_rad');
var nighttimeVis = {min: 0.0, max: 60.0};

// Nighttime Data 2019
var dataset_19 = ee.ImageCollection('NOAA/VIIRS/DNB/MONTHLY_V1/VCMSLCFG')
                  .filter(ee.Filter.date('2019-01-01', '2019-12-31'));
var nighttime_19 = dataset_19.select('avg_rad');

// Nighttime Data 2020
var dataset_20 = ee.ImageCollection('NOAA/VIIRS/DNB/MONTHLY_V1/VCMSLCFG')
                  .filter(ee.Filter.date('2020-01-01', '2020-12-31'));
var nighttime_20 = dataset_20.select('avg_rad');

// Nighttime Data 2021
var dataset_21 = ee.ImageCollection('NOAA/VIIRS/DNB/MONTHLY_V1/VCMSLCFG')
                  .filter(ee.Filter.date('2021-01-01', '2021-12-31'));
var nighttime_21 = dataset_21.select('avg_rad');


// Crop Nighttime Data and Visualize It
Map.centerObject(jabar2, 8);

var jabar_NTL_18 = nighttime_18.mean().clip(jabar2);
Map.addLayer(jabar_NTL_18, nighttimeVis, 'Jabar NTL 18');

var jabar_NTL_19 = nighttime_19.mean().clip(jabar2);
Map.addLayer(jabar_NTL_19, nighttimeVis, 'Jabar NTL 19');

var jabar_NTL_20 = nighttime_20.mean().clip(jabar2);
Map.addLayer(jabar_NTL_20, nighttimeVis, 'Jabar NTL 20');

var jabar_NTL_21 = nighttime_21.mean().clip(jabar2);
Map.addLayer(jabar_NTL_21, nighttimeVis, 'Jabar NTL 21');


// REDUCER 2018
var reduced_18 = jabar_NTL_18.reduceRegions({
  collection: jabar2,
  reducer: ee.Reducer.mean(),
  scale: 100,
});

// REDUCER 2019
var reduced_19 = jabar_NTL_19.reduceRegions({
  collection: jabar2,
  reducer: ee.Reducer.mean(),
  scale: 100,
});

// REDUCER 2020
var reduced_20 = jabar_NTL_20.reduceRegions({
  collection: jabar2,
  reducer: ee.Reducer.mean(),
  scale: 100,
});

// REDUCER 2021
var reduced_21 = jabar_NTL_21.reduceRegions({
  collection: jabar2,
  reducer: ee.Reducer.mean(),
  scale: 100,
});

// print(reduced);


// Export to CSV 2018
Export.table.toDrive({
  collection: reduced_18,
  description: 'JABAR_NTL_2018',
  fileFormat: 'CSV',
  folder: 'content/drive/MyDrive/[01]Kelass/3SD1/Smt 6/Teknologi Big Data/Project UTS/'
});

// Export to CSV 2019
Export.table.toDrive({
  collection: reduced_19,
  description: 'JABAR_NTL_2019',
  fileFormat: 'CSV',
  folder: 'content/drive/MyDrive/[01]Kelass/3SD1/Smt 6/Teknologi Big Data/Project UTS/'
});

// Export to CSV 2020
Export.table.toDrive({
  collection: reduced_20,
  description: 'JABAR_NTL_2020',
  fileFormat: 'CSV',
  folder: 'content/drive/MyDrive/[01]Kelass/3SD1/Smt 6/Teknologi Big Data/Project UTS/'
});


// Export to CSV 2021
Export.table.toDrive({
  collection: reduced_21,
  description: 'JABAR_NTL_2021',
  fileFormat: 'CSV',
  folder: 'content/drive/MyDrive/[01]Kelass/3SD1/Smt 6/Teknologi Big Data/Project UTS/'
});


// Export to Visualize 2018
var jabarNTL18 = nighttime_18.mean().clip(jabar);
Export.image.toDrive({
  image: jabarNTL18,
  description: 'NTL_Jabar_18',
  region: jabar,
  scale : 100,
  folder: 'content/drive/MyDrive/[01]Kelass/3SD1/Smt 6/Teknologi Big Data/Project UTS/',
  maxPixels: 1e9
});

// Export to Visualize 2019
var jabarNTL19 = nighttime_19.mean().clip(jabar);
Export.image.toDrive({
  image: jabarNTL19,
  description: 'NTL_Jabar_19',
  region: jabar,
  scale : 100,
  folder: 'content/drive/MyDrive/[01]Kelass/3SD1/Smt 6/Teknologi Big Data/Project UTS/',
  maxPixels: 1e9
});


// Export to Visualize 2020
var jabarNTL20 = nighttime_20.mean().clip(jabar);
Export.image.toDrive({
  image: jabarNTL20,
  description: 'NTL_Jabar_20',
  region: jabar,
  scale : 100,
  folder: 'content/drive/MyDrive/[01]Kelass/3SD1/Smt 6/Teknologi Big Data/Project UTS/',
  maxPixels: 1e9
});


// Export to Visualize 2021
var jabarNTL21 = nighttime_21.mean().clip(jabar);
Export.image.toDrive({
  image: jabarNTL21,
  description: 'NTL_Jabar_21',
  region: jabar,
  scale : 100,
  folder: 'content/drive/MyDrive/[01]Kelass/3SD1/Smt 6/Teknologi Big Data/Project UTS/',
  maxPixels: 1e9
});
