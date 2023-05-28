var jabar_fao = fao.filter(ee.Filter.eq('ADM1_NAME', 'Jawa Barat'));

// Quality Assessment
var masking = function maskme(image) {
  var qa = image.select('QC_Day');
  var Mandatory = 1 << 1;
  var DataQuality = 1 << 3;
  var LSTerror = 1 << 7
  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
      .and(qa.bitwiseAnd(cirrusBitMask).eq(0));
  return image.updateMask(mask);
}

// Filetring
var LST_2018 = ee.ImageCollection("MODIS/006/MOD11A1")
             .filterDate('2018-01-01', '2018-12-31')
             .filterBounds(jabar_fao);
print(LST_2018)

var landSurfaceTemperatureVis = {
  min: 13000.0,
  max: 16500.0,
  palette: [
    '040274', '040281', '0502a3', '0502b8', '0502ce', '0502e6',
    '0602ff', '235cb1', '307ef3', '269db1', '30c8e2', '32d3ef',
    '3be285', '3ff38f', '86e26f', '3ae237', 'b5e22e', 'd6e21f',
    'fff705', 'ffd611', 'ffb613', 'ff8b13', 'ff6e08', 'ff500d',
    'ff0000', 'de0101', 'c21301', 'a71001', '911003'
  ],
};
// Visualization
Map.addLayer(LST_2018.mean().select('LST_Day_1km').clip(jabar), landSurfaceTemperatureVis, 'Daytime LST_mean');
Map.addLayer(LST_2018.median().select('LST_Day_1km').clip(jabar), landSurfaceTemperatureVis, 'Daytime LST_median');



// Scale to Kelvin and convert to Celsius, set image acquisition time.
var LST_2018 = LST_2018.map(function(img) {
  return img
    .multiply(0.02)
    .subtract(273.15)
    .copyProperties(img, ['system:time_start']);
});

// Export GeoTIFF Image Median 
Export.image.toDrive({
  image : LST_2018.median().clip(jabar_fao).select('LST_Day_1km'),
  description: 'LST_Jabar18_median',
  folder : 'content/drive/MyDrive/[01]Kelass/3SD1/Smt 6/Teknologi Big Data/Project UTS/',
  region: jabar_fao,
  scale : 100,
  maxPixels: 1e10
})

// Export GeoTIFF Image Mean
Export.image.toDrive({
  image : LST_2018.mean().clip(jabar_fao).select('LST_Day_1km'),
  description: 'LST_Jabar18_mean',
  folder : 'content/drive/MyDrive/[01]Kelass/3SD1/Smt 6/Teknologi Big Data/Project UTS/',
  region: jabar_fao,
  scale : 100,
  maxPixels: 1e10
})


// EXPORT CSV 

// REDUCER mean 2018
var reduced_mean = LST_2018.mean().reduceRegions({
  collection: jabar,
  reducer: ee.Reducer.mean(),
  scale: 100,
});


// Export to CSV 2018 mean
Export.table.toDrive({
  collection: reduced_mean,
  description: 'JABAR_LST_2018_mean',
  fileFormat: 'CSV',
  folder: 'content/drive/MyDrive/[01]Kelass/3SD1/Smt 6/Teknologi Big Data/Project UTS/'
});

// REDUCER median 2018
var reduced_med = LST_2018.median().reduceRegions({
  collection: jabar,
  reducer: ee.Reducer.median(),
  scale: 100,
});


// Export to CSV 2018 median
Export.table.toDrive({
  collection: reduced_med,
  description: 'JABAR_LST_2018_median',
  fileFormat: 'CSV',
  folder: 'content/drive/MyDrive/[01]Kelass/3SD1/Smt 6/Teknologi Big Data/Project UTS/'
});
