[out:json][timeout:60];
area["ISO3166-1"="{country}"]["boundary"="administrative"]["admin_level"="2"]->.searchArea;
(
  node["amenity"="bank"](area.searchArea);
  way["amenity"="bank"](area.searchArea);
  relation["amenity"="bank"](area.searchArea);

  node["office"="financial"](area.searchArea);
  way["office"="financial"](area.searchArea);
  relation["office"="financial"](area.searchArea);
);
out body geom;
>;
out skel qt;
