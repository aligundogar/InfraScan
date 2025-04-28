[out:json][timeout:120];
area["ISO3166-1"="{country}"]["boundary"="administrative"]["admin_level"="2"]->.ctry;
(
  // Power transmission lines
  way["power"="line"](area.ctry);

  // Power network relations
  relation["type"="network"]["network"="power"](area.ctry);
);
out body geom;
>;
out skel qt;
