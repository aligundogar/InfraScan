[out:json][timeout:120];
// Native area filter
area["ISO3166-1"="{country}"]["boundary"="administrative"]["admin_level"="2"]->.ctry;

// Industrial chemical facilities & oil sites
(
  // Chemical plants and works
  way["industrial"="chemical"](area.ctry);
  node["industrial"="chemical"](area.ctry);

  // Oil industry: extraction, mills, terminals
  way["industrial"="oil"](area.ctry);
  way["industrial"="oil_mill"](area.ctry);
  way["industrial"="petroleum_terminal"](area.ctry);
);
out body geom;
>;
out skel qt;