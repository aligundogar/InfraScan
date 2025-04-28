[out:json][timeout:60];
area["ISO3166-1"="{country}"]["boundary"="administrative"]["admin_level"="2"]->.ctry;
(
  // Onshore petroleum wells
  node["man_made"="petroleum_well"](area.ctry);

  // Offshore oil platforms
  node["man_made"="offshore_platform"](area.ctry);

  // Major pipelines
  way["man_made"="pipeline"](area.ctry);
  way["pipeline"](area.ctry);

  // Relations for larger pipeline networks
  relation["man_made"="pipeline"](area.ctry);
);
out body geom;
>;
out skel qt;
