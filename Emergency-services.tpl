[out:json][timeout:60];
area["ISO3166-1"="{country}"]["boundary"="administrative"]["admin_level"="2"]->.searchArea;
(
  node["aeroway"="airport"](area.searchArea);
  node["railway"="station"](area.searchArea);
  node["amenity"="bus_station"](area.searchArea);
);
out body geom;
>;
out skel qt;
