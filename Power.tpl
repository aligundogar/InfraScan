[out:json][timeout:120];

// 1. Native area filter for Russia (uppercase "Country")
area["boundary"="administrative"]["admin_level"="2"]["ISO3166-1"="{country}"]->.ctry;

// 2. Gather every substation feature
(
  node    ["power"="substation"](area.ctry);
  way     ["power"="substation"](area.ctry);
  relation["power"="substation"](area.ctry);
);

// 3. Return full tag sets and geometries for rendering
out body geom;
>;
out skel qt;
