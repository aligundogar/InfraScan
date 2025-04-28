# 🌍 GeoIntel Extractor

**GeoIntel Extractor** is a simple Python tool that uses the Overpass API to pull critical infrastructure data (energy lines, hospitals, mines, etc.) for any country and converts it into KML files. You can then open the generated KMLs in Google Earth or any other GIS software to visualize and analyze.

---

## 🚀 Features

- Fetches OpenStreetMap data via the Overpass API  
- Converts OSM JSON to `.kml` with full geometries and tags  
- Template-based queries: drop your Overpass QL snippets in `templates/`  
- Country-wide extraction using ISO 3166-1 codes (e.g. `TR`, `DE`, `US`)  
- Outputs all KML files into `kml_outputs/` in a single run  

---

## 🛠️ Requirements

- Python 3.8+  
- [requests](https://pypi.org/project/requests/)  
- [simplekml](https://pypi.org/project/SimpleKML/)  

Install dependencies with:

```bash
pip install requests simplekml
```

---

## ⚙️ Installation & Setup

1. **Clone this repository**  
   ```bash
   git clone https://github.com/yourusername/geointel-extractor.git
   cd geointel-extractor
   ```
2. **Create your templates**  
   Put one `.tpl` file per category in the `templates/` folder. Each template must include the placeholder `{country}`.

3. **Run the script**  
   ```bash
   python main.py
   ```
4. **Enter your country code** (e.g. `TR`, `DE`, `BR`) when prompted.  
5. **View output**  
   All generated KMLs will appear in `kml_outputs/`.

---

## 📂 Project Structure

```
.
├── templates/         # Overpass QL template files (*.tpl)
│   ├── powerlines.tpl
│   ├── hospitals.tpl
│   └── mines.tpl
├── kml_outputs/       # Generated KML files (*.kml)
├── main.py            # Main script
└── README.md          # This document
```

---

## 📝 Template Example

Below is a sample template (`templates/nuclear.tpl`) that fetches all nuclear power plants and reactors in a given country:

```tpl
[out:json][timeout:60];
// select country boundary by ISO3166-1 code
area["ISO3166-1"="{country}"]["boundary"="administrative"]["admin_level"="2"]->.ctry;

(
  // nuclear power plants
  way["power"="plant"]["plant:source"="nuclear"](area.ctry);
  relation["plant:source"="nuclear"](area.ctry);

  // reactor generators
  node["generator:source"="nuclear"](area.ctry);
);

out body geom;
>;
// fetch member nodes for polygons
out skel qt;
```

**How it works**:  
- `{country}` is replaced by your input (e.g. `TR`, `US`)  
- `out body geom;` returns full geometries so polygons render correctly  
- `out skel qt;` pulls in member nodes for ways/relations

---

## ⚠️ Notes

- Very large or complex templates may hit Overpass API rate limits or timeouts. You can adjust the `[timeout:60]` value as needed.  
- Ensure each template uses the `{country}` placeholder exactly once in the `area[...]` filter.  
- You can mix `node`, `way`, and `relation` selectors in one template to capture points, polygons, and multipolygons.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

```

Feel free to adjust any wording or sections to suit your repository style before publishing!