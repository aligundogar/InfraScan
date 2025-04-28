[out:json][timeout:60];
// Define country boundary by ISO code
area["ISO3166-1"="{country}"]
  ["boundary"="administrative"]
  ["admin_level"="2"]->.ctry;

(
// Nuclear power plants
  way["power"="plant"]["plant:source"="nuclear"](area.ctry);
  relation["plant:source"="nuclear"](area.ctry);

// Reactor generators
  node["generator:source"="nuclear"](area.ctry);
);

out body geom;
>;
// Fetch member nodes
out skel qt;
