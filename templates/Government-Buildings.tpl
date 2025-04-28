[out:json][timeout:60];
area["ISO3166-1"="{country}"]["boundary"="administrative"]["admin_level"="2"]->.searchArea;
(
  node["amenity"="townhall"](area.searchArea);
  way["amenity"="townhall"](area.searchArea);
  relation["amenity"="townhall"](area.searchArea);

  node["office"="government"](area.searchArea);
  way["office"="government"](area.searchArea);
  relation["office"="government"](area.searchArea);

  node["building"="public"](area.searchArea);
  way["building"="public"](area.searchArea);
  relation["building"="public"](area.searchArea);
);
out body geom;
>;
out skel qt;
