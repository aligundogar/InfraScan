[out:json][timeout:60];
area["ISO3166-1"="{country}"]["boundary"="administrative"]["admin_level"="2"]->.searchArea;
(
  node["power"="plant"](area.searchArea);
  way["power"="plant"](area.searchArea);
  relation["power"="plant"](area.searchArea);

  node["power"="substation"](area.searchArea);
  way["power"="substation"](area.searchArea);
  relation["power"="substation"](area.searchArea);

  node["power"="line"](area.searchArea);
  way["power"="line"](area.searchArea);
  relation["power"="line"](area.searchArea);
);
out body geom;
>;
out skel qt;
