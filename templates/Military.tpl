[out:json][timeout:120];

// 1. Resolve the country area based on administrative boundaries
area["ISO3166-1"="{country}"]["boundary"="administrative"]["admin_level"="2"]->.ctry;

// 2. Collect all military-related features within the country's boundaries
(
  // Broad military land use (areas, bases, etc.)
  way["landuse"="military"](area.ctry);
  relation["landuse"="military"](area.ctry);

  // Specific military features (installations, checkpoints, bunkers, etc.)
  node["military"](area.ctry);
  way["military"](area.ctry);
  relation["military"](area.ctry);
);

// 3. Output full geometry for mapping
out body geom;
>;
// 4. Retrieve member nodes of ways/relations
out skel qt;