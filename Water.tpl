[out:json][timeout:60];
area["ISO3166-1"="{country}"]["boundary"="administrative"]["admin_level"="2"]->.searchArea;
(
  node["man_made"="water_works"](area.searchArea);
  node["man_made"="water_tower"](area.searchArea);
  node["man_made"="reservoir_covered"](area.searchArea);
);
out body geom;
>;
out skel qt;
