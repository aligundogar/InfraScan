[out:json][timeout:60];
area["ISO3166-1"="{country}"]["boundary"="administrative"]["admin_level"="2"]->.searchArea;
(
  way["landuse"="industrial"](area.searchArea);
  relation["landuse"="industrial"](area.searchArea);

  way["industrial"](area.searchArea);
  relation["industrial"](area.searchArea);
);
out body geom;
>;
out skel qt;
