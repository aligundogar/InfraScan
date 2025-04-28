[out:json][timeout:60];
area["ISO3166-1"="{country}"]["boundary"="administrative"]["admin_level"="2"]->.searchArea;
(
  node["man_made"="communications_tower"](area.searchArea);
  node["tower:type"="communication"](area.searchArea);
  node["telecom"](area.searchArea);
);
out body geom;
>;
out skel qt;
