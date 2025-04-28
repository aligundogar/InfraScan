[out:json][timeout:60];
area["ISO3166-1"="{country}"]["boundary"="administrative"]["admin_level"="2"]->.ctry;
(
  // Underground & surface mines
  way["landuse"="mine"](area.ctry);
  way["industrial"="mine"](area.ctry);

  // Quarries (open-pit mining)
  way["landuse"="quarry"](area.ctry);

  // Specific resources (uranium, gold)
  way["landuse"="mine"]["resource"="uranium"](area.ctry);
  way["landuse"="mine"]["resource"="gold"](area.ctry);
  way["industrial"="mine"]["resource"="uranium"](area.ctry);
  way["industrial"="mine"]["resource"="gold"](area.ctry);
  
  // Also fetch relations if exist
  relation["landuse"="mine"](area.ctry);
  relation["industrial"="mine"](area.ctry);
  relation["landuse"="quarry"](area.ctry);
);
out body geom;
>;
out skel qt;
