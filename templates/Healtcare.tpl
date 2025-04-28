[out:json][timeout:60];
area["ISO3166-1"="{country}"]["boundary"="administrative"]["admin_level"="2"]->.searchArea;
(
  node["amenity"="hospital"](area.searchArea);
  way["amenity"="hospital"](area.searchArea);
  relation["amenity"="hospital"](area.searchArea);

  node["healthcare"](area.searchArea);
  way["healthcare"](area.searchArea);
  relation["healthcare"](area.searchArea);
);
out body geom;
>;
out skel qt;
