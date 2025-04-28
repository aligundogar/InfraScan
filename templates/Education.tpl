[out:json][timeout:60];
area["ISO3166-1"="{country}"]["boundary"="administrative"]["admin_level"="2"]->.searchArea;
(
  node["amenity"="school"](area.searchArea);
  node["amenity"="university"](area.searchArea);
);
out body geom;
>;
out skel qt;
