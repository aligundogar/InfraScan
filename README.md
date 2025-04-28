# 🌐 InfraScan

**InfraScan** is a Python-based tool that fetches critical infrastructure data (power lines, hospitals, mines, government buildings, etc.) from OpenStreetMap using the Overpass API and generates KML files for easy visualization in GIS tools like Google Earth.

🔗 GitHub Repository: [aligundogar/InfraScan](https://github.com/aligundogar/InfraScan.git)

---

## 🚀 Features

- Extract infrastructure data with Overpass API

- Converts OSM JSON data into `.kml` files with coordinates and metadata

- Template-driven architecture: easily add new data types

- Supports any country via ISO 3166-1 code (e.g., `TR`, `DE`, `FR`)

- Organized KML outputs ready for mapping and analysis

---
## 🛠️ Requirements

- Python 3.8+
- [requests](https://pypi.org/project/requests/)
- [simplekml](https://pypi.org/project/SimpleKML/)

Install the dependencies with:

  ```bash

pip install requests simplekml

  ```
  
---

## ⚙️ Usage

1. **Clone the repository**

   ```bash
   git clone https://github.com/aligundogar/InfraScan.git
   cd InfraScan
   ```

2. **Prepare templates**

   Add Overpass QL `.tpl` files inside the `templates/` directory.  
   Each template must include `{country}` as a placeholder for ISO country codes.

3. **Run the tool**

   ```bash
   python main.py
   ```


4. **Enter the country code**
   Example: `TR` for Turkey, `US` for United States.

5. **Find KML outputs**
   All generated `.kml` files will be saved under the `kml_outputs/` folder.

---
## 📂 Project Structure

```

InfraScan/

├── templates/        # Overpass QL template files (*.tpl)

│   ├── power.tpl
│   ├── telecom.tpl
│   └── ...
├── kml_outputs/      # Generated KML files (*.kml)
├── main.py           # Main script
└── README.md         # This document

```
  
---
## 📄 Example Template
Example (`templates/water.tpl`):

```tpl
[out:json][timeout:60];
area["ISO3166-1"="{country}"]["boundary"="administrative"]["admin_level"="2"]->.searchArea;
(
  node["man_made"="water_works"](area.searchArea);
  node["man_made"="water_tower"](area.searchArea);
  node["man_made"="reservoir_covered"](area.searchArea);
);
out body geom;
>;
out skel qt;

```

✅ `{country}` is automatically replaced at runtime.  

---
## ⚡ Notes

- Overpass API may throttle large queries. Increase `[timeout:60]` if necessary.
- Templates must correctly define the search area using `{country}` to work.
- Both `node`, `way`, and `relation` objects are supported depending on infrastructure type.

---
## 📄 License

This project is licensed under the [MIT License](LICENSE).

---
## 👨‍💻 Author

Developed by [Salva (Ali Gündoğar)](https://github.com/aligundogar) 🇹🇷
